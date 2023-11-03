import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageContent extends StatelessWidget {
  final String messageId;

  const MessageContent({required this.messageId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Message Content'),
        centerTitle: false,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('message')
            .doc(messageId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.data!.data()
                as Map<String, dynamic>?; // Cast data to a Map

            if (data != null) {
              final messageContent = data['messagecontent'] as String?;
              return Center(
                child: Text(
                  messageContent ?? 'No message found',
                  style: const TextStyle(fontSize: 24.0),
                ),
              );
            }
          }
          return const Placeholder();
        },
      ),
    );
  }
}
