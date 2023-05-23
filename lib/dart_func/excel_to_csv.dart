import 'dart:io';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';

void convertExcelToCsv(String excelFilePath, String outputCsvFilePath) {
  final bytes = File(excelFilePath).readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);
  final sheetName = excel.tables.keys.first;
  final sheet = excel.tables[sheetName]!;

  final csvData =
      sheet.rows.map((row) => row.map((cell) => cell?.value).toList()).toList();

  final csvFile = File(outputCsvFilePath);
  final csvSink = csvFile.openWrite();

  final csvString = const ListToCsvConverter().convert(csvData);
  csvSink.write(csvString);

  csvSink.close();
}

void main() {
  const excelFilePath = '../assets/aao_data.xlsx';
  const outputCsvFilePath = '../assets/output_file.csv';

  convertExcelToCsv(excelFilePath, outputCsvFilePath);
}
