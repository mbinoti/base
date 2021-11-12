import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:base/services/webservice.dart';
import 'package:base/viewmodels/placeViewModel.dart';

class PlaceListViewModel extends ChangeNotifier {
  var places = <PlaceViewModel>[];
  var mapType = MapType.normal;

  void toogleMapType() {
    this.mapType =
        this.mapType == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }

  Future<void> fetchPlacesByKeywordAndPosition(
      String keyword, double latitude, double longitude) async {
    final results = await Webservice()
        .fetchPlacesByKeywordAndPosition(keyword, latitude, longitude);

    this.places = results.map((place) => PlaceViewModel(place)).toList();

    notifyListeners();
  }
}
