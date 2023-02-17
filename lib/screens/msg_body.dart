import 'package:flutter/material.dart';

class msgbody extends StatelessWidget {
  final who, msg, pesone, name;
  const msgbody({super.key, this.who, this.msg, this.pesone, this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: (who) ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              (who) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              (who) ? pesone : name,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Container(
                constraints: BoxConstraints(minWidth: 50),
                decoration: BoxDecoration(
                    color: (who) ? Colors.blue[100] : Colors.purple[100],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(msg),
                )),
          ],
        ),
      ),
    );
  }
}
