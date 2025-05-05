import 'package:bus_app/flavors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for accessing environment configuration
final flavorProvider = Provider<F>((ref) {
  return F.instance;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'Shared Preferences must be initialized in main.dart',
  );
});
