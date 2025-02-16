import 'package:cine_creators/utils/supabase_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<PostgrestList> handleGetAllPosts() async {
  final posts = await supabase.from("posts").select().order("created_at", ascending: false);
  return posts;
}

Future<PostgrestList> handleGetUserPosts(String userEmail) async {
  final posts = await supabase.from("posts").select().eq("user_id", userEmail).order("created_at", ascending: false);
  return posts;
}