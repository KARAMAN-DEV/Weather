import 'package:flutter/material.dart';
import 'package:havadurumu/models/weather_model.dart';
import 'package:havadurumu/sevices/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeatherModel> _weathers = [];

  void _getWeatherData() async {
    _weathers = await WeatherService().getWeatherData();
    setState(
        () {}); //verilerimiz geldikten sonra arayüzün güncellenmesi için gerkli
  }

  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hava Durumu'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: _weathers.length,
        itemBuilder: (context, index) {
          final WeatherModel weather = _weathers[index];
          return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  weather.gun,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Image.network(
                  weather.ikon,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 25),
                  child: Text(
                    " ${weather.durum.toUpperCase()}    ${weather.derece}°C",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Min:  ${weather.min}°C"),
                        Text("Max:  ${weather.max}°C"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Gece: ${weather.gece}°C"),
                        Text("Nem: %${weather.nem}"),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
