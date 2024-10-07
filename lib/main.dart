import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseflutter/pages/no.page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyBMnzm507ToSWDd454AHT10gv0MAmnlKi8",
        authDomain: "fir-flutter-9699e.firebaseapp.com",
        projectId: "fir-flutter-9699e",
        storageBucket: "fir-flutter-9699e.appspot.com",
        messagingSenderId: "987963595972",
        appId: "1:987963595972:web:97c6e1e3357a9ae3c23d91",
        measurementId: "G-TY0NMGGH4X"));
  }else{
    await Firebase.initializeApp();
  }
  runApp(LanguageSelectionApp());

}

class LanguageSelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Icon(
                Icons.image,
                size: 80,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Please select your Language',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'You can change the language at any time.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButtonFormField<String>(
                value: _selectedLanguage,
                icon: Icon(Icons.arrow_downward),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: <String>['English', 'Spanish', 'French', 'German', 'Chinese']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Secondscreen()),
                  );
                },
                child: Text('NEXT'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // full width button
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}