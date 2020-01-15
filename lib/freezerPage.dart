import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freezerTemperatureApp/sensor.dart';
import 'package:freezerTemperatureApp/sensorDAO.dart';

class FreezerPage extends StatefulWidget {
  FreezerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FreezerPageState createState() => _FreezerPageState();
}

class _FreezerPageState extends State<FreezerPage> {
  List<Sensor> sensorsData;

  Future<void> initData() async {
    print("Get data from DB");
    SensorDAO sd = new SensorDAO();
    sensorsData = await sd.getDataFromSensor();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: Text('${sensorsData}')));
  }
}
