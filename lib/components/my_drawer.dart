import 'package:chat_app_flutter/services/auth/auth_service.dart';
import 'package:chat_app_flutter/pages/settings.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Logo in the Drawer Header
              const DrawerHeader(
                child: Center(
                  child: Image(
                    image: AssetImage('assets/chatLogo.webp'),
                    height: 150,
                  ),
                ),
              ),
              // Home ListTile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              // Settings ListTile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    // navigate settings page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                ),
              ),
            ],
          ),
          // Logout ListTile
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
              left: 25,
            ),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
