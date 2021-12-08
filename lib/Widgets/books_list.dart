import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_timer/Views/details.dart';
import '../Models/info.dart';

class InfoList extends StatefulWidget {
  Future<List<Info>> infos;
  InfoList({Key? key, required this.infos}) : super(key: key);

  @override
  _InfoListState createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Info>>(
        future: widget.infos,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index].nombre),
                  subtitle: Text(snapshot.data[index].tarea),
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Info info = Info(
                      id: snapshot.data[index].id,
                      nombre: snapshot.data[index].nombre,
                      tarea: snapshot.data[index].tarea,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(info: info)));
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
