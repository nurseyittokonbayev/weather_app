class WeatherModels {
  WeatherModels({
    required this.cityName,
    required this.temp,
    required this.air,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.pressure,
    required this.speed,
    required this.icon,
    required this.main,
    required this.timeZone,
  });

  final String cityName;
  final double temp;
  final String air;
  final int sunrise;
  final int sunset;
  final int humidity;
  final int pressure;
  final String icon;
  final String main;
  final int timeZone;
  dynamic speed;
}
