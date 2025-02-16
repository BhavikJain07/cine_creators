import 'package:cine_creators/pages/create_post.dart';
import 'package:cine_creators/pages/feed_page.dart';
import 'package:cine_creators/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_creators/pages/home_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <GoRoute>[
        GoRoute(
          path: "/signup",
          builder: (BuildContext context, GoRouterState state) {
            return SignupPage();
          },
        ),
        GoRoute(
          path: "/feed",
          builder: (BuildContext context, GoRouterState state) {
            return FeedPage();
          },
          routes: <GoRoute>[
            GoRoute(
              path: "/create",
              builder: (BuildContext context, GoRouterState state) {
                return CreatePost();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
