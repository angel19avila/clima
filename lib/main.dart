import 'package:flutter/material.dart';
import 'consulta_coordenadas.dart';
import 'consulta_ciudad.dart';

void main() => runApp(ClimaApp());

class ClimaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App de Clima')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaCoordenadas()),
                );
              },
              child: Text('Consultar Clima por Coordenadas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaCiudad()),
                );
              },
              child: Text('Consultar Clima por Ciudad'),
            ),
          ],
        ),
      ),
    );
  }
}
