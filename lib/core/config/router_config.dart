import 'package:bus_app/core/utils/custom_transitions.dart';
import 'package:bus_app/presentation/pages/home_page.dart';
import 'package:bus_app/presentation/pages/setting/language_page.dart';
import 'package:bus_app/presentation/pages/setting/setting_page.dart';
import 'package:bus_app/presentation/pages/setting/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Router provider for Riverpod
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
        routes: [
          GoRoute(
            name: 'search',
            path: 'search',
            pageBuilder:
                (context, state) => CustomTransitions.slideTransition(
                  context: context,
                  state: state,
                  child: const HomePage(),
                ),
          ),
          GoRoute(
            name: 'settings',
            path: 'settings',
            pageBuilder:
                (context, state) => CustomTransitions.slideTransition(
                  context: context,
                  state: state,
                  child: const SettingPage(),
                ),
          ),
          GoRoute(
            name: 'login',
            path: 'login',
            pageBuilder:
                (context, state) => CustomTransitions.slideTransition(
                  context: context,
                  state: state,
                  child: HomePage(),
                ),
          ),
          GoRoute(
            name: 'themes',
            path: 'themes',
            pageBuilder:
                (context, state) => CustomTransitions.slideTransition(
                  context: context,
                  state: state,
                  child: const ThemePage(),
                ),
          ),
          GoRoute(
            name: 'language',
            path: 'language',
            pageBuilder:
                (context, state) => CustomTransitions.slideTransition(
                  context: context,
                  state: state,
                  child: const LanguagePage(),
                ),
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Route not found: ${state.uri}')),
        ),
  );
});

// Route names as constants for easy reference
class AppRoutes {
  static const String home = 'home';
  static const String search = 'search';
  static const String settings = 'settings';
  static const String themes = 'themes';
  static const String language = 'language';
  static const String login = 'login';
}
