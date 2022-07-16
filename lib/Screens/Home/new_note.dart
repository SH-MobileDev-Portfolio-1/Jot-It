import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jot_it_app/Screens/Home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  String? title;
  String? note;

  void sendToDb() async{
    CollectionReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': note,
      'created': DateTime.now(),
    };

    reference.add(data);
    Navigator.pop(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          setState(() {
            sendToDb();

          });
        },
        child: const Icon(Icons.send, color: Colors.white70,),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20,left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()));
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Center(
                    child: Text(
                      'Jot It',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white70,
                        shadows: [
                          const BoxShadow(
                            blurRadius: 10,
                            color: Colors.deepPurple,
                            offset: Offset(3, 3),
                          )
                        ]
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                child: Column(
                  children: [
                    TextFormField(
                      style:GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[300]),
                      cursorColor: Colors.deepPurple,
                      onChanged: (value){
                        title = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle:
                            GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      style:GoogleFonts.poppins(color: Colors.grey[300]),
                      cursorColor: Colors.deepPurple,
                      maxLines: null,
                      minLines: 30,
                      onChanged: (value){
                        note = value;
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: "Note something down...",
                        hintStyle:
                            GoogleFonts.quicksand(fontSize: 17, fontWeight: FontWeight.w100,color: Colors.white),
                        border: InputBorder.none,

                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
