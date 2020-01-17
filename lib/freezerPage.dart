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
                              height: 100,
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Expanded(
                                      flex: 5,
                                        child: new charts.TimeSeriesChart(
                                      [
                                        new charts.Series<Sensor, DateTime>(
                                          id: 'Humidity',
                                          colorFn: (_, __) => charts
                                              .MaterialPalette
                                              .blue
                                              .shadeDefault,
                                          domainFn: (Sensor s, _) => s.date,
                                          measureFn: (Sensor s, _) =>
                                              s.humidity,
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
child:
                                    Container(
                                        height: 50,
                                        width: 100,
                                        child: Flex(
                                          mainAxisSize: MainAxisSize.max,
                                          direction: Axis.horizontal,
                                          children: [
                                          Row(children: [
                                            Expanded(
                                              child:
                                              Text(
                                              "Average",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                                                                        Expanded(                                              child:


                                            Text(
                                              "Current",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))
                                          ]),
                                          Row(children: [
                                            Text("Average"),
                                            Text("Current")
                                          ])
                                        ]))
                          )]))),
                          Container(
                              child: Column(
                            children: <Widget>[
                              new charts.TimeSeriesChart(
                                [
                                  new charts.Series<Sensor, DateTime>(
                                    id: 'Temperature',
                                    colorFn: (_, __) =>
                                        charts.MaterialPalette.red.shadeDefault,
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
                              ),
                              Container(
                                  child: Column(children: [
                                Row(children: [
                                  Text("Average"),
                                  Text("Current")
                                ]),
                                Row(children: [
                                  Text("Average"),
                                  Text("Current")
                                ])
                              ]))
                            ],
                          ))
                        ]);
                      case ConnectionState.done:
                        return Text('bye');
                    }
                    return CircularProgressIndicator();
                  },
                ))));
  }
}
