import 'package:test_crud/src/model_class/profile.dart';
import 'package:http/http.dart' as client;

class ApiService {
  final String baseUrl = "https://reqres.in/api/users";
  // Client client = Client();

  Future<List<Profile>> getProfiles() async {
    final response = await client.get(baseUrl);
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      baseUrl,
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Profile data) async {
    final response = await client.put(
      "$baseUrl/${data.id}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProfile(int id) async {
    final response = await client.delete(
      "$baseUrl/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}