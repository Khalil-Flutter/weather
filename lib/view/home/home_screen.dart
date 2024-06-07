import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_controller.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/comfort_level.dart';
import '../../widgets/current_weather_widget.dart';
import '../../widgets/daily_data_forcast.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final globalController = Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            return globalController.checkLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      const SizedBox(height: 20),

                      /// header of home screen
                      const HeaderWidget(),

                      /// for our current temp
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getCurrentWeatherData()
                            .getCurrentWeather(),
                      ),

                      /// for hourly forecast
                      HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getCurrentWeatherData()
                            .getHourlyWeather(),
                      ),

                      /// for daily forecast
                      DailyDataForecast(
                        weatherDataDaily: globalController
                            .getCurrentWeatherData()
                            .getDailyWeather(),
                      ),

                      /// divider line
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),

                      /// for comfort level
                      ComfortLevel(
                        weatherDataCurrent: globalController
                            .getCurrentWeatherData()
                            .getCurrentWeather(),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
