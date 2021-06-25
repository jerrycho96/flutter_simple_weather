import 'package:flutter/material.dart';
import 'package:simple_weather/data/my_location.dart';
import 'package:simple_weather/data/network.dart';
import 'package:simple_weather/screens/weather_screen.dart';

const apiKey = 'f210b2b92b8aa5f35bb5e811b5f991fd';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    // api 통신
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    // 날씨 데이터 저장
    var weatherData = await network.getJsonData();
    // 공기 데이터 저장
    var airData = await network.getAirData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          parseWeatherData: weatherData,
          parseAirPollution: airData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Image.asset(
            'image/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        ],
      ),
    );
  }
}
