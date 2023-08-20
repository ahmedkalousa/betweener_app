import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/add_link.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome ,  ${snapshot.data?.user?.name} !',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return Text('loading');
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            width: double.infinity,
            child: Image(image: AssetImage('assets/imgs/qr_code.png')),
          ),
        ),
        Divider(
          indent: 40,
          endIndent: 40,
          thickness: 1.5,
          color: Colors.black,
          height: 60,
        ),
        FutureBuilder(
          future: links,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.all(12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final link = snapshot.data?[index].title;
                    final username = snapshot.data?[index].username;
                    return index == snapshot.data!.length - 1
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AddLinkScreen.id);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 36),
                              decoration: BoxDecoration(
                                  color: kLinksColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: kOnSecondaryColor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'ADD',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: kLightSecondaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Text(
                                  '$link',
                                  style: TextStyle(
                                      color: kOnSecondaryColor, fontSize: 20),
                                ),
                                Text(
                                  '@$username',
                                  style: TextStyle(
                                      color: kOnSecondaryColor, fontSize: 12),
                                ),
                              ],
                            ),
                          );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 8,
                    );
                  },
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Text('loading');
          },
        ),
      ],
    );
  }
}
