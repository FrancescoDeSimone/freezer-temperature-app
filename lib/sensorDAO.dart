import 'package:freezerTemperatureApp/sensor.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SensorDAO extends DAOFactory {
  Stream<List<Sensor>> getDataFromSensor() async* {
    Db connection = await DAOFactory.getConnection();
    var coll = connection.collection('freezer');
    while (true) {
      yield await coll
          .find()
          .map((elem) => new Sensor(elem["humidity"], elem["temperature"],
              elem["doorStatus"], DateTime.parse(elem["date"])))
          .toList();
    }
  }
}

abstract class DAOFactory {
  
  static Future<Db> getConnection() async {
    Db db = new Db(
        "mongodb://freezer-db:kfFOvwxC7XcsIBvXFX9OKF72Pk9GVHOPFLZcgBE8dQcsP4yPaoJXBRSt2Tbq8w0JLRzhuK0OIoLg4oOOYTrLwg==@freezer-db.documents.azure.com:10255/freezer-db");
    await db.open(secure: true);
    return db;
  }

  Stream<List<Sensor>> getDataFromSensor();
}
