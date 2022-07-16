import 'package:flutter/material.dart';
import 'package:jot_it_app/Screens/splash_screen.dart';
import'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const JotItApp());
}

class JotItApp extends StatelessWidget {
  const JotItApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jot It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreen(),
    );
  }
}

