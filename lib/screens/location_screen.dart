import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherData);
  }
  WeatherModel weather=WeatherModel();
  int temperature ;
  String weatherIcon ;
  String cityName ;
  String weatherMessage;

  void updateUi (dynamic weatherData){
    setState(() {
      if (weatherData==null)
        {
          temperature=0;
          weatherIcon='Error';
          weatherMessage='Unable to get weather data';
          cityName='';
          return;
        }
      double temp= weatherData['main']['temp'];
      temperature=temp.toInt();
      var condition=weatherData['weather'][0]['id'];
      cityName=weatherData['name'];
      weatherIcon=weather.getWeatherIcon(condition);
      weatherMessage=weather.getMessage(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData= await weather.getCurrentLocation();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typeName =await Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }) );
                      if(typeName!=null){
                        var weatherData =await weather.getLocationByCityName(typeName);
                        updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
