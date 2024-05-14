import 'package:apiflutter/user.dart';
import 'package:apiflutter/user_service.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late Future<List<User>> futureUsers;
  final UserService userService = UserService();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(); // Added for email
  final TextEditingController pictureController = TextEditingController();

  void _addUser() {
    if (firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      userService
          .createUser(User(
        id: '', // ID é gerado pela API, não precisa enviar
        title: tituloController
            .text, // Incluído, assumindo que você ainda quer enviar isso
        firstName: firstnameController.text,
        lastName: lastnameController.text,
        email: emailController.text,
        picture: pictureController.text, // Incluído, assumindo que é necessário
      ))
          .then((newUser) {
        _showSnackbar('User added successfully!');
        _refreshUserList();
      }).catchError((error) {
        _showSnackbar('Failed to add user: $error');
      });
    } else {
      _showSnackbar('Please fill in all fields.');
    }
  }

  void _refreshUserList() {
    setState(() {
      futureUsers = userService.getUsers();
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: firstnameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                        ),
                      ),
                      TextField(
                        controller: lastnameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => _addUser(),
                        icon: const Icon(Icons.add),
                        label: const Text("Adicionar"),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 255, 255)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 42, 141, 12))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
