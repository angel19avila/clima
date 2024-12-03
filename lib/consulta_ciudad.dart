import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCiudad extends StatefulWidget {
  @override
  _ConsultaCiudadState createState() => _ConsultaCiudadState();
}

class _ConsultaCiudadState extends State<ConsultaCiudad> {
  final TextEditingController cityController = TextEditingController();
  String weather = '';
  String temp = '';
  String pressure = '';
  String humidity = '';
  String rain = ''; // Para mostrar la lluvia

  Future<void> getWeather() async {
    final String apiKey = 'b8af1dc50d16a09fb928ac35f7fde1a5'; // la  API Key que creamos 
    final city = cityController.text;

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

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
      appBar: AppBar(title: Text('Consultar Clima por Ciudad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Nombre de la Ciudad'),
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
