import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:futureaufgaben/futurebuilder.dart';

void main() {
  runApp(const MaterialApp(home: MyScreen()));
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String resultText = 'Zufallswiedergabe';
  bool isLoading = false;
  String errorText = '';
  double timeoutValue = 5.0;
  double delayValue = 5.0;

  Future<void> verzoegerung() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: delayValue.toInt()));

    setState(() {
      resultText = 'Hello, FutureBuilder!';
      isLoading = false;
    });
  }

  Future<int> generateRandomNumber() async {
    setState(() {
      isLoading = true;
    });

    final randomNumber = Random().nextInt(100) + 1;

    await Future.delayed(Duration(seconds: delayValue.toInt()));

    setState(() {
      resultText = 'Zufällige Zahl: $randomNumber';
      isLoading = false;
    });

    return randomNumber;
  }

  Future<void> generateRandomError() async {
    setState(() {
      isLoading = true;
      errorText = '';
    });

    final random = Random();
    if (random.nextBool()) {
      await Future.delayed(Duration(seconds: delayValue.toInt()));
      const errorMessage = 'Ein zufälliger Fehler ist aufgetreten.';
      setState(() {
        resultText = 'Fehler: $errorMessage';
        errorText = errorMessage;
        isLoading = false;
      });
      throw Exception(errorMessage);
    }

    setState(() {
      resultText = 'Kein Fehler aufgetreten.';
      isLoading = false;
    });
  }

  Future<void> generateTimeoutError() async {
    setState(() {
      isLoading = true;
      errorText = '';
    });

    await Future.delayed(Duration(seconds: timeoutValue.toInt())); // Timeout entsprechend des ausgewählten Werts

    setState(() {
      resultText = 'Keine Zeitüberschreitung.';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future Aufgaben')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            
            ElevatedButton(
              onPressed: () {
                verzoegerung();
              },
              child: const Text('Aufgabe 1: verzoegerung'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateRandomNumber();
              },
              child: const Text('Aufgabe 2: Zufällige Zahl'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  generateRandomError();
                } catch (error) {
                  debugPrint('Fehlerbehandlung: $error');
                  setState(() {
                    resultText = 'Fehlerbehandlung: $error';
                    errorText = error.toString();
                  });
                }
              },
              child: const Text('Aufgabe 3: Zufälliger Fehler'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateTimeoutError();
              },
              child: const Text('Aufgabe 4: Timeout Fehler'),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorText.isNotEmpty)
              Text(
                errorText,
                style: const TextStyle(fontSize: 24, color: Colors.red),
              )
            else
              Text(
                resultText,
                style: const TextStyle(fontSize: 24),
              ),
               Padding(
              padding: const EdgeInsets.all(60.0),
              child: Slider(
                value: timeoutValue,
                min: 5.0,
                max: 10.0,
                onChanged: (newValue) {
                  setState(() {
                    timeoutValue = newValue;
                  });
                },
                label: 'Timeout Zeit: ${timeoutValue.toInt()} Sekunden',
              ),
            ),
              ElevatedButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FuturePage()));
              }, child: const Text('Next Page')),
          ],
        ),
      ),
    );
  }
}
