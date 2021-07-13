import 'package:flutter/material.dart';

class Divide extends StatelessWidget {
  const Divide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      height: 5,
      indent: 10,
      endIndent: 10,
    );
  }
}
