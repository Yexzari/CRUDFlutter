import 'package:crudflutterweb/controller/dataHelper.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final List list;
  final int index;

  const EditPage({required this.list, required this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  DataHelper dataHelper = DataHelper();
  late TextEditingController idC;
  late TextEditingController marcaC;
  late TextEditingController modeloC;
  late TextEditingController tipoC;
  late TextEditingController velocidadMaximaC;

  @override
  void initState() {
    super.initState();
    idC = TextEditingController(text: widget.list[widget.index]['id'].toString());
    marcaC = TextEditingController(text: widget.list[widget.index]['marca'].toString());
    modeloC = TextEditingController(text: widget.list[widget.index]['modelo'].toString());
    tipoC = TextEditingController(text: widget.list[widget.index]['tipo'].toString());
    velocidadMaximaC = TextEditingController(text: widget.list[widget.index]['velocidadMaxima'].toString()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Vehículo'),
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
            _buildTextField(velocidadMaximaC, 'Velocidad Máxima', 'Velocidad máxima del vehículo'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  var response = await dataHelper.updateVehicle(
                    idC.text.trim(),
                    marcaC.text.trim(),
                    modeloC.text.trim(),
                    int.parse(velocidadMaximaC.text.trim()), // Convertir a int
                    tipoC.text.trim() // tipoC es String
                  );
                  print('${response.statusCode}');
                  print('${response.body}');
                  if (response.statusCode == 200) {
                    Navigator.pop(context, true); // Regresa a la página anterior con un resultado de éxito
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
                'Editar',
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
      ),
    );
  }

  @override
  void dispose() {
    idC.dispose();
    marcaC.dispose();
    modeloC.dispose();
    tipoC.dispose();
    velocidadMaximaC.dispose(); 
    super.dispose();
  }
}
