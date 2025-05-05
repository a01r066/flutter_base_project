import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyNavigationDrawer extends ConsumerWidget {
  final VoidCallback onSettingsTap;
  final VoidCallback onThemeTap;
  final VoidCallback onLoginTap;

  const MyNavigationDrawer({
    super.key,
    required this.onSettingsTap,
    required this.onThemeTap,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          _buildDrawerHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Themes'),
                  onTap: () {
                    Navigator.pop(context);
                    onThemeTap();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    onSettingsTap();
                  },
                ),

                const Divider(),

                // Help and About
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Feedback'),
                  onTap: () {
                    Navigator.pop(context);
                    _showHelpDialog(context);
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),

          // Version info at bottom
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: const Text('Navigation App'),
      accountEmail: Text('Location not available'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.directions,
          color: Theme.of(context).primaryColor,
          size: 36.0,
        ),
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Help & Feedback'),
            content: const Text(
              'Need assistance with the navigation app?\n\n'
              'Email us at: support@navigationapp.com\n\n'
              'Or call: (123) 456-7890',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  // In a real app, implement email sending or feedback form
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Feedback option coming soon'),
                    ),
                  );
                },
                child: const Text('Send Feedback'),
              ),
            ],
          ),
    );
  }
}
