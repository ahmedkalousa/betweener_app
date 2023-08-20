import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import '../models/user.dart';

Future<User> getLocalUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userFromJson(prefs.getString('user')!);
  }
  return Future.error('not found');
}

Future<List<UserClass>> getUsers(context, String name) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(searchUrl), headers: {
    'Authorization': 'Bearer ${user.token}'
  }, body: {
    "name": name,
  });
  print('***********************************************${response.body}');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['user'] as List<dynamic>;

    return data.map((e) => UserClass.fromJson(e)).toList();
  }
  return Future.error('error');
}
