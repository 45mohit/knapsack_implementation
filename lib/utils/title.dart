import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Knap',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'Sack',
              style: TextStyle(color: Color(0xffFFA200), fontSize: 45),
            ),
          ]),
    );
  }
}
