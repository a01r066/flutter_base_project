import 'package:bus_app/core/config/router_config.dart';
import 'package:bus_app/presentation/providers/providers.dart';
import 'package:bus_app/presentation/widgets/my_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = ref.watch(flavorProvider);

    return Scaffold(
      appBar: AppBar(title: Text(flavor.title)),
      body: Center(child: Text('Hello ${flavor.title}')),
      drawer: MyNavigationDrawer(
        onThemeTap: () => context.pushNamed(AppRoutes.themes),
        onSettingsTap: () => context.pushNamed(AppRoutes.settings),
        onLoginTap: () => context.pushNamed(AppRoutes.login),
      ),
    );
  }
}
