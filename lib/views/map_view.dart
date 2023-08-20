import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tt9_betweener_challenge/controllers/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.latLng});
  final LatLng latLng;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  var markers = HashSet<Marker>(); //collect// ion

  late GoogleMapController mapController;

  // final LatLng pos = const LatLng(31.500924829367356, 34.433945643528496);
  late BitmapDescriptor myIcon;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      markers.add(Marker(
          markerId: const MarkerId('1'),
          position: widget.latLng,
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            onTap: (latlong) {
              setState(() {
                markers.add(
                  Marker(
                      markerId: const MarkerId('1'),
                      position: latlong,
                      // icon: myIcon, //لازم تكون فيوتشر

                      infoWindow: const InfoWindow(title: "دوار الدحدوح")),
                );
              });
            },
            initialCameraPosition: CameraPosition(
              target: widget.latLng,
              zoom: 11.0,
            ),
            markers: markers,
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (markers.isNotEmpty) {
                await openMap(widget.latLng.latitude, widget.latLng.longitude);
              }
            },
            child: const Text('open in google maps'))
      ],
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launchUrl(
          Uri.parse(
            googleUrl,
          ),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}
