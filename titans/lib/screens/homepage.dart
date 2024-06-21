// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titans/colors.dart';
import 'package:titans/profile/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin {
  String username = '';
  late double _width;
  late double _height;
  String pkgexpate = "--/--";
  String pkg_days_left = "--/--";
  String pkg_plan = "--/--"; // New field for package plan
  String pkg_start_date = "--/--"; // New field for package start date
  final dateFormatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _loadData();
    _fetchUserData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pkg_days_left = prefs.getString('PkgDaysLeft') ?? pkg_days_left;
      pkgexpate = prefs.getString('pkgExpDate') ?? pkgexpate;
      pkg_plan = prefs.getString('pkgPlan') ?? pkg_plan; // Load package plan
      pkg_start_date = prefs.getString('pkgStartDate') ??
          pkg_start_date; // Load package start date
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('PkgDaysLeft', pkg_days_left);
    prefs.setString('PkgExpDate', pkgexpate);
    prefs.setString('pkgPlan', pkg_plan); // Save package plan
    prefs.setString('pkgStartDate', pkg_start_date); // Save package start date
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection("students")
            .where("uid", isEqualTo: user.uid)
            .get();

        if (snapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = snapshot.docs.first;
          DateTime expiryDate =
              dateFormatter.parse(userDoc.get('package_expiry'));
          String daysLeft =
              expiryDate.difference(DateTime.now()).inDays.toString();
          setState(() {
            username = userDoc.get('name');
            pkgexpate = userDoc.get('package_expiry');
            pkg_days_left = daysLeft;
            pkg_plan = userDoc.get('package_plan'); // Fetch package plan
            pkg_start_date =
                userDoc.get('package_start'); // Fetch package start date
          });

          // Update the "pkg_days_left" field in Firestore
          userDoc.reference.update({"pkg_days_left": daysLeft});
          _saveData();
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    User? user = FirebaseAuth.instance.currentUser;
   

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height * 0.12,
        title: Padding(
          padding: EdgeInsets.only(top: _height * 0.02),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
                child: CircleAvatar(
                  minRadius: _width * 0.1,
                  backgroundImage: const AssetImage('lib/assests/avatar1.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("students")
                      .where("uid", isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error fetching user data');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      DocumentSnapshot userDoc = snapshot.data!.docs.first;
                      username = userDoc['name'];
                      pkgexpate = userDoc['package_expiry'];
                      pkg_plan = userDoc['package_plan']; // Get package plan
                      pkg_start_date =
                          userDoc['package_start']; // Get package start date
                      DateTime expiryDate = dateFormatter.parse(pkgexpate);
                      pkg_days_left = expiryDate
                          .difference(DateTime.now())
                          .inDays
                          .toString();
                    }

                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hey there!\n",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 43, 42, 42),
                              fontSize: _width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: username, // Displaying the username here
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color.fromARGB(255, 39, 37, 37),
                                fontSize: _width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(_width * 0.02),
              child: DatePicker(
                DateTime.now(),
                height: _height * 0.12,
                width: _width * 0.17,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: primary,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.03),
              padding: EdgeInsets.all(_width * 0.04),
              width: _width,
              height:
                  _height * 0.68, // Adjusted height to fit the new container
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(_width * 0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(_width * 0.02),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(height: _height * 0.010),
                  Padding(
                    padding: EdgeInsets.all(_width * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildDetailContainer(
                              icon: FontAwesomeIcons.arrowRightFromBracket,
                              title: "Pkg expiry",
                              value: pkgexpate,
                              valueFontSize: _width * 0.05,
                            ),
                            buildDetailContainer(
                              icon: FontAwesomeIcons.arrowRightFromBracket,
                              title: "Days Left",
                              value: pkg_days_left,
                              valueFontSize: _width * 0.06,
                            ),
                          ],
                        ),
                        SizedBox(height: _height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildDetailContainer(
                              icon: FontAwesomeIcons.boxOpen,
                              title: "Pkg Plan",
                              value: pkg_plan,
                              valueFontSize: _width * 0.05,
                            ),
                            buildDetailContainer(
                              icon: FontAwesomeIcons.calendarAlt,
                              title: "Pkg Start Date",
                              value: pkg_start_date,
                              valueFontSize: _width * 0.05,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailContainer({
    required IconData icon,
    required String title,
    required String value,
    required double valueFontSize,
  }) {
    return Container(
      height: _height * 0.15,
      width: _width * 0.42,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: _width * 0.004,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_width * 0.04),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(icon, color: primary),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: _width * 0.03,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            value,
                            style: GoogleFonts.lato(
                              fontSize: valueFontSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Date",
                            style: GoogleFonts.lato(
                              fontSize: _width * 0.03,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
