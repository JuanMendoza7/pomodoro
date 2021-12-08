import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import 'Models/info.dart';

class ApiService {
  final String url = domain + '/api/People/';

  Future<List<Info>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Info> infos = [];

    String authorization = "Bearer ";

    if (token != null) {
      authorization = authorization + token;
    }

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authorization,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var model in jsonResponse) {
        Info info = Info.fromJson(model);
        infos.add(info);
      }
    }
    return infos;
  }

  Future<Info> getDataById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(Uri.parse(url + id.toString()), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Info.fromJson(jsonResponse);
    } else {
      throw Exception('Error al llamar al API');
    }
  }

  Future<Info> postData(Info info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map data = {'nombre': info.nombre, 'tarea': info.tarea};

    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data));

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      return Info.fromJson(jsonResponse);
    } else {
      throw Exception('Error al llamar al API');
    }
  }

  Future<void> updateData(Info info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map data = {'id': info.id, 'nombre': info.nombre, 'tarea': info.tarea};

    await http.put(Uri.parse(url + info.id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data));
  }

  Future<void> deleteData(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.delete(Uri.parse(url + id.toString()), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}