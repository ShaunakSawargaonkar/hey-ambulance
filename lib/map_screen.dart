import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './direction_model.dart';
import './direction_repository.dart';

class MapScreen extends StatefulWidget {
  static final routeName = '/MapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

GoogleMapController _googleMapController;
Directions _info;

@override
void dispose() {
  _googleMapController.dispose();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    Marker origin, destination;
    Map a = ModalRoute.of(context).settings.arguments;
    setState(() => origin = Marker(
        markerId: MarkerId('origin'),
        infoWindow: InfoWindow(title: "Origin"),
        position: LatLng(a["initialPos"].latitude, a["initialPos"].longitude)));
    //
    setState(() => destination = Marker(
        markerId: MarkerId('destination'),
        infoWindow: InfoWindow(title: "Destination"),
        position:
            LatLng(a['destinationPos']['Lat'], a['destinationPos']['Long']),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
    var initialCamerPosition = CameraPosition(
      target: LatLng(a["initialPos"].latitude, a["initialPos"].longitude),
      zoom: 11.5,
    );
    void initState() async {
      super.initState();
      final directions = await DirectionsRepository().getDirections(
          origin: origin.position, destination: destination.position);
      setState(() => _info = directions);
    }

    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: initialCamerPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            origin,
            destination,
          },
          polylines: {
            if (_info != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: _info.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(initialCamerPosition)),
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }
}
