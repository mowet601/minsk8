import 'package:json_annotation/json_annotation.dart';
import 'package:minsk8/import.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel {
  final String id;
  final String url;
  final int width;
  final int height;

  ImageModel(this.id, this.url, this.width, this.height);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}