import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAlert extends StatefulWidget {
  MapAlert() : super();

  final String title = "Path Alert";

  @override
  MapAlertState createState() => MapAlertState();
}

class MapAlertState extends State<MapAlert> {
  //

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(13.0237107, 77.5984784);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  final Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId("id1"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(13.0237107, 77.5984784),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id2"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(12.942815, 76.690047),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id3"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(18.141362, 75.503528),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id4"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(23.088939, 80.837484),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id5"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(26.003799, 74.439026),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id6"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(19.412114, 82.187090),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id7"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(27.732201, 79.042791),
      radius: 1000,
    ),
    Circle(
      circleId: CircleId("id8"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(8.495265, 77.584348),
      radius: 500,
    ),
    Circle(
      circleId: CircleId("id9"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(13.895723, 74.951603),
      radius: 500,
    ),
    Circle(
      circleId: CircleId("id10"),
      strokeColor: Colors.red,
      fillColor: Colors.black38,
      center: LatLng(16.026621, 80.217094),
      radius: 500,
    ),
  ]);

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(13.0237107, 77.5984784),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
      heroTag: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            circles: circles,
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  button(_onMapTypeButtonPressed, Icons.map),
                  SizedBox(
                    height: 16.0,
                  ),
                  button(_onAddMarkerButtonPressed, Icons.add_location),
                  SizedBox(
                    height: 16.0,
                  ),
                  button(_goToPosition1, Icons.location_searching),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
