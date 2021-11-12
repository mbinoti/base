import 'package:flutter/material.dart';
import 'package:base/pages/homePage.dart';
import 'package:base/viewmodels/placeListViewModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

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
