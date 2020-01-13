import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freezerTemperatureApp/sensorDAO.dart';

class FreezerPage extends StatefulWidget {
  FreezerPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _FreezerPageState createState() => _FreezerPageState();
}

class _FreezerPageState extends State<FreezerPage> {

  void prova(){
    SensorDAO sd = new SensorDAO();
    sd.getDataFromSensor(new DateTime.now().subtract(new Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      )
      );
  }
}
