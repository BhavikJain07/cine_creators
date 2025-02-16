import 'dart:io';
import 'package:cine_creators/utils/create_post_utils.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  bool isLoading = false;
  String postImagePath = "";
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _handlePickPostImage() async {
    setState(() {
      isLoading = true;
      postImagePath = "";
    });
    final result = await handlePickPostImage();
    if (result["status"] == 1) {
      setState(() {
        postImagePath = result["path"].toString();
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No Image Selected"),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleCreatePost() async {
    setState(() {
      isLoading = true;
    });
    final result = await createPost(_contentController.text, postImagePath);
    if (result["status"] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Post Created"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error Creating Post"),
        ),
      );
    }
    setState(() {
      isLoading = false;
      _contentController.clear();
      postImagePath = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text("Create Post"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  TextField(
                    controller: _contentController,
                    minLines: 5,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("Post Content"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  postImagePath == ""
                      ? SizedBox()
                      : Image.file(
                          File(postImagePath),
                        ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: IconButton.filledTonal(
                    onPressed: _handlePickPostImage,
                    icon: Icon(Icons.image),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: isLoading ? null : _handleCreatePost,
          child: isLoading ? CircularProgressIndicator.adaptive() : Icon(Icons.check),
        ),
      )
    ;
  }
}
