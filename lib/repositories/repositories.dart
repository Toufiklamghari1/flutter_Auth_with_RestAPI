import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  static String mainUrl = "http://192.168.1.21:8080";
  var loginUrl = '$mainUrl/login';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String phone, String password) async {
    var response = await http.post(loginUrl,headers: {
      'Content-Type': 'application/json'
    }, body: jsonEncode({
      "username": phone,
      "password": password,
    }));

    return jsonDecode(response.body)["access_token"];
  }

}