import 'package:flutter/material.dart';

void main() {
  runApp(fourthscreen());
}

class fourthscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileSelectionScreen(),
    );
  }
}

class ProfileSelectionScreen extends StatefulWidget {
  @override
  _ProfileSelectionScreenState createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  String? selectedProfile; // To track selected profile option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Please select your profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            _buildProfileOption(
              profileType: "Shipper",
              description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing",
              icon: Icons.home,
            ),
            SizedBox(height: 20),
            _buildProfileOption(
              profileType: "Transporter",
              description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing",
              icon: Icons.local_shipping,
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                onPressed: () {
                  if (selectedProfile != null) {
                    print("Selected Profile: $selectedProfile");
                    // Proceed with selected profile logic
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a profile')),
                    );
                  }
                },
                child: Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual profile option
  Widget _buildProfileOption(
      {required String profileType,
        required String description,
        required IconData icon}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProfile = profileType;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedProfile == profileType
                ? Colors.blue.shade900
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: profileType,
              groupValue: selectedProfile,
              onChanged: (String? value) {
                setState(() {
                  selectedProfile = value;
                });
              },
              activeColor: Colors.blue.shade900,
            ),
            SizedBox(width: 10),
            Icon(icon, color: Colors.blue.shade900, size: 40),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileType,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}