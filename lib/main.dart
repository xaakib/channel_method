import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  static const platform = MethodChannel('battery');
  var _batteryLevel;
  var deviceInfo;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _getBatteryLevel() async {
    try {
      var result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = result;
      });
    } on PlatformException catch (e) {
      "Failed to get battery level: '${e.message}'.";
    }
  }

  Future<void> _getDeviceInfo() async {
    try {
      var result = await platform.invokeMethod("other");
      print("DEvice Rsult : $result");

      setState(() {
        deviceInfo = deviceInfo;
      });
    } on PlatformException catch (e) {
      deviceInfo = "Failed to get deviceInfo : '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _batteryLevel.toString(),
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _getBatteryLevel();
                },
                child: const Text("Battery Percnt")),
            Text(
              deviceInfo.toString(),
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _getDeviceInfo();
                },
                child: const Text("GetInfo"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
