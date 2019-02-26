import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Connection {
  String name;
  String url;
  String token;
  String username;
  String password;

  Connection(this.name, this.url, {this.token, this.username, this.password});

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
        json["name"],
        json["url"],
        token: json["token"],
        username: json["username"],
        password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    if (this.token != null) {
      return {
        "name": this.name,
        "url": this.url,
        "token": this.token,
      };
    } else {
      return {
        "name": this.name,
        "url": this.url,
        "username": this.username,
        "password": this.password,
      };
    }
  }
}
