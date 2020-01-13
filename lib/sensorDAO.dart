import 'package:freezerTemperatureApp/sensor.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SensorDAO extends DAOFactory{

  Future<List<Sensor>> getDataFromSensor(DateTime from) async {
    Db connection = await DAOFactory.getConnection();
    print(connection);
    var coll = connection.collection('freezer');
    var list = await coll.find(where.gt("date", from)).toList();
    List<Sensor> dataFromSensor;
    for(var elem in list){
      Sensor s = new Sensor(elem["humidity"],elem["temperature"],elem["doorStatus"],new DateTime(elem["date"]));
      dataFromSensor.add(s);
    }
    return dataFromSensor;
  }
}

class DAOFactory {
  static Future<Db> getConnection() async {
      Db db = new Db("mongodb://freezer-db:I9nJIZZaCHombESrNevYTBjPg1ChD4C8wJL7pj6ZefrW1BwGLqKit9DykRnu0ojd064uothomBdDjgzwI2g57Q==@freezer-db.documents.azure.com:10255/?ssl=true&replicaSet=globaldb");
      await db.open();
      return db;
  }
}