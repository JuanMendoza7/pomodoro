import 'package:flutter/material.dart';
import 'package:flutter_circular_timer/timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/info.dart';
import 'Services/api_service.dart';
import 'Views/Auth/home.dart';
import 'Views/Auth/login.dart';
import 'Views/create.dart';
import 'Widgets/books_list.dart';
import 'calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

// ignore: must_be_immutable
class DemoApp extends StatefulWidget {
  Info? info;

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  // CountDownController _controller = CountDownController();
  // int _duration = 5;
  // bool _isPause = false;
  late SharedPreferences prefs;
  late Future<List<Info>> info;

  ApiService apiService = ApiService();
  SharedPreferences? sharedPreferences;

  bool editable = false;
  @override
  void initState() {
    super.initState();
    checkLogin();
    info = apiService.getData();
  }

  checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Pomodoro Timer'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            children: [
              const Icon(Icons.menu_book_outlined, size: 200),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalRoute()));
                },
                child: const Text("Calendario"),
                style: ElevatedButton.styleFrom(primary: Colors.red.shade900),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: const Text("Tareas realizadas"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const CreatePage()));
              //   },
              //   child: const Text('Agregrar Tarea'),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Timer()));
                },
                child: const Text("Volver a reloj"),
                style: ElevatedButton.styleFrom(primary: Colors.red.shade900),
              ),
            ]),
      ),
    );
  }
}

// ignore: must_be_immutable
// class SecondRoute extends StatelessWidget {
// SecondRoute({Key? key}) : super(key: key);

// TextEditingController idController = TextEditingController();
// TextEditingController namController = TextEditingController();
// TextEditingController tarController = TextEditingController();
// ApiService apiService = ApiService();
// SharedPreferences? sharedPreferences;

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Información mostrada'),
//       centerTitle: true,
//     ),
//     body: ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       children: [
//         Column(
//           children: [
//             const SizedBox(
//               height: 30.0,
//             ),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => MyApp()));
//               },
//               child: const Text("Volver"),
//               style: ElevatedButton.styleFrom(primary: Colors.red),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

//   getData(
//     List<Info> data,
//     TextEditingController id,
//     TextEditingController nam,
//     TextEditingController tar,
//   ) {
//     id.text = data.first.api.toString();
//     nam.text = data.first.name.toString();
//     tar.text = data.first.tarea.toString();
//   }
// }

class CalRoute extends StatelessWidget {
  const CalRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calendario de tareas",
      debugShowCheckedModeBanner: false,
      home: Calendar(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.red)),
    );
  }
}
