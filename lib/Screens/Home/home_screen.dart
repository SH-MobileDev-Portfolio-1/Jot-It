import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jot_it_app/Screens/Home/new_note.dart';
import 'package:jot_it_app/Screens/Home/read_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference reference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color> noteColors = [
    Colors.white70,
    Colors.grey.shade200,
    Colors.cyan.shade200,
    Colors.deepPurple.shade100,
    Colors.white38,
    Colors.amber.shade100,
    Colors.indigo.shade100,
    Colors.white,
    Colors.pink.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes',  style: GoogleFonts.poppins(
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
        ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Icon',
            onPressed: () {},
          ), //Ic
        ],
      ),
      backgroundColor: Colors.purple[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewNote()));
        },
        child: const Icon(Icons.edit, color: Colors.white70,),
      ),
      body: FutureBuilder(
        future: reference.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('Tap icon to create note', style: GoogleFonts.poppins(
                    color: Colors.white70, fontSize: 20, shadows: [
                  const BoxShadow(
                    blurRadius: 10,
                    color: Colors.deepPurple,
                    offset: Offset(3, 3),
                  )
                ]),),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext ctx, index) {
                  Random random = Random();
                  Color color = noteColors[random.nextInt(4)];
                  Map data = snapshot.data.docs[index].data();
                  DateTime currentdateTime = data['created'].toDate();
                  String formattedTime = DateFormat.yMMMd().add_jm().format(
                      currentdateTime);

                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  ReadNote(data: data, reference:  snapshot.data.docs[index].reference, time: formattedTime)))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: color,
                      ),
                        padding: EdgeInsets.all(8.0),
                        height: MediaQuery.of(context).size.height,
                        width: 400,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Spacer(),
                              Text(
                                formattedTime,
                                style: GoogleFonts.poppins(
                                    fontSize: 15.0,
                                    color: Colors.black38
                                ),
                              )
                            ])

                    ),
                  );
                },
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(color: Colors.purple,));
          }
        } )
    );
  }
}
