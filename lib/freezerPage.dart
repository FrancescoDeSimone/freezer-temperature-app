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
  SensorDAO sd = new SensorDAO();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xff1976d2),
                  //backgroundColor: Color(0xff308e1c),
                  bottom: TabBar(
                    indicatorColor: Color(0xff9962D0),
                    tabs: [
                      Tab(
                        text: "Humidity",
                      ),
                      Tab(text: "Temperature"),
                    ],
                  ),
                  title: Text('Flutter Charts'),
                ),
                body: StreamBuilder<List<Sensor>>(
                  stream: sd.getDataFromSensor(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Sensor>> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Reaching database');
                      case ConnectionState.waiting:
                        return Text('Awaiting Data...');
                      case ConnectionState.active:
                        return TabBarView(children: [
                          Container(
                              child: Column(children: [
                            Expanded(
                                flex: 5,
                                child: new charts.TimeSeriesChart(
                                  [
                                    new charts.Series<Sensor, DateTime>(
                                      id: 'Humidity',
                                      colorFn: (_, __) => charts
                                          .MaterialPalette.blue.shadeDefault,
                                      domainFn: (Sensor s, _) => s.date,
                                      measureFn: (Sensor s, _) => s.humidity,
                                      data: snapshot.data,
                                    ),
                                  ],
                                  animate: false,
                                  defaultRenderer:
                                      new charts.LineRendererConfig(),
                                  customSeriesRenderers: [
                                    new charts.PointRendererConfig(
                                        customRendererId: 'customPoint')
                                  ],
                                  dateTimeFactory:
                                      const charts.LocalDateTimeFactory(),
                                )),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(children: [
                                    Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("Average",
                                                        style: TextStyle(
                                                            height: 3,
                                                            fontSize: 30)),
                                                    Text(((snapshot.data
                                                                .map((sensor) =>
                                                                    sensor
                                                                        .humidity)
                                                                .reduce((value,
                                                                        element) =>
                                                                    value +
                                                                    element)) /
                                                            snapshot
                                                                .data.length)
                                                        .toStringAsFixed(1))
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("Current",
                                                        style: TextStyle(
                                                            height: 3,
                                                            fontSize: 30)),
                                                    Text(
                                                        '${snapshot.data.last.humidity}')
                                                  ],
                                                ))
                                          ],
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Column(children: [
                                          Text(
                                            "Door status",
                                            style: TextStyle(
                                                height: 3, fontSize: 30),
                                          ),
                                          Text(
                                              '${snapshot.data.last.doorState}'),
                                        ])))
                                  ]),
                                ))
                          ])),
                          Container(
                              child: Column(children: [
                            Expanded(
                                flex: 5,
                                child: new charts.TimeSeriesChart(
                                  [
                                    new charts.Series<Sensor, DateTime>(
                                      id: 'Temperature',
                                      colorFn: (_, __) => charts
                                          .MaterialPalette.blue.shadeDefault,
                                      domainFn: (Sensor s, _) => s.date,
                                      measureFn: (Sensor s, _) => s.temperature,
                                      data: snapshot.data,
                                    ),
                                  ],
                                  animate: false,
                                  defaultRenderer:
                                      new charts.LineRendererConfig(),
                                  customSeriesRenderers: [
                                    new charts.PointRendererConfig(
                                        customRendererId: 'customPoint')
                                  ],
                                  dateTimeFactory:
                                      const charts.LocalDateTimeFactory(),
                                )),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(children: [
                                    Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("Average",
                                                        style: TextStyle(
                                                            height: 3,
                                                            fontSize: 30)),
                                                    Text(((snapshot.data
                                                                .map((sensor) =>
                                                                    sensor
                                                                        .temperature)
                                                                .reduce((value,
                                                                        element) =>
                                                                    value +
                                                                    element)) /
                                                            snapshot
                                                                .data.length)
                                                        .toStringAsFixed(1))
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("Current",
                                                        style: TextStyle(
                                                            height: 3,
                                                            fontSize: 30)),
                                                    Text(
                                                        '${snapshot.data.last.temperature}')
                                                  ],
                                                ))
                                          ],
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Column(children: [
                                          Text(
                                            "Door status",
                                            style: TextStyle(
                                                height: 3, fontSize: 30),
                                          ),
                                          Text(
                                              '${snapshot.data.last.doorState}'),
                                        ])))
                                  ]),
                                ))
                          ]))
                        ]);
                      case ConnectionState.done:
                        return Text('bye');
                    }
                    return CircularProgressIndicator();
                  },
                ))));
  }
}
