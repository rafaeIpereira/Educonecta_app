import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxCourses extends StatefulWidget {
  const BoxCourses({super.key});

  @override
  State<BoxCourses> createState() => _BoxCoursesState();
}

class _BoxCoursesState extends State<BoxCourses> {
  final List<String> categories = ['All', 'UI/UX', 'Illustration', '3D Animation'];
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 95,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
    );
  }
}