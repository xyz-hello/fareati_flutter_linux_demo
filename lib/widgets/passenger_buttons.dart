import 'package:flutter/material.dart';

class PassengerButtons extends StatelessWidget {
  final Function(int) onPressed;

  const PassengerButtons({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(9, (index) {
      final number = index + 1;
      return Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => onPressed(number),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            minimumSize: Size(85, 85),
          ),
          child: Text(
            '$number',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
    }),
  );
}
