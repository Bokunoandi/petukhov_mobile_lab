import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Lab5 extends StatelessWidget {
  const Lab5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab5(title: 'Petukhov Andrii lab work 5'),
    );
  }
}

class MyLab5 extends StatefulWidget {
  const MyLab5({super.key, required this.title});

  final String title;

  @override
  State<MyLab5> createState() => _MyLab5PageState();
}

class _MyLab5PageState extends State<MyLab5> {
  List<File> images = [];
  int currentIndex = 0;
  double rotationAngle = 0.0;
  Timer? _timer;
  bool isAutoPlay = false;
  final ImagePicker _picker = ImagePicker();

  void startAutoPlay() {
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
    isAutoPlay = true;
  }

  void stopAutoPlay() {
    _timer?.cancel();
    isAutoPlay = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(isAutoPlay ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (isAutoPlay) {
                stopAutoPlay();
              } else {
                startAutoPlay();
              }
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showAboutDialog(
              context: context,
              children: [
                const Text('Розробник: Петухов Андрій'),
                Image.asset('assets/images/lab2me.jpg'), // Убедитесь, что путь к изображению верный
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.purple,
      body: images.isEmpty
          ? const Center(child: Text('Оберіть зображення'))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(80),
                minScale: 0.1,
                maxScale: 4.0,
                child: Transform.rotate(
                  angle: rotationAngle,
                  child: Image.file(images[currentIndex]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.rotate_left),
                  onPressed: () => setState(() {
                    rotationAngle -= math.pi / 2;
                  }),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: images.length > 1 ? showPreviousImage : null,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: images.length > 1 ? showNextImage : null,
                ),
                IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: () => setState(() {
                    rotationAngle += math.pi / 2;
                  }),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }

  void pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
        currentIndex = images.length - 1;
        rotationAngle = 0;  // Reset rotation when a new image is added
      });
    }
  }

  void showPreviousImage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void showNextImage() {
    if (currentIndex < images.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }
}
