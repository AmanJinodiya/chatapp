import 'package:chatapp/screens/msg_body.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class screen3 extends StatefulWidget {
  final id, name, me;
  const screen3({super.key, required this.id, this.name,this.me});

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  final _messagecontroller = TextEditingController();
  send_mes() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.id)
        .collection("cha")
        .add({
      "msg": _messagecontroller.text,
      "time": FieldValue.serverTimestamp(),
      "byme": true
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Messages")),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(widget.id)
                    .collection("cha")
                    .orderBy('time')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: msgbody(
                            who: document['byme'],
                            msg: document['msg'],
                            pesone: widget.me,
                            name: widget.name,
                          ));
                    }).toList(),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _messagecontroller,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
                          border: InputBorder.none,
                          hintText: 'Enter Message',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: send_mes,
                      child: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
          ],
        ),
      )),
    );
  }
}
