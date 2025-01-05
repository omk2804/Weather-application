import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/weather_forcastcard.dart';
import 'package:http/http.dart' as http;

class WeatherMaterialApp extends StatefulWidget {
  const WeatherMaterialApp({super.key});

  @override
  State<WeatherMaterialApp> createState() => _WeatherMaterialAppState();
}

class _WeatherMaterialAppState extends State<WeatherMaterialApp> {
  double tempr = 0.0;

  Future getCurrentWeather() async {
    try {
      String cityName = "Surat,Gujarat";
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apikey'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "An unexpected error occured";
      }

      return data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather app"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive());
          }
          final data = snapshot.data;
          final currentForecast = data['list'][0];
          final currentTemp = currentForecast['main']['temp'];
          final currentSky = currentForecast['weather'][0]['main'];
          final currentPressure = currentForecast['main']['pressure'];
          final currentHumidity = currentForecast['main']['humidity'];
          final currentWindspeed = currentForecast['wind']['speed'];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Card(
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "$currentTemp k",
                              style: const TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              currentSky == 'Rain' || currentSky == 'Clouds'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 80,
                            ),
                            Text(
                              currentSky.toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Weather ForeCast",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         WeatherForcastcard(
                //             time: data['list'][i + 1]['dt'].toString(),
                //             icon: data['list'][i + 1]['weather'][0]['main'] ==
                //                         'Rain' ||
                //                     data['list'][i + 1]['weather'][0]['main'] ==
                //                         'Clouds'
                //                 ? Icons.cloud
                //                 : Icons.sunny,
                //             value:
                //                 data['list'][i + 1]['main']['temp'].toString()),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final time =
                          DateTime.parse(data['list'][index + 1]['dt_txt']);
                      return WeatherForcastcard(
                        icon: data['list'][index + 1]['weather'][0]['main'] ==
                                    'Rain' ||
                                data['list'][index + 1]['weather'][0]['main'] ==
                                    'Clouds'
                            ? Icons.cloud
                            : Icons.sunny,
                        time: DateFormat.j().format(time),
                        value:
                            data['list'][index + 1]['main']['temp'].toString(),
                      );
                    },
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AdditionalInfo(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString()),
                    AdditionalInfo(
                        icon: Icons.air,
                        label: "Wind speed",
                        value: currentWindspeed.toString()),
                    AdditionalInfo(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
