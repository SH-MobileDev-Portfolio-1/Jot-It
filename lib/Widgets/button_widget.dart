import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;

  const ButtonWidget({Key? key,
    required this.color,
    required this.text,
    required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height/14,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Center(
        child: Text(text, style: GoogleFonts.poppins(
            fontSize: 14, color: textColor, fontWeight: FontWeight.bold
        )),
      ),
    );
  }
}
