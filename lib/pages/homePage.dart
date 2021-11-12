import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:base/viewmodels/placeListViewModel.dart';
import 'package:base/viewmodels/placeViewModel.dart';
import 'package:base/widgets/placelist.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'places',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<PlaceListViewModel>(
            create: (_) => PlaceListViewModel(),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  bool? _locationServiceEnabled;
  LocationPermission? _permission;
  //final availableMaps = MapLauncher.installedMaps;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    // Para consultar a localização atual do dispositivo.
    // desiredAccuracy: a precisão dos dados de localização que seu aplicativo deseja receber
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> _getLocationServiceEnabled() async =>
      _locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  Future<void> _getLastKnowPosition() async =>
      _currentPosition = await Geolocator.getLastKnownPosition();

  Future<void> _getCheckPermission() async =>
      _permission = await Geolocator.checkPermission().then((value) => null);

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
    return places.map((place) {
      return Marker(
        markerId: MarkerId(place.placeId!),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: place.name),
        position: LatLng(place.latitude!, place.longitude!),
      );
    }).toSet();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14)));
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: vm.mapType,
            markers: _getPlaceMarkers(vm.places),
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(45.521563, -122.677433),
              zoom: 14,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  vm.fetchPlacesByKeywordAndPosition(value,
                      _currentPosition!.latitude, _currentPosition!.longitude);
                },
                decoration: InputDecoration(
                  labelText: 'Search here',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          Visibility(
            visible: vm.places.length > 0 ? true : false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    child: Text('Show List',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => PlaceList(
                          places: vm.places,
                          onSelected: null,
                        ),
                      );
                    },
                    //color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 20,
            child: FloatingActionButton(
              child: Icon(Icons.map),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
