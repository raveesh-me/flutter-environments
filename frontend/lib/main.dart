import 'package:flutter/material.dart';
import 'package:plausible_analytics/plausible_analytics.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

const String serverUrl =
    String.fromEnvironment('SERVER_URL', defaultValue: "http://localhost:8001");
const String domain =
    String.fromEnvironment('DOMAIN', defaultValue: "localhost");

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  final Plausible plausible = Plausible(serverUrl, domain);
  plausible.event(
    name: 'SampleItemListView',
    props: {'items': 'asdas'},
    page: "DemoPage",
    referrer: "Raveesh"
  );

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
