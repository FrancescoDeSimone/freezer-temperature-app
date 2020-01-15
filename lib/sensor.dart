class Sensor {
  num _humidity;
  num _temperature;
  String _doorState;
  DateTime _date;

  num get humidity => _humidity;
  num get temperature => _temperature;
  String get doorState => _doorState;
  DateTime get date => _date;

  Sensor(num humidity, num temperature, String doorState, DateTime date) {
    this._humidity = humidity;
    this._temperature = temperature;
    this._doorState = doorState;
    this._date = date;
  }
}
