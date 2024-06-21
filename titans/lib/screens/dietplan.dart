import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:titans/colors.dart';

class DietPlan extends StatefulWidget {
  const DietPlan({super.key});

  @override
  _DietPlanPageState createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlan> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _studentData;

  @override
  void initState() {
    super.initState();
    _fetchStudentData();
  }

  Future<void> _fetchStudentData() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('students').doc('Akash').get();
      setState(() {
        _studentData = snapshot.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      print("Error fetching student data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Center(
          child: Text(
            "Diet Plan",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: _studentData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Glass effect container for today's date
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Today\'s Date: $formattedDate',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to your Titans Gym Diet Plan',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Meal cards
                        _buildMealCard(
                          Icons.free_breakfast,
                          Colors.orange,
                          'Breakfast',
                          _studentData!['breakfast'],
                          Colors.amber[100]!,
                        ),
                        const SizedBox(height: 20),
                        _buildMealCard(
                          Icons.lunch_dining,
                          Colors.green,
                          'Lunch',
                          _studentData!['lunch'],
                          Colors.green[100]!,
                        ),
                        const SizedBox(height: 20),
                        _buildMealCard(
                          Icons.dinner_dining,
                          Colors.red,
                          'Dinner',
                          _studentData!['dinner'],
                          Colors.red[100]!,
                        ),
                        const SizedBox(height: 20),
                        _buildMealCard(
                          FontAwesomeIcons.utensils,
                          Colors.blue,
                          'Snacks',
                          _studentData!['snacks'],
                          Colors.blue[100]!,
                        ),
                        const SizedBox(height: 20),
                        // Tips section
                        Text(
                          'Tips:',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '1. Drink plenty of water throughout the day.\n'
                          '2. Avoid processed and high-fat foods.\n'
                          '3. Include a variety of fruits and vegetables in your diet.\n'
                          '4. Stay active and exercise regularly.',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                            ),
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

  Widget _buildMealCard(
    IconData icon,
    Color iconColor,
    String title,
    String description,
    Color cardColor,
  ) {
    return Card(
      elevation: 4,
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title:',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
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
}
