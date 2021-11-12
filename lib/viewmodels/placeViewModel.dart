import 'package:base/models/place.dart' show Place;

class PlaceViewModel {
  Place? _place;
  PlaceViewModel(Place place) {
    this._place = place;
  }

  String? get placeId {
    return this._place!.placeId;
  }

  String? get photoURL {
    return this._place!.photoURL;
  }

  String? get name {
    return this._place!.name;
  }

  double? get latitude {
    return this._place!.latitude;
  }

  double? get longitude {
    return this._place!.longitude;
  }
}
