import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../model/weather_data_current.dart';
import '../utils/custom_colors.dart';

class ComfortLevel extends StatelessWidget {
  const ComfortLevel({
    super.key,
    required this.weatherDataCurrent,
  });

  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Comfort Level",
            style: GoogleFonts.oxygen(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: <Widget>[
              Center(
                child: SleekCircularSlider(
                  max: 100,
                  min: 0,
                  initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      progressBarWidth: 12,
                      trackWidth: 12,
                    ),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor:
                          CustomColors.firstGradientColor.withAlpha(100),
                      progressBarColors: [
                        CustomColors.firstGradientColor,
                        CustomColors.secondGradientColor,
                      ],
                    ),
                    infoProperties: InfoProperties(
                      bottomLabelText: "Humidity",
                      bottomLabelStyle: GoogleFonts.oxygen(
                        fontSize: 18,
                        color: Colors.black,
                        letterSpacing: 0.1,
                        height: 1.5,
                      ),
                      mainLabelStyle: GoogleFonts.oxygen(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                      modifier: (double value) {
                        return "${value.toInt()}%";
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Feels Like:",
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            height: 0.8,
                          ),
                        ),
                        TextSpan(
                          text: "${weatherDataCurrent.current.feelsLike}°",
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            height: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: CustomColors.dividerLine,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "UV Index:",
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            height: 0.8,
                          ),
                        ),
                        TextSpan(
                          text: "${weatherDataCurrent.current.uvIndex}",
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            height: 0.8,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
