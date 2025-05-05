import 'package:package_info_plus/package_info_plus.dart';

enum Flavor { dev, prod }

class F {
  final Flavor env;
  final String title;
  final String baseUrl;

  F({required this.env, required this.title, required this.baseUrl}) {
    _init();
  }

  static late F _instance;

  static F get instance => _instance;

  /// Package info
  late PackageInfo _packageInfo;

  _init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = F._dev();
        break;
      case Flavor.prod:
        _instance = F._prod();
        break;
    }
  }

  // Development environment configuration
  factory F._dev() {
    return F(
      env: Flavor.dev,
      title: 'BusApp Dev',
      baseUrl: 'https://api-infra-dev.movv.co',
    );
  }

  // Production environment configuration
  factory F._prod() {
    return F(
      env: Flavor.prod,
      title: 'BusApp',
      baseUrl: 'https://api-infra.movv.co',
    );
  }

  bool get isDev => env == Flavor.dev;

  bool get isProd => env == Flavor.prod;

  /// Get app version with build number
  String get versionWithBuild =>
      '${_packageInfo.version}+${_packageInfo.buildNumber}';

  /// Get app version
  String get version => _packageInfo.version;

  /// Get app build number
  String get buildNumber => _packageInfo.buildNumber;

  /// Get app package name
  String get packageName => _packageInfo.packageName;
}
