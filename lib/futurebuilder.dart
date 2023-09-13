import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: FuturePage()));
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});



  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String resultText = '';

    Future<void> verzoegerung() async {
  

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      resultText = 'Hello, Future!';
   
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FutureBuilder Aufgaben')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextFuture(),
            const ImageFuture(),
            ElevatedButton(onPressed: () {verzoegerung();}, child: const Text('Push')),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}

class TextFuture extends StatelessWidget {
  const TextFuture({super.key});

  Future<List<String>> getTexts() async {
    await Future.delayed(const Duration(seconds: 3));
    return ['Text 1', 'Text 2', 'Text 3'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getTexts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Fehler: ${snapshot.error}');
        } else {
          final texts = snapshot.data;
          return Column(
            children: texts!.map((text) => Text(text)).toList(),
          );
        }
      },
    );
  }
}

class ImageFuture extends StatelessWidget {
  const ImageFuture({super.key});

  Future<List<String>> getImages() async {
    await Future.delayed(const Duration(seconds: 5));
    return ['Image 1', 'Image 2', 'Image 3'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Fehler: ${snapshot.error}');
        } else {
          final images = snapshot.data;
          return Column(
            children: images!.map((image) => Text(image)).toList(),
          );
        }
      },
    );
  }
}
