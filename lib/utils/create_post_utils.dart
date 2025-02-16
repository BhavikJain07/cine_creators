import 'dart:io';
import 'package:file_picker/file_picker.dart';
import "package:cine_creators/utils/supabase_utils.dart";

Future<Map<String, Object>> handlePickPostImage() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) {
      return {"status": 0, "message": "No file selected"};
    } else {
      return {
        "status": 1,
        "message": "File selected",
        "path": result.files.single.path.toString(),
      };
    }
  } catch (error) {
    return {
      "status": 0,
      "message": error.toString(),
    };
  }
}

Future<Map> _uploadPostImage(String postImagePath) async {
  File postImage = File(postImagePath);
  final userId = supabase.auth.currentUser?.email;
  final postPath = "$userId/${postImage.path.split("/").last}";
  try {
    await supabase.storage
        .from("posts")
        .upload(postPath, postImage);
    return {"status": true, "path": postPath};
  } catch (err) {
    return {"status": false, "error": err.toString()};
  }
}

Future<Map<String, Object>> createPost(String content, String imagePath) async {
  try {
    final result = await _uploadPostImage(imagePath);
    if (result["status"]) {
      await supabase.from("posts").insert({
        "user_id": supabase.auth.currentUser?.email,
        "post_content": content.trim(),
        "post_image_link": supabase.storage.from("posts").getPublicUrl(result["path"])
      });
      return {
        "status": 1,
        "message": "Post created",
      };
    } else {
      return {
        "status": 0,
        "message": "Error creating post.",
      };
    }
  } catch (error) {
    return {
      "status": 0,
      "message": error.toString(),
    };
  }
}
