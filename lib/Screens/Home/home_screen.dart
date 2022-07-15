import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jot_it_app/Screens/Home/new_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewNote()));
        },
        child: const Icon(Icons.edit, color: Colors.white70,),
      ),
      body: Center(
        child: Text('Add new note', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 20),),
      ),
    );
  }
}
