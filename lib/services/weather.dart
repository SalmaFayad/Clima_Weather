import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const appId = '27bbc78693ccde74065031df7b399cb5';
const openWeatherMap = 'http://api.openweathermap.org/data/2.5/weather';


class WeatherModel {
  Future<dynamic> getLocationByCityName(String cityName)async{
    NetworkHelper networkHelper=NetworkHelper(
        '$openWeatherMap?q=$cityName&appid=$appId&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCurrentLocation() async {
    Location location = Location();
    await location
        .getCurrentLocation(); //it is return a future ,so we should wait it //if we want to use its return values (lat & long).
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMap?lat=${location.latitude}&lon=${location.longitude}&appid=$appId&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
