import 'package:firebaseflutter/pages/selectprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Thirdscreen());
}

class Thirdscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneVerificationScreen(),
    );
  }
}

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final int otpLength = 6; // Define the OTP length

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Verify Phone',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Code is sent to 8094508485',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                otpLength,
                    (index) => _buildOtpBox(index),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle resend code logic here
                },
                child: Text(
                  "Didn’t receive the code? Request Again",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                onPressed: () {
                  String otp = _otpController.text;
                  print('Entered OTP: $otp');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => fourthscreen()),
                  );
                },
                child: Text(
                  'VERIFY AND CONTINUE',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual OTP boxes
  Widget _buildOtpBox(int index) {
    return Container(
      width: 45,
      height: 45,
      alignment: Alignment.center,
      child: TextField(
        controller: _otpController,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.lightBlue.shade100,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < otpLength - 1) {
            FocusScope.of(context).nextFocus(); // Move to next box
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus(); // Move to previous box
          }
        },
      ),
    );
  }
}