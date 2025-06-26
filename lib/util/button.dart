import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({super.key, required this.text, required this.onPressed});

  final String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 92, 74, 51),
      child: Text(
        text,
        style: GoogleFonts.indieFlower(
          //fontStyle: FontStyle.italic,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
