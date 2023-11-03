import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class SingleLine extends StatefulWidget {
  const SingleLine({super.key});

  @override
  State<SingleLine> createState() => _SingleLineState();
}

class _SingleLineState extends State<SingleLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'your message',
        ),
        maxLines: 1,
      ),
    );
  }
}

class MultiText extends StatefulWidget {
  const MultiText({super.key});

  @override
  State<MultiText> createState() => _MultiTextState();
}

class _MultiTextState extends State<MultiText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              minLines: 2,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: 'Enter a Message',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
