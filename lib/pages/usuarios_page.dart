import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/usuarios.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  //datos de la api
  List<Usuarios> userList = [];

  Future<void> fetchData() async {
    String sUrl = 'https://api.npoint.io/5cb393746e518d1d8880';
    try {
      final response = await http.get(
        Uri.parse(sUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      print('Código de estado de la respuesta: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<dynamic> userListJson = jsonData["elementos"];
        
        setState(() {
          userList = userListJson.map((item) => Usuarios.fromJson(item)).toList();
          print ('Cantidad de usuarios obtenidos: ${userList.length}');
        });
      } else {
        throw Exception('Error al obtener los datos: ${response.statusCode}');
      }
    } catch (e) {
      print("ERROR AL ENVIAR/RECIBIR SOLICITUD");
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // construir la pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final usuario = userList[index];
          return ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(usuario.urlImagen),
            ),
            title: Text(usuario.nombreCompleto),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profesión: ${usuario.profesion}'),
                Text('Edad: ${usuario.edad}'),
                Text('Universidad: ${usuario.universidad}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/perfilPage', arguments: usuario);
              },
              child: const Text('Ver Perfil'),
            ),
          );
        },
      ),
    );
  }
}
