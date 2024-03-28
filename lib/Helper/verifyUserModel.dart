import 'dart:convert';

class VerifyUserDetails {
  bool? error;
  String? message;
  Data? data;

  VerifyUserDetails({
    this.error,
    this.message,
    this.data,
  });

  factory VerifyUserDetails.fromRawJson(String str) =>
      VerifyUserDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyUserDetails.fromJson(Map<String, dynamic> json) =>
      VerifyUserDetails(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null || !(json["data"] is Object)
            ? null
            : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? username;
  String? id;

  Data({
    this.username,
    this.id,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
      };
}
