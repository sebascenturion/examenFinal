import 'package:flutter/material.dart';
import 'main_screen.dart'; 

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
      // Navega al MainScreen si el formulario es válido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
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
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    prefixIcon: Icon(Icons.email),
                  ),
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
                    prefixIcon: Icon(Icons.lock),
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
                  child: Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.blue), // Texto azul
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 175, 222, 244),
                    elevation: 2, // Elevación del botón
                    shape: RoundedRectangleBorder( // Forma del botón
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
