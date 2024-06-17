import 'package:login_weather_flutter/weather/models/temperature.dart';
import 'package:weather_repository/weather_repository.dart';

class Weather {
  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature
  });

  static final empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    location: '--'
  );

  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final Temperature temperature;
}