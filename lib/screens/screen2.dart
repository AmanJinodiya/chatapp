import 'package:chatapp/screens/screen3.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class screen2 extends StatefulWidget {
  final boss;
  const screen2({super.key, this.boss});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
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
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => screen3(
                                        id: document['id'],
                                        name: document['name'],
                                        me: widget.boss,
                                      )));
                        }),
                        child: ListTile(
                          leading: CircularProfileAvatar(
                            "",
                            child: Icon(Icons.person),
                            backgroundColor: Colors.grey,
                            elevation: 2,
                            radius: 20,
                          ),
                          title: Text(document['name']),
                          trailing: const Icon(
                            Icons.play_arrow,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
