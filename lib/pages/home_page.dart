import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/constant/weather_const.dart';
import 'package:wheather_app/models/weather_models.dart';
import 'package:wheather_app/pages/single_weather.dart';
import 'package:wheather_app/widgets/slider_dot.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  String? bgImage;

  _onePageChanged(int index) {
    setState(() {
      _currentPage = index;
      setBgImage(index);
    });
  }

  void setBgImage(int index) {
    if (index >= 0 && index < weatherModelsList.length) {
      String air = weatherModelsList[index].air.toLowerCase();

      if (air.contains('дождь')) {
        bgImage = 'assets/images/rain.png';
      } else if (air.contains('пасмурно')) {
        bgImage = 'assets/images/overcast.png';
      } else if (air.contains('ясно')) {
        bgImage = 'assets/images/clear.png';
      } else if (air.contains('переменная облачность')) {
        bgImage = 'assets/images/scatteredclouds.png';
      } else if (air.contains('небольшая облачность')) {
        bgImage = 'assets/images/fewclouds.png';
      } else if (air.contains('мгла')) {
        bgImage = 'assets/images/mgla.png';
      } else {
        bgImage = 'assets/images/clear.png';
      }
    } else {
      bgImage = 'assets/images/clear.png';
    }
  }

  List<WeatherModels> weatherModelsList = [];
  Future<void> fetchData() async {
    final dio = Dio();
    List<String> apiUrls = WeatherApi.getApiUrlsForCities();
    for (String apiUrl in apiUrls) {
      final res = await dio.get(apiUrl);
      if (res.statusCode == 200 || res.statusCode == 201) {
        WeatherModels weatherModel = WeatherModels(
            cityName: res.data['name'],
            temp: res.data['main']['temp'],
            air: res.data['weather'][0]['description'],
            humidity: res.data['main']['humidity'],
            pressure: res.data['main']['pressure'],
            sunrise: res.data['sys']['sunrise'],
            sunset: res.data['sys']['sunset'],
            speed: res.data['wind']['speed'],
            icon: res.data['weather'][0]['icon'],
            main: res.data['weather'][0]['main'],
            timeZone: res.data['timezone']);

        weatherModelsList.add(weatherModel);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bgImage ??= 'assets/images/clear.png';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: weatherModelsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Image.asset(
                  bgImage!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black38),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 140, left: 15),
                  child: Row(
                    children: [
                      for (int i = 0; i < weatherModelsList.length; i++)
                        if (i == _currentPage)
                          SliderDot(
                            isActive: true,
                          )
                        else
                          SliderDot(isActive: false)
                    ],
                  ),
                ),
                Swiper(
                    onIndexChanged: _onePageChanged,
                    itemCount: weatherModelsList.length,
                    //
                    itemBuilder: (context, index) => SingleWeather(
                          name: weatherModelsList[index].cityName,
                          temp:
                              '${weatherModelsList[index].temp.toStringAsFixed(1)}°C',
                          air: weatherModelsList[index].air,
                          humidity:
                              weatherModelsList[index].humidity.toString(),
                          pressure:
                              weatherModelsList[index].pressure.toString(),
                          speed: weatherModelsList[index].speed.toString(),
                          icon: weatherModelsList[index].icon,
                          timeZone: weatherModelsList[index].timeZone,
                        ))
              ],
            ),
    );
  }
}
