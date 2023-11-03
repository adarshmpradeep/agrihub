import 'package:agrihub1/widgets/more.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MultiText()))
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        title: Text(
          'Updates from Krishibhavan',
          style: TextStyle(
              fontSize: 10,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
