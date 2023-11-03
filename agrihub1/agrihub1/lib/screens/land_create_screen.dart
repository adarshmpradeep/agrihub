import 'package:flutter/material.dart';

class LandSearchScreen extends StatelessWidget {
  const LandSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('create land'),
        centerTitle: false,
      ),
    );
  }
}
