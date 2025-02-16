import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_creators/utils/auth_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hidePassword = true;
  bool isLoading = false;
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  Future<bool> _handleSignInUser() async {
    setState(() {
      isLoading = true;
    });
    String email = _emailTextEditingController.text.trim();
    String password = _passwordTextEditingController.text.trim();
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email or password cannot be empty"),
        ),
      );
      setState(() {
        isLoading = false;
      });
      return false;
    }
    final result = await handleSignInUser(email, password);
    if (result["status"] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signed in successfully."),
        ),
      );
      setState(() {
        isLoading = false;
      });
      context.go("/feed");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to Sign In."),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Cine Creators"),
          leading: Icon(Icons.flutter_dash),
          elevation: 10,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.flutter_dash),
                Text("Welcome to Siri AI"),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _emailTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Email",
                    prefix: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordTextEditingController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Password",
                    prefix: Icon(Icons.lock),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: hidePassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: isLoading ? null : _handleSignInUser,
                  child: isLoading
                      ? CircularProgressIndicator.adaptive()
                      : Text("Sign In"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("New to Cine Creators?"),
                TextButton(
                  onPressed: isLoading ? null : () => context.go("/signup"),
                  child: Text("Create Account"),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
