import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_timer/Models/info.dart';
import 'package:flutter_circular_timer/Services/api_service.dart';

import 'Auth/home.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const Icon(Icons.info, size: 200),
          TextFormField(
            controller: idController,
            decoration: const InputDecoration(
              labelText: 'Id',
            ),
          ),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Materia',
            ),
          ),
          TextFormField(
            controller: authorController,
            decoration: const InputDecoration(
              labelText: 'Tarea',
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40.0),
            child: ElevatedButton(
                onPressed: () {
                  Info info = Info(
                      id: int.parse(idController.text),
                      nombre: titleController.text,
                      tarea: authorController.text);
                  service.postData(info);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false);
                },
                child: const Text('Create')),
          ),
        ],
      )),
    );
  }
}
