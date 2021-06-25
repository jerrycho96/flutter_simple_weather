import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather/model/model.dart';
import 'package:timer_builder/timer_builder.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityName;
  int? temp2;
  Widget? icon;
  String? des;
  Widget? airIcon;
  Widget? airState;
  double? dust1;
  double? dust2;

  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];

    des = weatherData['weather'][0]['description'];
    temp2 = temp.round();
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);

    print(temp2);
    print(cityName);
  }

  String? getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 투명처리
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0, // 그림자 삭제
        backgroundColor: Colors.transparent, // 배경 투명
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.near_me),
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
            iconSize: 30,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
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
                              SizedBox(
                                height: 150,
                              ),
                              Text(
                                '$cityName',
                                style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(
                                    Duration(minutes: 1),
                                    builder: (context) {
                                      return Text(
                                        '${getSystemTime()}',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    DateFormat(' - EEEE, ').format(date),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('d MMM, yyy').format(date),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$temp2\u2103',
                                style: GoogleFonts.lato(
                                  fontSize: 100,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Row(
                                children: [
                                  icon!,
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '$des',
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          height: 30,
                          thickness: 2,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'AQI(대기질지수)',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  airIcon!,
                                  SizedBox(
                                    height: 10,
                                  ),
                                  airState!,
                                ],
                              ),
                              Container(
                                width: 94,
                                child: Column(
                                  children: [
                                    Text(
                                      '미세먼지',
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '$dust1',
                                      style: GoogleFonts.lato(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '㎍/m³',
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 94,
                                child: Column(
                                  children: [
                                    Text(
                                      '초미세먼지',
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '$dust2',
                                      style: GoogleFonts.lato(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '㎍/m³',
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
