import 'package:bus_app/core/config/router_config.dart';
import 'package:bus_app/core/config/theme_config.dart';
import 'package:bus_app/core/l10n/l10n.dart';
import 'package:bus_app/presentation/notifiers/language_notifier.dart';
import 'package:bus_app/presentation/notifiers/theme_notifier.dart';
import 'package:bus_app/presentation/providers/providers.dart';
import 'package:bus_app/presentation/states/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the router from the provider
    final router = ref.watch(routerProvider);

    // Get locale from provider
    final locale = ref.watch(localeProvider);

    final flavor = ref.watch(flavorProvider);

    // Determine which theme to use based on theme state
    // Get theme state from provider
    final themeState = ref.watch(themeStateProvider);

    ThemeData lightTheme;
    ThemeData darkTheme;

    switch (themeState.themeType) {
      case ThemeType.vibrant:
        lightTheme = ThemeConfig.vibrantLightTheme();
        darkTheme = ThemeConfig.vibrantDarkTheme();
        break;
      case ThemeType.professional:
        lightTheme = ThemeConfig.professionalLightTheme();
        darkTheme = ThemeConfig.professionalDarkTheme();
        break;
      case ThemeType.system:
      default:
        // Use default Material 3 themes for system mode
        final colorScheme = ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        );

        lightTheme = ThemeData(colorScheme: colorScheme, useMaterial3: true);

        darkTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        );
        break;
    }

    // Determine theme mode
    ThemeMode themeMode;
    if (themeState.themeType == ThemeType.system) {
      themeMode = ThemeMode.system;
    } else {
      themeMode = themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }

    return MaterialApp.router(
      title: flavor.title,
      debugShowCheckedModeBanner: flavor.isDev,
      // Theme configuration
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      // Localization configuration
      locale: locale,
      // Set from provider
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,

      // Router configuration
      routerConfig: router,
    );
  }
}
