import 'package:agrihub1/screens/add_post_screen.dart';
import 'package:agrihub1/screens/feed_screen.dart';
import 'package:agrihub1/screens/land_screen.dart';
import 'package:agrihub1/screens/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/profile_screen.dart';
// import 'dart:ffi';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  MessageScreen(),
  AddPostScreen(),
  LandScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
