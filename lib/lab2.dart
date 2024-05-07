import 'dart:math';
import 'package:flutter/material.dart';
import 'package:petukhov_mobile_labs/provider/ResultModel.dart';
import 'package:provider/provider.dart';

class Lab2 extends StatelessWidget {
  const Lab2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab2(title: 'Петухов Андрій лабораторна робота 2'),
    );
  }
}

class MyLab2 extends StatefulWidget {
  const MyLab2({super.key, required this.title});

  final String title;

  @override
  State<MyLab2> createState() => _MyLab2PageState();
}

class _MyLab2PageState extends State<MyLab2> {
  bool _infoVisible = false;
  bool _answerVisible = false;
  bool _isButtonVisible = true;
  String _answer = "";

  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _zController = TextEditingController();

  void outputResponse() {
    getAnswer();
    setState(() {
      _answerVisible = true;
    });
  }

  void getInfo() {
    setState(() {
      _infoVisible = true;
      _isButtonVisible = false;
    });
  }

  bool getAnswer() {
    // Считывание и парсинг данных из контроллеров
    try {
      double x = double.parse(_xController.text);
      double y = double.parse(_yController.text);
      double a = double.parse(_aController.text);
      double z = double.parse(_zController.text);
      double result = calculateN(x, y, a, z);
      Provider.of<ResultModel>(context, listen: false).setResult(result.toDouble());
      setState(() {
        _answer = "Answer is: $result";
      });
      return true;
    } catch (e) {
      _answer = "Incorrectly entered values";
      return false;
    }
  }

  double calculateN(double x, double y, double a, double z) {
    double numerator = pow(z, 1 / 5) + sqrt(z * x);
    double denominator = exp(x) + pow(a, 5) * atan(x);
    if (denominator == 0) {
      throw Exception('Denominator cannot be zero');
    }
    return numerator / denominator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Варіант 21",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset('assets/images/lab2image.jpg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _xController,
                decoration: const InputDecoration(
                  labelText: 'Напишіть x',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _yController,
                decoration: const InputDecoration(
                  labelText: 'Напишіть y',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _aController,
                decoration: const InputDecoration(
                  labelText: 'Напишіть a',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _zController,
                decoration: const InputDecoration(
                  labelText: 'Напишіть z',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: _answerVisible,
              child: Text(
                _answer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                outputResponse();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100, 30)),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                "Натисни для отримання інформації",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Я Петухов Андрій та я студент комп'ютерних наук, у групі КН 20001Б",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _infoVisible,
              child: SizedBox(
                width: 190.0,
                height: 190.0,
                child: Image.asset('assets/images/lab2me.jpg'),
              ),
            ),
            Visibility(
              visible: _isButtonVisible,
              child: ElevatedButton(
                onPressed: getInfo,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(100, 30)),
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Click for info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _aController.dispose();
    _zController.dispose();
    super.dispose();
  }
}
