import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_timer/Models/info.dart';
import 'package:flutter_circular_timer/Services/api_service.dart';

import 'Auth/home.dart';
import 'edit.dart';

class DetailsPage extends StatefulWidget {
  Info info;
  DetailsPage({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            const Icon(
              Icons.info,
              size: 200,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Id: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    widget.info.id.toString(),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Materia: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    widget.info.nombre,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Tarea: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    widget.info.tarea,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPage(info: widget.info)),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text('Edit')),
            ),
            ElevatedButton(
                onPressed: () {
                  service.deleteData(widget.info.id);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false);
                },
                child: const Text('Delete'),
                style: ElevatedButton.styleFrom(primary: Colors.red)),
          ],
        )),
      ),
    );
  }
}
