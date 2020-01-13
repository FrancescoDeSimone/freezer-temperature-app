class Sensor {
  double _humidity;
  double _temperature;
  String _doorState;
  DateTime _date;

 double get humidity => _humidity;
 double get temperature => _temperature;
 String get doorState => _doorState;
DateTime get date => _date;

  Sensor(double humidity, double temperature,String doorState,DateTime date){
  _humidity = humidity;
  _temperature = temperature;
  _doorState = doorState;
  _date = date;
  }


}
