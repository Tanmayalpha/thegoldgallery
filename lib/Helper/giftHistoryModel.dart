import 'dart:convert';

class GiftHistoryDetails {
    bool? error;
    String? message;
    List<GiftHistoryList>? data;

    GiftHistoryDetails({
        this.error,
        this.message,
        this.data,
    });

    factory GiftHistoryDetails.fromRawJson(String str) => GiftHistoryDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftHistoryDetails.fromJson(Map<String, dynamic> json) => GiftHistoryDetails(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? [] : List<GiftHistoryList>.from(json["data"]!.map((x) => GiftHistoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GiftHistoryList {
    String? id;
    String? donorId;
    String? doneeId;
    String? gm;
    String? amount;
    String? metalType;
    String? createdAt;
    String? donor;
    String? donee;

    GiftHistoryList({
        this.id,
        this.donorId,
        this.doneeId,
        this.gm,
        this.amount,
        this.metalType,
        this.createdAt,
        this.donor,
        this.donee,
    });

    factory GiftHistoryList.fromRawJson(String str) => GiftHistoryList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftHistoryList.fromJson(Map<String, dynamic> json) => GiftHistoryList(
        id: json["id"],
        donorId: json["donor_id"],
        doneeId: json["donee_id"],
        gm: json["gm"],
        amount: json["amount"],
        metalType: json["metal_type"],
        createdAt: json["created_at"] == null ? null :json["created_at"],
        donor: json["donor"],
        donee: json["donee"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "donor_id": donorId,
        "donee_id": doneeId,
        "gm": gm,
        "amount": amount,
        "metal_type": metalType,
        "created_at": createdAt,
        "donor": donor,
        "donee": donee,
    };
}
