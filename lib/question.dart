import 'dart:math' as math;

class Question {
  late int _left; // 計算式の右
  late int _right; // 計算式の左
  late bool _isPlus; // +記号か?
  late int _answer; // 答え
  final List<int> _choices = <int>[]; // 選択肢

  // GETTER
  int get answer => _answer;
  List<int> get choices => _choices;

  Question() {
    var rand = new math.Random();
    do {
      _left = rand.nextInt(10); // 0～9
      _right = rand.nextInt(10); // 0～9
      _isPlus = rand.nextBool();
      _answer = _isPlus ? _left + _right : _left - _right;
    } while (_answer < 0); // 答えがマイナスになる時はやり直し

    // 答えの選択肢リスト (±3の範囲の答えを用意)
    List<int> list = <int>[];
    for (int i = 1; i <= 3; i++) {
      list.add(_answer + i);
      if (_answer - i >= 0) {
        list.add(_answer - i);
      }
    }

    // 正解と他の選択肢を3つ用意
    _choices.add(_answer);
    for (int i = 0; i < 3; i++) {
      if (list.length == 1) {
        _choices.add(list[0]);
        break;
      }
      int index = rand.nextInt(list.length - 1);
      _choices.add(list[index]);
      list.removeAt(index);
    }

    // シャッフル
    _choices.shuffle();
  }

  // 問題の文字列
  String getQuestionString() {
    return _isPlus ? '$_left + $_right' : '$_left - $_right';
  }
}
