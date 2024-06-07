import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/weather_data_current.dart';
import '../utils/custom_colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.weatherDataCurrent,
  });

  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: <Widget>[
          /// temperature area
          temperatureAreaWidget(),
          const SizedBox(
            height: 15,
          ),

          /// more details -windSpeed, humidity, clouds
          currentWeatherMoreDetailsWidget(),
        ],
      ),
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherDataCurrent.current.windSpeed}km/h',
                textAlign: TextAlign.center,
                style: GoogleFonts.oxygen(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.textColorBlack,
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherDataCurrent.current.clouds}%',
                textAlign: TextAlign.center,
                style: GoogleFonts.oxygen(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.textColorBlack,
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherDataCurrent.current.humidity}%',
                textAlign: TextAlign.center,
                style: GoogleFonts.oxygen(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.textColorBlack,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${weatherDataCurrent.current.temp!.toInt()}°',
                style: GoogleFonts.oxygen(
                  fontSize: 68,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.textColorBlack,
                ),
              ),
              TextSpan(
                text: '${weatherDataCurrent.current.weather![0].description}',
                style: GoogleFonts.oxygen(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
