import 'package:flutter/material.dart';

class StoryBox extends StatelessWidget {
  final DecorationImage? image;
  final Widget? fit;

  const StoryBox({
    super.key,
    this.image,
    this.fit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: image,
        border: Border.all(width: 4, color: Colors.red),
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
