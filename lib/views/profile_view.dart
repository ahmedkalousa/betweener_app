import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/update_link.dart';

import '../constants.dart';
import '../controllers/link_controller.dart';
import '../controllers/location.dart';
import '../models/follow.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geocoding/geocoding.dart';
import 'add_link.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Color addressColor = Colors.blue;
  MyLocation location = MyLocation();
  late Future<User> user;
  late Future<List<Link>> links;
  late Future<Temperatures> follow = getfollows(context);
  List<Placemark>? placemarks;
  Future<void> getPlaceMarks(lat, long) async {
    placemarks =
        await placemarkFromCoordinates(lat, long, localeIdentifier: 'en_US');
  }

  Future<MyLocation> getLocation() async {
    MyLocation location = MyLocation();

    await location.getCurrentLocation();
    return location;
  }

  @override
  void initState() {
    getLocation();
    user = getLocalUser();
    links = getLinks(context);
    follow;
    getPlaceMarks(location.lat, location.long);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddLinkScreen.id);
          },
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          backgroundColor: kPrimaryColor,
          shape: CircleBorder(),
          heroTag: null,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(35)),
                      padding:
                          EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    'https://media.cnn.com/api/v1/images/stellar/prod/230605121058-mime-karim-benzema.jpg?c=1x1'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: user,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${snapshot.data?.user?.name}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        );
                                      }
                                      return Text('loading');
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  FutureBuilder(
                                    future: user,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            '${snapshot.data?.user?.email}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        );
                                      }
                                      return Text('loading');
                                    },
                                  ),
                                  Text(
                                    '+970598838751',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: kSecondaryColor),
                                        child: FutureBuilder(
                                          future: follow,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                child: Text(
                                                  'followers ${snapshot.data!.followersCount}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: kPrimaryColor),
                                                ),
                                              );
                                            }
                                            return Text('loading');
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: kSecondaryColor),
                                        child: FutureBuilder(
                                          future: follow,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                child: Text(
                                                  'following ${snapshot.data!.followingCount}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: kPrimaryColor),
                                                ),
                                              );
                                            }
                                            return Text('loading');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Text(
                                  'Address:',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    placemarks![0].name ?? 'Unknown Place',
                                    style: TextStyle(
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: links,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          int? id = snapshot.data![index].id;
                          final data = {
                            'title': snapshot.data?[index].title,
                            'link': snapshot.data?[index].link,
                            'id': snapshot.data?[index].id
                          };
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (context) {
                                      Navigator.pushNamed(
                                        context,
                                        UpdateLinkScreen.id,
                                        arguments: data,
                                      );
                                    },
                                    backgroundColor: kSecondaryColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (context) {
                                      setState(() {
                                        deleteLink(id!);
                                        getLinks(context);
                                      });
                                    },
                                    backgroundColor: kDangerColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? kLightDangerColor
                                      : kLightPrimaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data?[index].title}',
                                      style: TextStyle(
                                        color: index % 2 == 0
                                            ? kOnLightDangerColor
                                            : kPrimaryColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${snapshot.data?[index].link}',
                                      style: TextStyle(
                                        color: index % 2 == 0
                                            ? kOnLightDangerColor
                                            : kPrimaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Text('loading');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
