import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/weather_data_daily.dart';
import '../utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  const DailyDataForecast({
    super.key,
    required this.weatherDataDaily,
  });

  final WeatherDataDaily weatherDataDaily;

  String getDay(final day) {
    DateTime days = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(days);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Next Days Forecast",
              style: GoogleFonts.oxygen(
                fontSize: 18,
                color: CustomColors.textColorBlack,
              ),
            ),
          ),
          dailyList()
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: GoogleFonts.oxygen(
                          fontSize: 16,
                          color: CustomColors.textColorBlack,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png",
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      '${weatherDataDaily.daily[index].temp!.min}°/${weatherDataDaily.daily[index].temp!.max}°',
                      style: GoogleFonts.oxygen(
                        fontSize: 16,
                        color: CustomColors.textColorBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
