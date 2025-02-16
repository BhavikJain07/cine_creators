import 'package:cine_creators/components/post_component.dart';
import 'package:flutter/material.dart';
import 'package:cine_creators/utils/feed_utils.dart';

class ProfileComponent extends StatefulWidget {
  const ProfileComponent({super.key});

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  List<Post> _posts = <Post>[];

  @override
  void initState() {
    handleFetchPosts();
    super.initState();
  }

  Future<void> handleFetchPosts() async {
    final data = await handleGetAllPosts();
    final List<Post> posts = <Post>[];
    for (int i = 0; i < data.length; i++) {
      posts.add(Post(
          author: data[i]["user_id"],
          url: data[i]["post_image_link"],
          content: data[i]["post_content"]));
    }
    setState(() {
      _posts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RefreshIndicator(
        onRefresh: handleFetchPosts,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_2_rounded),
              ),
              title: Text("UserName"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return postComponent(index, _posts[index].author,
                      _posts[index].content, _posts[index].url);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget postComponent(int index, String author, String content, String url) {
    return ListTile(
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          ),
          SizedBox(
            width: 10,
          ),
          Text(author),
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(url),
            SizedBox(
              height: 5,
            ),
            Text(content),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
