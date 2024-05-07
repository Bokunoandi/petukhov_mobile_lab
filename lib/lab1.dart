import 'package:flutter/material.dart';

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab1(title: 'Петухов Андрій лабораторна робота 1'),
    );
  }
}

class MyLab1 extends StatefulWidget {
  const MyLab1({super.key, required this.title});

  final String title;

  @override
  State<MyLab1> createState() => _MyLab1PageState();
}

class _MyLab1PageState extends State<MyLab1> {
  bool _infoVisible = false;
  bool _isButtonVisible = true;

  void giveInfo() {
    setState(() {
      _infoVisible = true;
      _isButtonVisible = false;
    });
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
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Прізвище, ім'я та по батькові:\n Петухов Андрій Іванович \n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ), // Первая строка
            ),
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Назва спеціальності, на якій навчаєтесь:\nКопм'ютерні науки \n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ), // Вторая строка
            ),
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Номер курсу і групи:\n 4 курс, KH 20001Б \n ",
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
                "Чого хотіли би досягти в кінці цього \n навчального курсу:\nНавчитись розробляти зручні та красиві мобільні додатки \n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _isButtonVisible,
              child: ElevatedButton(
                onPressed: giveInfo,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 70)),
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
            ),

          ],
        ),
      ),
    );
  }
}