import 'dart:convert';

import 'package:flutter_circular_timer/Models/info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String url = domain + '/api/People/';

  Future<List<Info>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Info> info = [];

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
        Info book = Info.fromJson(model);
        info.add(book);
      }
    }
    return info;
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

  Future<Info> postData(Info book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map data = {'nombre': book.nombre, 'tarea': book.tarea};

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

  Future<void> updateData(Info book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map data = {'id': book.id, 'nombre': book.nombre, 'tarea': book.tarea};

    await http.put(Uri.parse(url + book.id.toString()),
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
