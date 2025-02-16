import "package:cine_creators/utils/supabase_utils.dart";
import "package:supabase_flutter/supabase_flutter.dart";

Future<Map<String, Object>> handleSignInUser(
    String email, String password) async {
  try {
    final AuthResponse res = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (res.user != null) {
      return {"status": 1, "message": "Signed in successfully"};
    } else {
      return {
        "status": 0,
        "message": "Failed to Sign In user",
        "error": "Supabase error",
      };
    }
  } catch (error) {
    return {
      "status": 0,
      "message": "Failed to Sign In user",
      "error": error.toString()
    };
  }
}

Future<Map<String, Object>> handleSignUpUser(
    String email, String password) async {
  try {
    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password);
    if (res.user != null) {
      return {"status": 1, "message": "Signed in successfully"};
    } else {
      return {
        "status": 0,
        "message": "Failed to Sign In user",
        "error": "Supabase error",
      };
    }
  } catch (error) {
    return {
      "status": 0,
      "message": "Failed to Sign In user",
      "error": error.toString()
    };
  }
}

Future<Map<String, Object>> handleSignOutUser() async {
  try {
    await supabase.auth.signOut();
    return {"status": 1, "message": "Signed out successfully"};
  } catch (error) {
    return {
      "status": 0,
      "message": "Failed to Sign Out",
      "error": error.toString(),
    };
  }
}
