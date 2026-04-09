import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/registro_salud_screen.dart';
import 'screens/inicio_screen.dart';
import 'screens/analisis_receta_screen.dart';
import 'screens/carrito_screen.dart';

void main() {
  runApp(const MedFindApp());
}

/// 🔷 En Flutter, toda app comienza con runApp().
/// MyApp es un StatelessWidget (widget sin estado interno).
/// MaterialApp es el widget raíz que configura tema, rutas y navegación.
class MedFindApp extends StatelessWidget {
  const MedFindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedFind',
      debugShowCheckedModeBanner: false,

      ///  ThemeData define los colores y estilos globales de la app.
      /// Cualquier widget dentro de la app puede acceder a este tema
      /// con Theme.of(context).
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BCD4),
          primary: const Color(0xFF00BCD4),
          secondary: const Color(0xFF26C6DA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF0FBFC),
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00BCD4), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BCD4),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        useMaterial3: true,
      ),

      ///  Las rutas nombradas permiten navegar entre pantallas
      /// usando Navigator.pushNamed(context, '/nombre').
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/registro': (context) => const RegistroSaludScreen(),
        '/inicio': (context) => const InicioScreen(),
        '/analisis': (context) => const AnalisisRecetaScreen(),
        '/carrito': (context) => const CarritoScreen(),
      },
    );
  }
}