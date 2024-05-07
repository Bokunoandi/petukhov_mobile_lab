import 'package:flutter/material.dart';
import 'dart:math' as math;

class Lab6 extends StatelessWidget {
  const Lab6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab6(title: 'Петухов Андрій самостійна робота'),
    );
  }
}

class MyLab6 extends StatefulWidget {
  const MyLab6({super.key, required this.title});

  final String title;

  @override
  State<MyLab6> createState() => _MyLab6PageState();
}

class _MyLab6PageState extends State<MyLab6> {
  List<int> _numbers = [];
  String _sortedNumbers = '';

  void _generateArray() {
    final random = math.Random();
    _numbers = List.generate(10, (_) => random.nextInt(100));
    _sortedNumbers = _numbers.join(', ');
  }

  void _bubbleSort() {
    List<int> nums = List.from(_numbers);
    for (int i = 0; i < nums.length - 1; i++) {
      for (int j = 0; j < nums.length - i - 1; j++) {
        if (nums[j] > nums[j + 1]) {
          int temp = nums[j];
          nums[j] = nums[j + 1];
          nums[j + 1] = temp;
        }
      }
    }
    _sortedNumbers = nums.join(', ');
  }

  void _selectionSort() {
    List<int> nums = List.from(_numbers);
    for (int i = 0; i < nums.length; i++) {
      int minIndex = i;
      for (int j = i + 1; j < nums.length; j++) {
        if (nums[j] < nums[minIndex]) {
          minIndex = j;
        }
      }
      if (minIndex != i) {
        int temp = nums[i];
        nums[i] = nums[minIndex];
        nums[minIndex] = temp;
      }
    }
    _sortedNumbers = nums.join(', ');
  }

  void _insertionSort() {
    List<int> nums = List.from(_numbers);
    for (int i = 1; i < nums.length; i++) {
      int key = nums[i];
      int j = i - 1;
      while (j >= 0 && nums[j] > key) {
        nums[j + 1] = nums[j];
        j = j - 1;
      }
      nums[j + 1] = key;
    }
    _sortedNumbers = nums.join(', ');
  }

  void _quickSort(List<int> nums, int low, int high) {
    if (low < high) {
      int pivotIndex = _partition(nums, low, high);
      _quickSort(nums, low, pivotIndex - 1);
      _quickSort(nums, pivotIndex + 1, high);
    }
  }

  int _partition(List<int> nums, int low, int high) {
    int pivot = nums[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (nums[j] < pivot) {
        i++;
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
      }
    }
    int temp = nums[i + 1];
    nums[i + 1] = nums[high];
    nums[high] = temp;
    return i + 1;
  }

  @override
  void initState() {
    super.initState();
    _generateArray();
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
            Text('Numbers: $_sortedNumbers'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _generateArray();
                });
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
              child: Text('Створити масів'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _bubbleSort();
                });
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
              child: Text('сортування бульбашкою'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectionSort();
                });
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
              child: Text('Сортування вибору'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _insertionSort();
                });
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
              child: Text('Сортування вставкою'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  List<int> nums = List.from(_numbers);
                  _quickSort(nums, 0, nums.length - 1);
                  _sortedNumbers = nums.join(', ');
                });
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
              child: Text('Швидке сортування'),
            ),
          ],
        ),
      ),
    );
  }
}