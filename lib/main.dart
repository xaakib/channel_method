import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:methodchannel/controller/controller_initalization.dart';

import 'controller/kotlin_controller.dart';

void main() {
  Get.put(KotlinController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${kotlinController.batteryLevel} %",
                style: const TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await kotlinController.getBatteryLevel();
                  },
                  child: const Text("Battery Percnt")),
              Text(
                kotlinController.deviceInfo.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await kotlinController.getDeviceInfo();
                  },
                  child: const Text("GetInfo"))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
