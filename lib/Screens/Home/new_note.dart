import 'package:flutter/material.dart';
import 'package:jot_it_app/Screens/Home/home_screen.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                Text(
                  'Note',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              child: Column(
                children: [
                  TextField(
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.green,
                    maxLines: null,
                    minLines: 30,
                    decoration: InputDecoration(
                      hintText: "Note something down",
                      hintStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w100),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
