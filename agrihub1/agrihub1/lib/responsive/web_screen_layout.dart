import 'package:flutter/material.dart';
// import 'dart:ffi';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('this is mobile'),
        ),
      ),
    );
  }
}
