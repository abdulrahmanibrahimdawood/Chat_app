import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  CustomButon({super.key, this.onTap, required this.text});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 45,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Color(0xff2B475E), fontSize: 22),
          ),
        ),
      ),
    );
  }
}
