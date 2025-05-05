import 'package:bus_app/core/config/router_config.dart';
import 'package:bus_app/core/constants/app_constants.dart';
import 'package:bus_app/core/services/local/local_storage_service.dart';
import 'package:bus_app/generated/l10n.dart';
import 'package:bus_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStorageService = ref.watch(localStorageServiceProvider);
    final sharedPrefs = ref.watch(sharedPreferencesProvider);

    // Has settings changed
    final hasChanges = useState(false);

    final flavor = ref.watch(flavorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          TextButton(
            onPressed:
                hasChanges.value
                    ? () => context.pop(true)
                    : () => context.pop(),
            child: const Text('Done'),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Appearance/Theme Section
          ListTile(
            title: const Text('Appearance'),
            subtitle: const Text('Customize app theme and appearance'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.color_lens),
              label: const Text('Customize Theme'),
              onPressed: () {
                context.pushNamed('themes');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),

          const Divider(height: 32),

          // Language Section
          ListTile(
            title: Text(S.of(context).language),
            subtitle: Text(S.of(context).languageDescription),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.language),
              label: Text(S.of(context).language),
              onPressed: () {
                context.pushNamed(AppRoutes.language);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),

          const Divider(height: 32),

          // Cache Section
          ListTile(
            title: const Text('Cache Settings'),
            subtitle: Text(
              'Weather data is cached for ${AppConstants.cacheDurationInMinutes} minutes',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Clear Cache'),
              onPressed: () async {
                // Show confirmation dialog
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Clear Cache'),
                        content: const Text(
                          'This will clear all cached weather data. You will need to fetch new data.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                );
              },
            ),
          ),

          const SizedBox(height: 32),

          // App Info
          ListTile(
            title: Text(S.of(context).about),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, child) {
                    return Text(
                      S.of(context).appVersion(flavor.versionWithBuild),
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Consumer(
                  builder: (context, ref, child) {
                    return Text(
                      'Environment: ${flavor.env.name.toUpperCase()}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            flavor.isDev
                                ? Colors.orange
                                : Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).apiInfo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).dataSource,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
