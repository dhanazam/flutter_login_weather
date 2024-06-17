import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celcius }

@JsonSerializable()
class Temperature {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) => _$TemperatureFromJson(json);
  
  final double value;
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

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
  
  @override
  List<Object?> get props => [condition, lastUpdated, location, temperature];
}