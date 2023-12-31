import 'package:flutter/foundation.dart';
import 'Package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  //String? userId;
  static String userEmail = '';
  static String userPassword = '';
  static String userAdmission = '';
  static String userName = '';
  static String userPhone = '';
  static String userId = '';

  //String? get getUserId => userId;

  String? get getUserName => userEmail;

  String? get getUserPassword => userPassword;

  static String errorMessage = "";
  static String signup_authMessage = "";
  static String signin_authMessage = "";
  Future<void> registerApple(
      String yop, String breed, String row, String col, String location) async {
    print("singuppppp");

    signup_authMessage = "";
    final response = await http.post(
        Uri.parse('https://brindle-aboard-manatee.glitch.me/registerApple'),
        headers: {
          "content-type": "application/x-www-form-urlencoded;charset=UTF-8",
        },
        body: {
          'yop': yop,
          'breed': breed,
          'row': row,
          'col': col,
          'location': location
        });

    Map<String, dynamic> map = jsonDecode(response.body);

    if (map['message'] != null) {
      signup_authMessage = map['message'];
    }

    if (map['error'] != null) {
      errorMessage = map['error']['message'];
    }
  }

  Future<void> signinUser(String email, String password) async {
    signin_authMessage = "";
    print("login called");
    final response = await http.post(
        Uri.parse('https://brindle-aboard-manatee.glitch.me/user/login'),
        headers: <String, String>{
          "content-type": "application/x-www-form-urlencoded;charset=UTF-8",
        },
        body: <String, String>{
          'userEmail': email,
          'userPassword': password,
        });

    Map<String, dynamic> map = await jsonDecode(response.body);
    print("responseee");
    print(map['message']);
    if (map['message'] != null && map['message'] == 'success') {
      signin_authMessage = map['message'];
    }
    if (map['error'] != null) {
      errorMessage = await map['error']['message'];
    }
  }

  String _localhost() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://192.168.43.167:3000/user/signIn';
    }
    print('called here');
    return 'http://192.168.43.167:3000/user/signIn';
  }
}
