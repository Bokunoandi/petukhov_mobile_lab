import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';

class Lab4 extends StatelessWidget {
  const Lab4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab4(title: 'Петухов Андрій лабораторна робота 4'),
    );
  }
}

class MyLab4 extends StatefulWidget {
  const MyLab4({super.key, required this.title});

  final String title;

  @override
  State<MyLab4> createState() => _MyLab4PageState();
}

class _MyLab4PageState extends State<MyLab4> {
  late Future<String> _fileContentFuture;
  late Future<List<FlSpot>> _pointsFuture;
  @override
  void initState() {
    super.initState();
    _fileContentFuture = readValues();
    _pointsFuture = getPoints();
  }
  Future<List<FlSpot>> getPoints() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/tabulated_values.txt');
    List<FlSpot> points = [];
    if (await file.exists()) {
      final lines = await file.readAsLines();
      for (final line in lines) {
        final parts = line.split(', ');
        if (parts.length == 2) {
          final x = double.tryParse(parts[0]);
          final y = double.tryParse(parts[1]);
          if (x != null && y != null) {
            points.add(FlSpot(x, y));
          }
        }
      }
    }
    return points;
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tabulated_values.txt');
  }

  Future<String> readValues() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return 'Треба зробити лабораторну 3';
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Табуляція'),
              Tab(text: 'Графік'),
            ],
          ),
        ),
        backgroundColor: Colors.purple,
        body: TabBarView(
          children: [
          FutureBuilder<String>(
          future: _fileContentFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Треба зробити 3 лаб.');
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Text(snapshot.data ?? 'Немає даних'),
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
            FutureBuilder<List<FlSpot>>(
              future: _pointsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Треба зробити 3 лаб'));
                } else if (snapshot.hasData) {
                  return LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(spots: snapshot.data!),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('Нема даних для створення графіку'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}