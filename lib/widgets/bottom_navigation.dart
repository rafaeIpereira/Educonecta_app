import 'package:educonecta/pages/home_page.dart';
import 'package:educonecta/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _navigate(BuildContext context, int index) {
    switch (_selectedIndex) {
      case 3:
        Get.to(() => ProfilePage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _navigate(context, index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(_selectedIndex == 0
                ? 'assets/icons/menu_dark.svg'
                : 'assets/icons/menu_light.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 1
                  ? 'assets/icons/discover_dark.svg'
                  : 'assets/icons/discover_light.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 2
                  ? 'assets/icons/message_dark.svg'
                  : 'assets/icons/message_light.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 3
                  ? 'assets/icons/profile_dark.svg'
                  : 'assets/icons/profile_light.svg'),
              label: ''),
        ]);
  }
}
