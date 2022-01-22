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

  Future<void> _getBatteryLevel(String invok) async {
    var batteryLevel;
    try {
      var result = await platform.invokeMethod(invok);

      if (result.runtimeType == int) {
        batteryLevel = 'Battery level at $result % .';
        setState(() {
          _batteryLevel = batteryLevel;
        });
      } else if (result != null) {
        print("result : $result");
        setState(() {
          deviceInfo = batteryLevel;
        });
      } else {
        print("ERROR::::::::");
      }
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
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
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _getBatteryLevel('getBatteryLevel');
                },
                child: Text("Battery Percnt")),
            Text(
              deviceInfo.toString(),
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _getBatteryLevel('other');
                },
                child: Text("GetInfo"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
