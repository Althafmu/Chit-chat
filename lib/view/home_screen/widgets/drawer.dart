import 'package:chit_chat/controller/login_screen_controller.dart';
import 'package:chit_chat/utils/constants/colorconstants.dart';
import 'package:chit_chat/utils/constants/image_constants.dart';
import 'package:chit_chat/view/settingspage/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colorconstants.whitecolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                      child: Image.asset(
                ImageConstants.chitchatlogopng,
                fit: BoxFit.contain,
                height: 150,
              ))),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                final loginProvider =
                    Provider.of<LoginScreenController>(context, listen: false);
                loginProvider.signOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
