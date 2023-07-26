import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SingleWeather extends StatelessWidget {
  const SingleWeather({
    super.key,
    required this.name,
    required this.temp,
    required this.air,
    required this.humidity,
    required this.pressure,
    required this.speed,
    required this.icon,
    required this.timeZone,
  });

  final String? name;
  final String? temp;
  final String air;
  final String humidity;
  final String speed;
  final String pressure;
  final String icon;
  final int timeZone;

  String _getFormattedDate(int timezone) {
    final currentTime = DateTime.now().toUtc().add(Duration(seconds: timezone));
    final formattedDate = DateFormat('dd.MM.yyyy').format(currentTime);
    return formattedDate;
  }

  String _getFormattedTime(int timezone) {
    final currentTime = DateTime.now().toUtc().add(Duration(seconds: timezone));
    final formattedTime = DateFormat('HH:mm').format(currentTime);
    return formattedTime;
  }

  String _getFormattedDay(int timezone) {
    final currentTime = DateTime.now().toUtc().add(Duration(seconds: timezone));
    final dayOfWeek = currentTime.weekday;

    switch (dayOfWeek) {
      case 1:
        return 'Понедельник';
      case 2:
        return 'Вторник';
      case 3:
        return 'Среда';
      case 4:
        return 'Четверг';
      case 5:
        return 'Пятница';
      case 6:
        return 'Суббота';
      case 7:
        return 'Воскресенье';
      default:
        return 'Ошибка';
    }
  }

  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/w/$iconCode.png';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      name!,
                      style: GoogleFonts.forum(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _getFormattedTime(timeZone),
                          style: GoogleFonts.forum(
                              fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _getFormattedDay(timeZone),
                          style: GoogleFonts.forum(
                              fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _getFormattedDate(timeZone),
                          style: GoogleFonts.forum(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temp!,
                      style: GoogleFonts.forum(
                          fontSize: 85,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Row(
                      children: [
                        Image.network(
                          _getWeatherIconUrl(icon),
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          air,
                          style: GoogleFonts.forum(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white30,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Ветер',
                        style: GoogleFonts.forum(
                            fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        speed,
                        style: GoogleFonts.forum(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        'км/с',
                        style: GoogleFonts.forum(
                            fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Давление',
                        style: GoogleFonts.forum(
                            fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        pressure,
                        style: GoogleFonts.forum(
                            fontSize: 20, color: Colors.white),
                      ),
                      // Text(
                      //   '% ',
                      //   style: GoogleFonts.forum(
                      //       fontSize: 14, color: Colors.white),
                      // ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Влажность',
                        style: GoogleFonts.forum(
                            fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        humidity,
                        style: GoogleFonts.forum(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '%',
                        style: GoogleFonts.forum(
                            fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
