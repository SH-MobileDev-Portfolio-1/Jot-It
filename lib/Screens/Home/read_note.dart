import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class ReadNote extends StatefulWidget {

  const ReadNote({Key? key, required this.data, required this.reference, required this.time}) : super(key: key);
  final Map data;
  final String time;
  final DocumentReference reference;

  @override
  _ReadNoteState createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {
  String? title;
  String? note;
  bool editNote = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void updateDb() async {
    if (formKey.currentState!.validate()) {
      await widget.reference.update(
        {'title': title, 'description': note},
      );
      Navigator.pop(context);
    }
  }
  void deleteNote() async {
    await widget.reference.delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],

      floatingActionButton: editNote
          ? FloatingActionButton(
        onPressed: updateDb,
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.save_alt_outlined,
          color: Colors.white,
        ),
      )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      deleteNote();
                    },
                    icon: const Icon(Icons.delete, color: Colors.white,),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        editNote = !editNote;
                      });
                      updateDb();
                    },
                    icon: const Icon(Icons.edit, color: Colors.white,),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Text(widget.time, style: GoogleFonts.poppins(color: Colors.white),),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style:GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[300]),
                        cursorColor: Colors.deepPurple,
                        enabled: editNote,
                        onChanged: (value){
                          title = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter required field";
                          } else {
                            return null;
                          }
                        },
                        initialValue: widget.data['title'],
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
                        enabled: editNote,
                        onChanged: (value){
                          note = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter required field";
                          } else {
                            return null;
                          }
                        },
                        initialValue: widget.data['description'],

                        decoration: InputDecoration.collapsed(
                          hintText: "Note something down...",
                          hintStyle:
                          GoogleFonts.quicksand(fontSize: 17, fontWeight: FontWeight.w100,color: Colors.white),
                          border: InputBorder.none,

                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
