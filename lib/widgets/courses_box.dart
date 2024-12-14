import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursesBox extends StatelessWidget {
  const CoursesBox({super.key, this.color, required this.text, this.decoration});

  final Color? color;
  final String text;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Center(
          child: Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500))),
    );
  }
}
