import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageServiceImpl();
});

abstract class LocalStorageService {
  /// Saves string data to secure storage
  Future<void> saveSecureData(String key, String value);

  /// Retrieves string data from secure storage
  Future<String?> getSecureData(String key);

  /// Removes an item from secure storage
  Future<void> removeSecureData(String key);

  /// Checks if a key exists in secure storage
  Future<bool> containsKeyInSecureStorage(String key);

  /// Saves the last update timestamp
  Future<void> saveLastUpdateTime(String key);

  /// Gets the last update timestamp
  Future<DateTime?> getLastUpdateTime(String key);

  /// Determines if data is stale (older than specified duration)
  Future<bool> isDataStale(String key, Duration threshold);
}

class LocalStorageServiceImpl implements LocalStorageService {
  // Flutter Secure Storage instance for sensitive data
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Prefix for timestamp keys to avoid conflicts
  static const String _timestampPrefix = 'timestamp_';

  @override
  Future<void> saveSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    await saveLastUpdateTime(key);
  }

  @override
  Future<String?> getSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> removeSecureData(String key) async {
    await _secureStorage.delete(key: key);

    // Also remove the timestamp
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_timestampPrefix + key);
  }

  @override
  Future<bool> containsKeyInSecureStorage(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null;
  }

  @override
  Future<void> saveLastUpdateTime(String key) async {
    final timestamp = DateTime.now().toIso8601String();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_timestampPrefix + key, timestamp);
  }

  @override
  Future<DateTime?> getLastUpdateTime(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final timestampStr = prefs.getString(_timestampPrefix + key);

    if (timestampStr == null) {
      return null;
    }

    return DateTime.parse(timestampStr);
  }

  @override
  Future<bool> isDataStale(String key, Duration threshold) async {
    final lastUpdate = await getLastUpdateTime(key);

    if (lastUpdate == null) {
      return true;
    }

    final now = DateTime.now();
    final difference = now.difference(lastUpdate);

    return difference > threshold;
  }
}

// Storage keys
class StorageKeys {
  static const String weatherData = 'weather_data';
  static const String locationData = 'location_data';
  static const String lastSearchedCity = 'last_searched_city';
}
