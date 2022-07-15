import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jot_it_app/Widgets/button_widget.dart';
import 'package:jot_it_app/Services/google_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication google = Authentication();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.purple[100],
            body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.only(left: 20, right: 20),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Jot It",
                          style: GoogleFonts.poppins(
                            color: Colors.deepPurple,
                            fontSize:50,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "\nYour notes in one place",
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                    InkWell(onTap: ()async{
                     await google.signInWithGoogle(context);
                    },child: const ButtonWidget(color: Colors.deepPurple, text: 'Sign in with Google', textColor: Colors.white70,)),
                    const SizedBox(height: 20,),
                    InkWell(onTap: (){
                    },child: const ButtonWidget(color: Colors.white70, text: 'Sign in with Facebook', textColor: Colors.deepPurple,)),

                  ],
                )
            ),
    );
    });
  }
}
