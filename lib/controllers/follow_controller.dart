import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

import '../models/follow.dart';
import '../models/link.dart';
import 'package:http/http.dart' as http;

Future<Temperatures> getfollows(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // print(data.map((e) => Temperatures.fromJson(e).followers));
    print(Temperatures.fromJson(data).followingCount);
    return Temperatures.fromJson(data);
  }
  return Future.error('Somthing wrong');
}
