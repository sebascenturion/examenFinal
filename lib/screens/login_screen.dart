import 'package:flutter/material.dart';
import 'posts_screen.dart'; // Asegúrate de que este archivo esté correctamente creado y enlazado.

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorContrasena = TextEditingController();
  final GlobalKey<FormState> claveFormulario = GlobalKey<FormState>();
  bool contrasenaVisible = false;

  void iniciarSesion() {
    if (claveFormulario.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PostsScreen()), // Asegúrate de que esta clase es correcta.
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio de Sesión")),
      body: Form(
        key: claveFormulario,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // Agregado para evitar overflow cuando el teclado aparece
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controladorEmail,
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Por favor ingrese su correo electrónico';
                    }
                    if (!valor.contains('@')) {
                      return 'Ingrese un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controladorContrasena,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        contrasenaVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          contrasenaVisible = !contrasenaVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !contrasenaVisible,
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Por favor ingrese su contraseña';
                    }
                    if (valor.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: iniciarSesion,
                  child: Text('Ingresar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controladorEmail.dispose();
    controladorContrasena.dispose();
    super.dispose();
  }
}
