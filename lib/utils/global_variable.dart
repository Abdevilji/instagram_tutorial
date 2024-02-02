import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_tutorial/providers/user_providers.dart';
import 'package:provider/provider.dart';
import 'package:instagram_tutorial/screens/add_post_screen.dart';
import 'package:instagram_tutorial/screens/feed_screen.dart';
// import 'package:instagram_clone_flutter/screens/profile_screen.dart';
// import 'package:instagram_clone_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [

  const FeedScreen(),
  const Text("search"),
  // Text("post"),
  // Text("notification"),

  // const FeedScreen(),
  // const SearchScreen(),
  const AddPostScreen(),

  const Text('notifications'),
  const Text("profile"),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];