import 'package:apiflutter/cad_User.dart';
import 'package:apiflutter/list_User.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Usuários',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: const Text('Usuários', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white, // Define a cor do texto das guias selecionadas
  unselectedLabelColor: Color.fromARGB(125, 255, 255, 255), // Define a cor do texto das guias não selecionadas
            tabs: [
              Tab(text: 'Lista de Usuários'),
              Tab(text: 'Adicionar Usuário'),
            ],
          ),
        ),
        body: const Padding(
            padding: EdgeInsets.all(20),
            child: TabBarView(
              children: [
                UserList(),
                UserForm(),
              ],
            )),
      ),
    );
  }
}
