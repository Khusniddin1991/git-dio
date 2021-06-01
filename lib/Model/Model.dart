import 'dart:convert';

List<Posting> postFromJson(String str) {
  return List<Posting>.from(json.decode(str).map((x) => Posting.fromJson(x)));
}

String postToJson(List<Posting> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posting {
  Posting({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory Posting.fromJson(Map<String, dynamic> json) => Posting(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}