import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({super.key, required this.textInputType, required this.textEditingController,required this.hintText, this.isPass=false});

  @override
  Widget build(BuildContext context) {
    final inputBorder =OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return  TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText ,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
        keyboardType: textInputType ,
        obscureText: isPass ,
    );
  }
}
