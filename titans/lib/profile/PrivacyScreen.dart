import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  static String routeName = '/privacy';

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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Your privacy is important to us. This Privacy Policy outlines the types of personal information we collect, how we use it, and the steps we take to protect your information.',
              style: TextStyle(
                fontSize: 16,
                color: darkTextColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            buildPrivacySection(
              title: '1. Information We Collect',
              content: [
                '- Name',
                '- Email address',
                '- Profile picture',
              ],
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildPrivacySection(
              title: '2. How We Use Your Information',
              content: [
                '- To personalize your experience',
                '- To improve our app and services',
                '- To send periodic emails and updates',
              ],
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildPrivacySection(
              title: '3. Security Measures',
              content: [
                'We implement security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction.',
              ],
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildPrivacySection(
              title: '4. Sharing of Your Information',
              content: [
                'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this Privacy Policy.',
              ],
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            buildPrivacySection(
              title: '5. Changes to This Privacy Policy',
              content: [
                'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "last updated" date below.',
              ],
              primaryColor: primaryColor,
              darkTextColor: darkTextColor,
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'By using our app, you consent to our Privacy Policy and agree to its terms.',
              style: TextStyle(fontSize: 16, color: darkTextColor),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Last Updated: April 19, 2024', // Update the date accordingly
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget buildPrivacySection({
    required String title,
    required List<String> content,
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
        SizedBox(height: 12),
        ...content.map((item) => Text(
              item,
              style: TextStyle(
                fontSize: 16,
                color: darkTextColor,
              ),
            )),
      ],
    );
  }
}
