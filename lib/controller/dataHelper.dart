import 'dart:convert';
import 'package:http/http.dart' as http;

class DataHelper {
  var url = "https://s5vkqg5xl9.execute-api.us-east-1.amazonaws.com/Prod/lambda/";

  Future<http.Response> addVehicle(String marcaC, String modeloC, int velocidadMaximaC, String tipoC) async {
    Map<String, dynamic> data = {
      "marca": marcaC,
      "modelo": modeloC,
      "velocidadMaxima": velocidadMaximaC,
      "tipo": tipoC
    };

    var body = json.encode(data);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<http.Response> updateVehicle(String id, String marcaC, String modeloC, int velocidadMaximaC, String tipoC) async {
  Map<String, dynamic> data = {
    "id": id,
    "marca": marcaC,
    "modelo": modeloC,
    "velocidadMaxima": velocidadMaximaC,
    "tipo": tipoC // Debe ser un String
  };
  var body = json.encode(data);
  try {
    var response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    return response;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}


  Future<http.Response> deleteVehicle(String id) async {
    Map<String, dynamic> data = {
      "id": id,
    };
    var body = json.encode(data);
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}