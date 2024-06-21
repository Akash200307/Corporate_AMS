import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  static String routeName = '/terms';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Color theme from ProfileScreen
    Color primaryColor = Colors.deepPurple;
    Color darkTextColor = Colors.black87; // Darker text color

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Welcome to Kendice Attendance Management App. By using this app, you agree to comply with and be bound by the following terms and conditions of use. If you disagree with any part of these terms and conditions, please do not use our app.',
              style: TextStyle(
                fontSize: 16,
                color: darkTextColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            buildTermSection(
              title: '1. Account Registration and Usage',
              content:
                  'Users are required to register and provide accurate information. Unauthorized use or sharing of accounts is prohibited and may result in termination of access.',
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildTermSection(
              title: '2. Data Privacy and Security',
              content:
                  'We are committed to protecting your privacy. All attendance data collected is used solely for managing attendance and will not be shared with third parties without your explicit consent.',
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildTermSection(
              title: '3. Accuracy of Information',
              content:
                  'Users are responsible for ensuring the accuracy of their attendance records. Any discrepancies should be reported immediately.',
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildTermSection(
              title: '4. Limitation of Liability',
              content:
                  'We are not liable for any damages or losses resulting from the use or inability to use our app.',
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildTermSection(
              title: '5. Changes to Terms',
              content:
                  'We reserve the right to modify these terms at any time. Changes will be effective immediately upon posting.',
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              'By continuing to use Kendice Attendance Management App, you agree to abide by these terms and conditions.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget buildTermSection({
    required String title,
    required String content,
    required Color primaryColor,
    required Color darkTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: darkTextColor,
          ),
        ),
      ],
    );
  }
}
