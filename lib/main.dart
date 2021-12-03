import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'widget/main_widget.dart';

Future<WeatherInfo> fetchWeather() async {
  const cityName = 'mumbai';
  const apiKey = '9827dbdffd3a6322d1cdafc961e425de';
  const requestUrl =
      'http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';
  final response = await http.get(Uri.parse(requestUrl));
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error loading the request url info');
  }
}

class WeatherInfo {
  final String location;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int? humidity;
  final double? windSpeed;
  WeatherInfo({
    required this.location,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    this.humidity,
    this.windSpeed,
  });
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['name'],
      temperature: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: json['main']['speed'] ?? 0,
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'Weather App',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;
  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainWidget(
              location: snapshot.data!.location,
              temperature: snapshot.data!.temperature,
              tempMin: snapshot.data!.tempMin,
              tempMax: snapshot.data!.tempMax,
              weather: snapshot.data!.weather,
              humidity: snapshot.data!.humidity,
              windSpeed: snapshot.data!.windSpeed,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
