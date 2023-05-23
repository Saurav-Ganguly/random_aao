import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:random_aao/person.dart';

Future<List<List<dynamic>>> getCsvData() async {
  final String csvData = await rootBundle.loadString('assets/output_file.csv');
  List<List<dynamic>> data = const CsvToListConverter().convert(csvData);
  return data;
}

Future<Person> readCsvFile(int recordNo) async {
  final fields = await getCsvData();
  var person = fields[recordNo];
  var rollNo = person[1].toString();
  var name = person[2];
  var dateOfBirth = person[4];
  var selectedCat = person[6];
  var state = person[16];
  var rank = person[8].toString();

  return Person(
      name: name,
      dateOfBirth: dateOfBirth,
      rollNo: rollNo,
      selectedCat: selectedCat,
      state: state,
      rank: rank);
}
