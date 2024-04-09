import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;   
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 12), 
      decoration:  InputDecoration(
        
        enabledBorder: const OutlineInputBorder(
          borderRadius:  BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: Colors.white)
        ),
        focusedBorder:  const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white)
        ),
        fillColor: Colors.white,
        filled: true,
        hintText:  hintText, 
        hintStyle:  TextStyle(color: Colors.grey, fontSize: 12),
      ),
      );
  }
}