import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CityField(),
            SizedBox(height: 20),
            TemperatureField()
          ],
        )
      )
    );
  }
}

class CityField extends StatelessWidget {
  const CityField({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: Text("City")
    );
  }
}

class TemperatureField extends StatelessWidget {
  const TemperatureField({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: Text("Temperature")
    );
  }
}