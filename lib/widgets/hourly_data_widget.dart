import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/global_controller.dart';
import '../model/weather_data_hourly.dart';
import '../utils/custom_colors.dart';

class HourlyDataWidget extends StatefulWidget {
  const HourlyDataWidget({
    super.key,
    required this.weatherDataHourly,
  });

  final WeatherDataHourly weatherDataHourly;

  @override
  State<HourlyDataWidget> createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            "Today",
            style: GoogleFonts.oxygen(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 110,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 25
            : widget.weatherDataHourly.hourly.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.dividerLine.withAlpha(150),
                        blurRadius: 30,
                        spreadRadius: 1,
                        offset: const Offset(0.5, 0),
                      ),
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor,
                            ],
                          )
                        : null,
                  ),
                  child: HourlyDetails(
                    temp: widget.weatherDataHourly.hourly[index].temp!,
                    timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                    weatherIcon: widget
                        .weatherDataHourly.hourly[index].weather![0].icon!,
                    index: index,
                    cardIndex: cardIndex.toInt(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  const HourlyDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.weatherIcon,
    required this.index,
    required this.cardIndex,
  });

  final int temp, timeStamp, index, cardIndex;
  final String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat("jm").format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          getTime(
            timeStamp,
          ),
          style: GoogleFonts.oxygen(
            color: cardIndex == index ? Colors.white : Colors.black,
          ),
        ),
        Image.asset(
          "assets/weather/$weatherIcon.png",
          height: 50,
          width: 50,
        ),
        Text(
          "$temp°",
          style: GoogleFonts.oxygen(
            color: cardIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
