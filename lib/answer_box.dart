import 'package:flutter/material.dart';

// 答えのBOX
class AnswerBox extends Container {
  AnswerBox(int answer, int number, Function _onPressed)
      : super(
          color: Colors.green,
          padding: EdgeInsets.all(5),
          child: TextButton(
            onPressed: () => _onPressed(answer, number),
            style: ButtonStyle(foregroundColor:
                MaterialStateProperty.resolveWith<Color>((states) {
              /*
              // ボタンがタップされている時
              if (states.contains(MaterialState.pressed)) {
                // 緑色
                return Colors.green;
              }
              */
              return Colors.black;
            })),
            child: Text(
              '$number',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
}
