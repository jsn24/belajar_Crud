import 'dart:convert';

class Profile {
  int id;
  String email;
  String first_name;
  String last_name;
  String avatar;

  Profile({this.id = 0, this.email, this.first_name, this.last_name, this.avatar});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"], email: map["email"], first_name: map["first_name"], last_name: map["last_name"], avatar: map["avatar"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "email": email, "first_name": first_name, "last_name": last_name, "avatar": avatar};
  }

  @override
  String toString() {
    return 'Profile{id: $id, email: $email, first_name: $first_name, last_name:$last_name, avatar:$avatar}';
  }

}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}