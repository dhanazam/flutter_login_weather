import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_weather_flutter/search/view/search_page.dart';
import 'package:login_weather_flutter/settings_page/settings_page.dart';
import 'package:login_weather_flutter/weather/weather.dart';
import 'package:login_weather_flutter/weather/widgets/widget.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(context.read<WeatherCubit>()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (BuildContext context, WeatherState state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const Text('Please Select a Location');
              case WeatherStatus.loading:
                return const CircularProgressIndicator();
              case WeatherStatus.success:
                return WeatherPopulated(
                  weather: state.weather, 
                  units: state.temperatureUnits, 
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  }
                );
              case WeatherStatus.failure:
              default:
                return const Text('Something went wrong!');
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if(!context.mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        }
      ),
    );
  } 
}