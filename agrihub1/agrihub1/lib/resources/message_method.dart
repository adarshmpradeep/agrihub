import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageMethod extends StatelessWidget {
  final String documentId;
  MessageMethod({required this.documentId});
  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference messages =
        FirebaseFirestore.instance.collection('message');
    return FutureBuilder<DocumentSnapshot>(
      future: messages.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['messagecontent']}');
        }
        return Text('loading....');
      }),
    );
  }
}
