final String domain = 'https://finalapi23.azurewebsites.net';

class Info {
  final int id;
  final String nombre;
  final String tarea;

  Info({required this.id, required this.nombre, required this.tarea});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json['id'],
      nombre: json['nombre'],
      tarea: json['tarea'],
    );
  }
}
