import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool obscureText;
  final TextEditingController controller;

  const TextFieldForm(
      {super.key,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.preffixIcon,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          hintStyle: hintStyle,
          hintText: hintText,
          suffix: suffixIcon,
          prefixIcon: preffixIcon,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
