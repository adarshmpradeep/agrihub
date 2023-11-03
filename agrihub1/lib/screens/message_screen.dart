import 'package:agrihub1/resources/message_method.dart';
import 'package:agrihub1/screens/message_content.dart';
import 'package:agrihub1/screens/message_send_screen.dart';
import 'package:agrihub1/widgets/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Document IDs
  List<String> messageIDs = [];

  // Get message IDs
  Future<void> getmessageIDs() async {
    await FirebaseFirestore.instance.collection('message').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              messageIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Message'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getmessageIDs(),
                builder: ((context, snapshot) {
                  return ListView.builder(
                    itemCount: messageIDs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.green,
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: MessageMethod(
                                  documentId:
                                      messageIDs[index]), // Pass the documentId
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MessageContent(
                                        messageId: messageIDs[
                                            index]), // Pass the documentId to MessageContent
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      );
                    },
                  );
                }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MessageSendScreen(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
