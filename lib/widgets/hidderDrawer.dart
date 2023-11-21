import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:nextmusic/Views/screens/Home_Screen.dart';
import 'package:nextmusic/Views/screens/UpdatesScreen.dart';
import 'package:nextmusic/Views/screens/aboutScreen.dart';
import 'package:nextmusic/utils/contants.dart';

class HiddenDrawWithAppRoute extends StatefulWidget {
  const HiddenDrawWithAppRoute({Key? key}) : super(key: key);

  @override
  State<HiddenDrawWithAppRoute> createState() => _HiddenDrawWithAppRouteState();
}

class _HiddenDrawWithAppRouteState extends State<HiddenDrawWithAppRoute> {
  List<ScreenHiddenDrawer> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Music Finder',
          baseStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        HomeScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'New Updates',
          baseStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        UpdateScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'About Us',
          baseStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        AboutScreen(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      elevationAppBar: 0,
      backgroundColorAppBar: backgroundclr,
      screens: _pages,
      backgroundColorMenu: backgroundclr.withOpacity(0.85),
      initPositionSelected: 0,
    );
  }
}
