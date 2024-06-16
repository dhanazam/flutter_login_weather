import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_weather_flutter/authentication/bloc/authentication_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const WeatherPage());
  }

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
            TemperatureField(),
            LogoutButton()
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

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
      },
      child: const Text('Logout'),
    );
  }
}