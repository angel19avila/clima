import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCoordenadas extends StatefulWidget {
  @override
  _ConsultaCoordenadasState createState() => _ConsultaCoordenadasState();
}

class _ConsultaCoordenadasState extends State<ConsultaCoordenadas> {
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  String weather = '';
  String temp = '';
  String pressure = '';
  String humidity = '';// Para mostrar la humedad
  String rain = ''; // Para mostrar la lluvia

  Future<void> getWeather() async {
    final String apiKey = 'b8af1dc50d16a09fb928ac35f7fde1a5'; // la API Key que creamos 
    final lat = latController.text;
    final lon = lonController.text;

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        weather = data['weather'][0]['description']; // Descripción del clima
        temp = data['main']['temp'].toString();
        pressure = data['main']['pressure'].toString();
        humidity = data['main']['humidity'].toString();

        // Verifica si existe el campo "rain" en la respuesta
        if (data['rain'] != null) {
          rain = data['rain']['1h'].toString(); // Cantidad de lluvia en las últimas 1 hora
        } else {
          rain = 'No hay lluvia';
        }
      });
    } else {
      setState(() {
        weather = 'Error: No se pudo obtener el clima.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consultar Clima por Coordenadas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: latController,
              decoration: InputDecoration(labelText: 'Latitud'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: lonController,
              decoration: InputDecoration(labelText: 'Longitud'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: getWeather,
              child: Text('Consultar Clima'),
            ),
            SizedBox(height: 20),
            Text('Clima: $weather'),
            Text('Temperatura: $temp°C'),
            Text('Presión: $pressure hPa'),
            Text('Humedad: $humidity%'),
            Text('Lluvia: $rain'),
          ],
        ),
      ),
    );
  }
}
