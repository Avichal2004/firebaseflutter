import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseflutter/pages/selectprofilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
 // Make sure you have this screen created

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(Secondscreen());
}

class Secondscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobileNumberScreen(),
    );
  }
}

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  String _countryCode = '+91';
  TextEditingController _mobileNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _verifyPhoneNumber() async {
    String phoneNumber = '$_countryCode${_mobileNumberController.text}';

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => fourthscreen()),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Show a dialog to enter the SMS code
        String smsCode = '';
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter SMS Code'),
              content: TextField(
                onChanged: (value) {
                  smsCode = value;
                },
                decoration: InputDecoration(hintText: 'SMS Code'),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: smsCode,
                    );
                    // Sign in the user
                    await _auth.signInWithCredential(credential);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => fourthscreen()),
                    );
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Handle close button press
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
              'Please enter your mobile number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You’ll receive a 6 digit code to verify next.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _countryCode,
                    items: [
                      DropdownMenuItem(
                        child: Text('+91'),
                        value: '+91',
                      ),
                      DropdownMenuItem(
                        child: Text('+1'),
                        value: '+1',
                      ),
                      DropdownMenuItem(
                        child: Text('+44'),
                        value: '+44',
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _countryCode = value!;
                      });
                    },
                    underline: SizedBox(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Mobile Number',
                    ),
                  ),
                ),
              ],
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
                onPressed: () async {
                  await _verifyPhoneNumber();
                },
                child: Text(
                  'CONTINUE',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
