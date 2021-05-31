import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
// to be const over the program

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    var weatherData= await WeatherModel().getCurrentLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherData: weatherData,);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 80,
      ),
        );
  }
}
