import 'package:calculation_quiz/answer_box.dart';
import 'package:calculation_quiz/question.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '計算問題',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _questionCount = 0; // 問題数
  int _correctCount = 0; // 正解数
  late Question _question; // 問題

  @override
  void initState() {
    super.initState();
    createQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //color: Colors.black,
          width: 500.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              headContainer(),
              quizContainer(),
              answerContainer(),
              footContainer(),
            ],
          ),
        ),
      ),
    );
  }

  // 問題作成
  void createQuestion() {
    setState(() {
      _questionCount++;
      _question = new Question();
    });
  }

  // ヘッダーのコンテナ
  Widget headContainer() {
    return Container(
      //color: Colors.yellow,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: const Border(
          bottom: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('第$_questionCount問'),
          Text('正解数 $_correctCount'),
        ],
      ),
    );
  }

  // フッターのコンテナ
  Widget footContainer() {
    return Container(
      color: Colors.yellow,
      margin: EdgeInsets.only(top: 50),
      //child: Text('foot'),
    );
  }

  // 問題のコンテナ
  Widget quizContainer() {
    return Container(
      color: Colors.blue,
      width: 200.0,
      height: 100.0,
      margin: EdgeInsets.only(
        top: 30,
        bottom: 30,
      ),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text(
        _question.getQuestionString(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 32,
        ),
      ),
    );
  }

  // 答えのコンテナ
  Widget answerContainer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnswerBox(_question.answer, _question.choices[0], _onAnswerPressed),
          AnswerBox(_question.answer, _question.choices[1], _onAnswerPressed),
          AnswerBox(_question.answer, _question.choices[2], _onAnswerPressed),
          AnswerBox(_question.answer, _question.choices[3], _onAnswerPressed),
        ],
      ),
    );
  }

  // 答えを選択
  void _onAnswerPressed(int answer, int number) async {
    var message;
    if (answer == number) {
      print('正解');
      message = '正解';
      _correctCount++;
    } else {
      print('不正解');
      message = '不正解';
    }

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );

    createQuestion();
  }
}
