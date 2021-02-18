import 'package:flutter/material.dart';

class ResDisplay extends StatelessWidget {
  final text;

  ResDisplay({
    @required this.text
  });

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: 120,
      color: Colors.black54,
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(right: 20, bottom: 2),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 46
          ),
        ),
      ),
    );
  }
}