import 'package:flutter/material.dart';

///  Esta pantalla usa AnimationController para el spinner giratorio.
/// Por eso extiende State con TickerProviderStateMixin, que provee
/// el "ticker" (reloj) que necesita la animación.
class AnalisisRecetaScreen extends StatefulWidget {
  const AnalisisRecetaScreen({super.key});

  @override
  State<AnalisisRecetaScreen> createState() => _AnalisisRecetaScreenState();
}

class _AnalisisRecetaScreenState extends State<AnalisisRecetaScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isLoading = true;

  @override
  void initState() {
    /// initState() se llama UNA vez cuando el widget se crea.
    /// Es el lugar para inicializar animaciones, cargar datos, etc.
    super.initState();

    // Crea un controlador que repite infinitamente (para el spinner)
    _rotationController = AnimationController(
      vsync: this, // 'this' funciona gracias a TickerProviderStateMixin
      duration: const Duration(seconds: 2),
    )..repeat(); // '..' es el operador cascade: llama repeat() sobre el mismo objeto

    // Simula que después de 3 segundos termina el análisis
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        /// mounted verifica que el widget todavía esté en pantalla
        /// antes de llamar setState(). Evita errores si el usuario
        /// navegó a otra pantalla antes de que termine el Future.
        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, '/carrito');
        /// pushReplacementNamed reemplaza la pantalla actual en el stack,
        /// así el usuario no puede "volver" a la pantalla de carga.
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose(); //  Siempre liberar animaciones
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spinner animado
              RotationTransition(
                /// RotationTransition hace girar a su hijo según
                /// la animación del controller.
                turns: _rotationController,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const SweepGradient(
                      /// SweepGradient crea un gradiente en forma circular,
                      /// lo que da el efecto de "spinner de carga".
                      colors: [
                        Color(0xFF00BCD4),
                        Color(0xFFB2EBF2),
                        Color(0xFF00BCD4),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00BCD4).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                'Analizando receta...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Nuestra Inteligencia Artificial está identificando\ntus medicamentos y buscando stock.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                /// height en TextStyle controla el espacio entre líneas
                /// (1.5 = 150% del tamaño de fuente).
              ),
              const SizedBox(height: 48),

              // Imagen ilustrativa de receta
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FBFC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.receipt_long,
                      size: 80,
                      color: Color(0xFF00BCD4),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Color(0xFF00BCD4)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Por favor espera un momento...',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}