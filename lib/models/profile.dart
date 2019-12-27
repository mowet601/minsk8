import 'package:json_annotation/json_annotation.dart';
import 'package:minsk8/import.dart';

part 'profile.g.dart';

@JsonSerializable()
class ProfileModel {
  final MemberModel member;
  final int money;
  final List<PayModel> payList;
  final List<ItemModel> myItemList;
  final List<ItemModel> whishList;
  final List<ItemModel> underwayList;

  ProfileModel(
    this.member,
    this.money,
    this.payList,
    this.myItemList,
    this.whishList,
    this.underwayList,
  );

  avatarUrl() {
    return 'https://example.com/avatars/?id=${member.id}';
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}