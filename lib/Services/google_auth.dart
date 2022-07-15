import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jot_it_app/Screens/Home/home_screen.dart';

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('No user');
      } else {
        final GoogleSignInAuthentication _googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);
        final UserCredential authResult = await auth.signInWithCredential(credential);
        final User? user = authResult.user;
        var userData = {
          'name': user!.displayName,
          'provider': 'google',
          'photoUrl': user.photoURL,
          'email': user.email,
        };
        users.doc(user.uid).get().then((doc) {
          if (doc.exists) {
            // old user
            doc.reference.update(userData);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            users.doc(user.uid).set(userData);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        });
      }


    } catch (e) {
      print('Something went wrong: ' '${e.toString()}');
    }
  }
}