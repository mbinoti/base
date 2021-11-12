class Place {
  final String? name;
  final double? latitude;
  final double? longitude;
  final String? placeId;
  final String? photoURL;

  Place(
      {this.name, this.latitude, this.longitude, this.placeId, this.photoURL});

  factory Place.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];
    Iterable photos = json['photos'];

    return Place(
        name: json['name'],
        latitude: location['lat'],
        longitude: location['lng'],
        placeId: json['place_id'],
        photoURL: photos.isEmpty
            ? 'images/img1.png'
            : photos.first['photo_reference'].toString());
  }
}
