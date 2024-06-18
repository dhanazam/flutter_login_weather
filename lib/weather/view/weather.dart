import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_weather_flutter/authentication/bloc/authentication_bloc.dart';
import 'package:login_weather_flutter/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const WeatherPage());
  }

  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherRepository _weatherRepository;

  @override
  void initState() {
    super.initState();
    _weatherRepository = WeatherRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (_) => WeatherCubit(_weatherRepository),
        child: const WeatherView(),
      ),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (BuildContext context, WeatherState state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const Text('Please Select a Location');
              case WeatherStatus.loading:
                return const CircularProgressIndicator();
              case WeatherStatus.success:
                return const Text('Success');
              case WeatherStatus.failure:
              default:
                return const Text('Something went wrong!');
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => LogoutButton
      ),
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