
import 'package:flutter/material.dart';

class RegistroSaludScreen extends StatefulWidget {
  const RegistroSaludScreen({super.key});

  @override
  State<RegistroSaludScreen> createState() => _RegistroSaludScreenState();
}

class _RegistroSaludScreenState extends State<RegistroSaludScreen> {
  // 🔹 NUEVO: controller para el nombre
  final _nombreController = TextEditingController();

  final _edadController = TextEditingController();
  final _alergiasController = TextEditingController();
  final _condicionesController = TextEditingController();

  final Set<String> _chipsSeleccionados = {'Diabetes', 'Asma', 'Hipertensión'};

  final List<String> _chips = [
    'Diabetes',
    'Asma',
    'Hipertensión',
    'Domrimos',
    'Pretention',
    'Borna',
    'Danrentor',
  ];

  @override
  void dispose() {
    _nombreController.dispose(); // 🔹 liberar memoria
    _edadController.dispose();
    _alergiasController.dispose();
    _condicionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Ficha Médica',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // Avatar
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF80DEEA),
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF00BCD4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 🔥 NUEVO CAMPO
            _buildTextField('Nombre completo', _nombreController),
            const SizedBox(height: 12),

            _buildTextField('Edad', _edadController, TextInputType.number),
            const SizedBox(height: 12),
            _buildTextField('Alergias Conocidas', _alergiasController),
            const SizedBox(height: 12),
            _buildTextField('Condiciones Crónicas', _condicionesController),
            const SizedBox(height: 20),

            const Text(
              'Chips',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _chips.map((chip) => _buildChip(chip)).toList(),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                ),
                onPressed: () {
                  // 🔹 validación simple (opcional)
                  if (_nombreController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ingresa tu nombre completo'),
                      ),
                    );
                    return;
                  }

                  Navigator.pushNamed(context, '/inicio');
                },
                child: const Text(
                  'Guardar Perfil',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      [TextInputType? type]) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(hintText: hint),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _chipsSeleccionados.contains(label);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        setState(() {
          if (val) {
            _chipsSeleccionados.add(label);
          } else {
            _chipsSeleccionados.remove(label);
          }
        });
      },
      selectedColor: const Color(0xFF00BCD4).withOpacity(0.2),
      checkmarkColor: const Color(0xFF00BCD4),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF00BCD4) : Colors.black54,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade300,
      ),
    );
  }
}

