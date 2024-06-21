import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:titans_admin/colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedStudent;
  final TextEditingController _breakfastController = TextEditingController();
  final TextEditingController _lunchController = TextEditingController();
  final TextEditingController _dinnerController = TextEditingController();
  final TextEditingController _snacksController = TextEditingController();

  void _updateDietPlan() async {
    if (_selectedStudent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a student')),
      );
      return;
    }
    try {
      await _firestore.collection('students').doc(_selectedStudent).update({
        'breakfast': _breakfastController.text,
        'lunch': _lunchController.text,
        'dinner': _dinnerController.text,
        'snacks': _snacksController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Diet plan updated successfully')),
      );
    } catch (e) {
      print("Error updating diet plan: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update diet plan')),
      );
    }
  }

  Future<List<String>> _fetchStudents() async {
    QuerySnapshot snapshot = await _firestore.collection('students').get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  void _fetchDietPlan(String student) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('students').doc(student).get();
    setState(() {
      _breakfastController.text = snapshot['breakfast'] ?? '';
      _lunchController.text = snapshot['lunch'] ?? '';
      _dinnerController.text = snapshot['dinner'] ?? '';
      _snacksController.text = snapshot['snacks'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Center(
          child: Text(
            "Admin Panel",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<String>>(
              future: _fetchStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Error fetching students');
                }
                List<String>? students = snapshot.data;
                return DropdownButton<String>(
                  value: _selectedStudent,
                  hint: const Text('Select Member'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStudent = newValue;
                      if (_selectedStudent != null) {
                        _fetchDietPlan(_selectedStudent!);
                      }
                    });
                  },
                  items:
                      students?.map<DropdownMenuItem<String>>((String student) {
                    return DropdownMenuItem<String>(
                      value: student,
                      child: Text(student),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(_breakfastController, 'Breakfast'),
            const SizedBox(height: 20),
            _buildTextField(_lunchController, 'Lunch'),
            const SizedBox(height: 20),
            _buildTextField(_dinnerController, 'Dinner'),
            const SizedBox(height: 20),
            _buildTextField(_snacksController, 'Snacks'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _updateDietPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child: Text(
                'Update Diet Plan',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
