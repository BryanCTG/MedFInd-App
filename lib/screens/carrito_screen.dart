import 'package:flutter/material.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  bool _recogidaEnTienda = true;
  final _direccionController = TextEditingController();

  ///  Modelo de datos simple con Map. En una app real
  /// usarías una clase modelo (ej: class Producto { ... }).
  List<Map<String, dynamic>> _items = [
    {'nombre': 'Vitamina C+ 500mg', 'precio': 2.00, 'cantidad': 1, 'emoji': '🍊'},
    {'nombre': 'Vitamina C Proootida a 10...', 'precio': 7.00, 'cantidad': 1, 'emoji': '💊'},
    {'nombre': 'Paracetamol Medicine', 'precio': 2.00, 'cantidad': 1, 'emoji': '💊'},
  ];

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + item['precio'] * item['cantidad']);
  /// 🧮 get es un getter: una propiedad calculada que se recomputa
  /// cada vez que se accede. fold() es como reduce() en JS.

  double get _total => _subtotal + 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tu Carrito (${_items.length})',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            /// Expanded hace que su hijo ocupe todo el espacio disponible
            /// en el eje principal (vertical en Column).
            /// Sin Expanded, el ListView causaría un overflow.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lista de productos
                  ..._items.map((item) => _buildItemCard(item)),
                  /// El operador spread '...' expande una lista
                  /// dentro de otra lista.

                  const SizedBox(height: 24),

                  // Método de entrega
                  const Text(
                    'Método de Entrega',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  _buildOpcionEntrega(
                    titulo: 'Recogida en Tienda',
                    subtitulo: 'Aldreccio de Recogida Tienda',
                    isSelected: _recogidaEnTienda,
                    showToggle: true,
                    onTap: () => setState(() => _recogidaEnTienda = true),
                  ),
                  const SizedBox(height: 8),
                  _buildOpcionEntrega(
                    titulo: 'Domicilio',
                    isSelected: !_recogidaEnTienda,
                    onTap: () => setState(() => _recogidaEnTienda = false),
                  ),

                  if (!_recogidaEnTienda) ...[
                    /// 'if' dentro de una lista de widgets es una
                    /// característica de Dart: "collection if".
                    /// Solo añade el widget si la condición es verdadera.
                    const SizedBox(height: 12),
                    TextField(
                      controller: _direccionController,
                      decoration: const InputDecoration(
                        hintText: 'Aldreccio a Domicilio',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Resumen de pago
                  const Text(
                    'Resumen de Pago',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildResumenFila('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
                  _buildResumenFila('Envío', '\$2,00'),
                  const Divider(height: 24),
                  _buildResumenFila(
                    'Total',
                    '\$${_total.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Botón confirmar 
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Aquí iría la lógica de pago
                  ScaffoldMessenger.of(context).showSnackBar(
                    /// showSnackBar muestra un mensaje temporal en la parte
                    /// inferior de la pantalla.
                    const SnackBar(
                      content: Text('¡Pedido confirmado! 🎉'),
                      backgroundColor: Color(0xFF00BCD4),
                    ),
                  );
                },
                child: const Text(
                  'Confirmar y Pagar',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(item['emoji'], style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['nombre'],
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  /// overflow.ellipsis muestra "..." si el texto
                  /// es demasiado largo.
                ),
                Text(
                  '\$${item['precio'].toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          // Controles de cantidad
          Row(
            children: [
              _buildQtyButton(
                icon: Icons.remove,
                onTap: () {
                  setState(() {
                    if (item['cantidad'] > 1) item['cantidad']--;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${item['cantidad']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _buildQtyButton(
                icon: Icons.add,
                color: const Color(0xFF00BCD4),
                iconColor: Colors.white,
                onTap: () => setState(() => item['cantidad']++),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton({
    required IconData icon,
    required VoidCallback onTap,
    /// VoidCallback es un typedef de Dart: función que no retorna nada.
    Color color = Colors.white,
    Color iconColor = const Color(0xFF00BCD4),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF00BCD4)),
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }

  Widget _buildOpcionEntrega({
    required String titulo,
    String? subtitulo,
    required bool isSelected,
    bool showToggle = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<bool>(
              /// Radio es un botón de selección circular.
              /// groupValue es el valor actual seleccionado.
              value: true,
              groupValue: isSelected,
              activeColor: const Color(0xFF00BCD4),
              onChanged: (_) => onTap(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (subtitulo != null)
                    Text(subtitulo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            if (showToggle)
              Switch(
                value: isSelected,
                onChanged: (_) => onTap(),
                activeColor: const Color(0xFF00BCD4),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumenFila(String label, String valor, {bool isBold = false}) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: isBold ? 16 : 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(valor, style: style),
        ],
      ),
    );
  }
}