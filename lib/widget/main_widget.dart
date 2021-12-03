import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  final String location;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int? humidity;
  final double? windSpeed;
  const MainWidget({
    Key? key,
    required this.location,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xfff1f1f1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${location.toString()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  '${temperature.toInt().toString()}°',
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                ' High of ${tempMax.toInt().toString()} ° , Low of ${tempMin.toInt().toString()} °',
                style: const TextStyle(
                  color: Color(0xff9e9e9e),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                WeatherTile(
                    icon: Icons.thermostat_outlined,
                    title: 'temperature',
                    subtitle: '${temperature.toInt().toString()}°'),
                WeatherTile(
                    icon: Icons.filter_drama_outlined,
                    title: 'Weather',
                    subtitle: '$weather'),
                WeatherTile(
                    icon: Icons.wb_sunny,
                    title: 'Humidty',
                    subtitle: '$humidity'),
                WeatherTile(
                    icon: Icons.waves_outlined,
                    title: 'Wind Speed',
                    subtitle: '${windSpeed!.toInt()} Kph'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
