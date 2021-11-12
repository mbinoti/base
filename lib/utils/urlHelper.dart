class UrlHelper {
  static String urlForReferenceImage(String photoReferenceId) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&'
        'photoreference=$photoReferenceId&key=AIzaSyD_PaNLLYmK0Ch9AsqIb3OwgLXCv9kYMRk';
  }

  static String urlForPlaceKeywordAndLocation(
      String keyword, double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude&radius=1500&type=restaurant'
        '&keyword=$keyword&key=AIzaSyD_PaNLLYmK0Ch9AsqIb3OwgLXCv9kYMRk';
  }
}
