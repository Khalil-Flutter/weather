import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../api/fetch_weather.dart';
import '../model/weather_data.dart';

class GlobalController extends GetxController {
  static GlobalController get instance => Get.find();

  /// create various variables
  final RxBool isLoading = true.obs;
  final RxDouble lat = 0.0.obs;
  final RxDouble lon = 0.0.obs;
  final RxInt currentIndex = 0.obs;
  final weatherData = WeatherData().obs;

  /// instances for them to be called
  RxBool get checkLoading => isLoading;

  RxDouble get checkLat => lat;

  RxDouble get checkLon => lon;

  @override
  void onInit() {
    if (isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  WeatherData getCurrentWeatherData() {
    return weatherData.value;
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    /// return if service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    /// status of Permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      /// request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission is denied");
      }
    }

    /// getting the current position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      /// update our lat and lon
      lat.value = value.latitude;
      lon.value = value.longitude;

      /// calling our weather api
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return currentIndex;
  }
}
