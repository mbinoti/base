import 'package:flutter/material.dart';
import 'package:base/utils/urlHelper.dart';
import 'package:base/viewmodels/placeViewModel.dart';

class PlaceList extends StatelessWidget {
  final List<PlaceViewModel>? places;
  Function(PlaceViewModel)? onSelected;

  PlaceList({this.places, this.onSelected});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.places!.length,
      itemBuilder: (context, index) {
        final place = this.places![index]; //
        return ListTile(
          onTap: () {
            this.onSelected!(place);
          },
          leading: Container(
            width: 100,
            height: 100,
            child: Image.network(
              UrlHelper.urlForReferenceImage(place.photoURL!),
              fit: BoxFit.cover,
            ),
          ),
          title: Text(place.name!),
        );
      },
    );
  }
}
