import 'package:bus_app/flavors.dart';
import 'package:bus_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize environment configuration
  F.initialize(Flavor.dev);

  initialize();
}
