import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  String? language;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Predictor'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          // decoration: BoxDecoration,
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                child: language != null
                    ? Text(
                        language ?? '',
                        style: TextStyle(letterSpacing: 10, fontSize: 30),
                      )
                    : CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 300.0,
                height: 50.0,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Type Here !',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    text = _controller.text;
                    fetchAll();
                  });
                },
                child: Container(
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchAll() async {
    final url = 'https://api.api-ninjas.com/v1/textlanguage?text=$text';
    const apiKey = 'JDmGxZlSm46pq5Jaffpvyw==6quLqxQkOrW9Un7Z';
    try {
      final response =
          await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(response.body);

        if (json is Map<String, dynamic>) {
          Model model = Model.fromJson(json);
          setState(() {
            language = model.language;
          });
        } else {
          print('Error: Invalid JSON structure');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class Model {
  String? language;

  Model({this.language});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      language: json['language'],
    );
  }
}


/* 
World

दुनिया

ವಿಶ್ವ

دنیا

દુનિયા

 */