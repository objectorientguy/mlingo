// Data model class for row data

import 'package:hive_flutter/adapters.dart';

part 'table_model.g.dart';

@HiveType(typeId: 0)
class TableModel {
  @HiveField(0)
  final String createdBy;
  @HiveField(1)
  final String status;
  @HiveField(2)
  final String key;
  @HiveField(3)
  final String english;
  @HiveField(4)
  final String hindi;

  TableModel({
    required this.createdBy,
    required this.status,
    required this.key,
    required this.english,
    required this.hindi,
  });
}
