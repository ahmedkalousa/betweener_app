// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

import 'link.dart';

Temperatures temperaturesFromJson(String str) =>
    Temperatures.fromJson(json.decode(str));

String temperaturesToJson(Temperatures data) => json.encode(data.toJson());

class Temperatures {
  int followingCount;
  int followersCount;
  List<Follow> following;
  List<Follow> followers;

  Temperatures({
    required this.followingCount,
    required this.followersCount,
    required this.following,
    required this.followers,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
        followingCount: json["following_count"],
        followersCount: json["followers_count"],
        following:
            List<Follow>.from(json["following"].map((x) => Follow.fromJson(x))),
        followers:
            List<Follow>.from(json["followers"].map((x) => Follow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "following_count": followingCount,
        "followers_count": followersCount,
        "following": List<dynamic>.from(following.map((x) => x.toJson())),
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
      };
}

class Follow {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String createdAt;
  String updatedAt;
  int isActive;
  dynamic country;
  dynamic ip;
  double? long;
  double? lat;
  List<Link> links;

  Follow({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
    required this.links,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isActive: json["isActive"],
        country: json["country"],
        ip: json["ip"],
        long: json["long"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "isActive": isActive,
        "country": country,
        "ip": ip,
        "long": long,
        "lat": lat,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}
