import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:titans/colors.dart';
import 'package:titans/screens/dietplan.dart';
import 'package:titans/screens/homepage.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.transparent,
        color: primary,
        animationCurve: Curves.easeInOutCubicEmphasized,
        animationDuration: const Duration(milliseconds: 800),
        items: const [
          Icon(
            FluentIcons.food_16_regular,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            CupertinoIcons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            CupertinoIcons.archivebox,
            color: Colors.white,
            size: 30,
          )
        ],
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic);
          });
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {});
        },
        children: const [
          DietPlan(),
          Homepage(),
        ],
      ),
    );
  }
}
