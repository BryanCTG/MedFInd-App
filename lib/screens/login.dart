import 'package:flutter/material.dart';

///  StatefulWidget se usa cuando la pantalla necesita cambiar
/// su estado interno (por ejemplo, mostrar/ocultar contraseña).
/// Tiene dos clases: el widget y su State.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //  TextEditingController conecta un TextField con el código Dart.
  // Nos permite leer o limpiar el texto ingresado.
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscurePass = true;

  @override
  void dispose() {
    //  Siempre hay que liberar los controllers cuando el widget muere
    // para evitar fugas de memoria.
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///  Scaffold es la estructura base de una pantalla en Flutter.
      /// Proporciona AppBar, body, FloatingActionButton, BottomNavigationBar, etc.
      body: Container(
        //  Fondo con gradiente 
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB2EBF2), Color(0xFFE0F7FA)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            ///  SingleChildScrollView permite que el contenido
            /// sea desplazable si no entra en la pantalla
            /// (útil cuando aparece el teclado).
            padding: const EdgeInsets.all(32),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                ///  Column organiza widgets verticalmente.
                /// mainAxisSize.min hace que ocupe solo lo necesario.
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  // Logo / Nombre de la app
                  const Text(
                    'MedFind',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00BCD4),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Campo de correo
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campo de contraseña
                  TextField(
                    controller: _passController,
                    obscureText: _obscurePass,
                    ///  obscureText oculta los caracteres 
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePass ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                           
                          /// setState() le dice a Flutter que algo cambió
                          /// y que debe redibujar el widget.
                          setState(() => _obscurePass = !_obscurePass);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botón Iniciar Sesión
                  SizedBox(
                    width: double.infinity,
                    /// double.infinity hace que el widget ocupe
                    /// todo el ancho disponible de su padre.
                    child: ElevatedButton(
                      onPressed: () {
                      
                        //  Navigator.pushNamed navega a otra ruta
                        // sin eliminar la pantalla actual (se puede volver).
                        Navigator.pushNamed(context, '/registro');
                      },
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Color(0xFF00BCD4)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}