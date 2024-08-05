import 'package:crudflutterweb/controller/dataHelper.dart';
import 'package:flutter/material.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  DataHelper dataHelper = DataHelper();

  final TextEditingController marcaC = TextEditingController();
  final TextEditingController modeloC = TextEditingController();
  final TextEditingController tipoC = TextEditingController();
  final TextEditingController velocidadMaximaC = TextEditingController(); // Cambiado de 'materialC'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Vehículo'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(marcaC, 'Marca', 'Marca del vehículo'),
            const SizedBox(height: 16),
            _buildTextField(modeloC, 'Modelo', 'Modelo del vehículo'),
            const SizedBox(height: 16),
            _buildTextField(tipoC, 'Tipo', 'Tipo de vehículo'),
            const SizedBox(height: 16),
            _buildTextField(velocidadMaximaC, 'Velocidad Máxima', 'Velocidad máxima del vehículo'), // Cambiado de 'Material'
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Convertir velocidadMaximaC.text a int
                  int velocidadMaxima = int.tryParse(velocidadMaximaC.text.trim()) ?? 0;
                  var response = await dataHelper.addVehicle(
                      marcaC.text.trim(),
                      modeloC.text.trim(),
                      velocidadMaxima,
                      tipoC.text.trim()
                  );
                  print('${response.statusCode}');
                  print('${response.body}');
                  if (response.statusCode == 201) {
                    Navigator.pop(context, true);
                  } else {
                    print('Error: ${response.body}');
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        keyboardType: label == 'Velocidad Máxima' ? TextInputType.number : TextInputType.text, // Ajustar tipo de teclado para velocidad máxima
      ),
    );
  }
}