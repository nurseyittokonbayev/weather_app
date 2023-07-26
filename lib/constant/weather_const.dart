class WeatherApi {
  static String apiKey = '5e9cf447750476688ffd9a28d0ac34ae';
  static List<String> cityNames = [
    'osh',
    'bishkek',
    'london',
    'washington',
    'cupertino'
  ];

  static List<String> getApiUrlsForCities() {
    List<String> apiUrls = [];
    for (String cityName in cityNames) {
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&lang=ru&units=metric';
      apiUrls.add(apiUrl);
    }
    return apiUrls;
  }
}
