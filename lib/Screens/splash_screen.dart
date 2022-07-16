import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:jot_it_app/Screens/Authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 10), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));

    });
  }
 @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
   builder: (context, child) {
        return Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Jot',
                    style: GoogleFonts.poppins( color: Colors.white70, fontSize: 40.0,fontWeight: FontWeight.bold,),

                  ),
                  Text(
                      'It',
                      style: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 40.0,fontWeight: FontWeight.bold,),
                  ),],),

              const SizedBox(height: 20,),


              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              )



            ],


          ),



        ),
      );
      } );
  }
}
