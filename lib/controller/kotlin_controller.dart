import 'package:flutter/services.dart';
import 'package:get/get.dart';

class KotlinController extends GetxController {
  static KotlinController instance = Get.find();
  static const platform = MethodChannel('battery');
  var batteryLevel = 0.obs;
  var deviceInfo = "".obs;

  Future<void> getBatteryLevel() async {
    try {
      var result = await platform.invokeMethod('getBatteryLevel');

      batteryLevel.value = result;
    } on PlatformException catch (e) {
      "Failed to get battery level: '${e.message}'.";
    }
  }

  Future<void> getDeviceInfo() async {
    try {
      var result = await platform.invokeMethod("other");
      print("DEvice Rsult : $result");
      deviceInfo.value = result.toString();
    } on PlatformException catch (e) {
      "Failed to get deviceInfo : '${e.message}'.";
    }
  }
}
