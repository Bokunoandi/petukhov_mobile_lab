import 'package:flutter/cupertino.dart';

class ResultModel with ChangeNotifier {
  double _result = 0;

  double get result => _result;

  void setResult(double newValue) {
    _result = newValue;
    notifyListeners();
  }
}
