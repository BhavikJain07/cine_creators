import 'package:flutter/material.dart';
import 'package:cine_creators/subpages/feed_component.dart';
import 'package:cine_creators/subpages/profile_component.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_creators/utils/auth_utils.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int selectedIndex = 0;
  final List<BottomNavigationBarItem> _navigationItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.house), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_2_rounded), label: "Profile"),
  ];

  final List<Widget> _components = <Widget>[
    FeedComponent(),
    ProfileComponent(),
  ];

  Future<void> _handleSignOutUser() async {
    final result = await handleSignOutUser();
    if (result["status"] == 1) {
      context.go("/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to Sign Out User"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.flutter_dash),
          title: Text("Cine Creators"),
          centerTitle: false,
          elevation: 10,
          actions: [
            IconButton(
              onPressed: _handleSignOutUser,
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: _components[selectedIndex],
        floatingActionButton: FloatingActionButton(
          tooltip: "New Post",
          onPressed: () {
            context.go("/feed/create");
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          items: _navigationItems,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      );
  }
}
