import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _role = 'buyer'; // Default role is 'buyer'
  String? _farmName;
  String? _farmLocation;
  String? _farmSize;
  String? _cropTypes;

  Future<void> _registerUser() async {
    var url = Uri.parse('https://swe-project-liard.vercel.app/register'); // Change to your backend URL
    Map<String, dynamic> requestBody = {
      'name': _name,
      'email': _email,
      'password': _password,
      'role': _role,
    };

    // If the user selects 'farmer', add farm details to the request
    if (_role == 'farmer') {
      requestBody['farm_name'] = _farmName;
      requestBody['farm_location'] = _farmLocation;
      requestBody['farm_size'] = _farmSize;
      requestBody['crop_types'] = _cropTypes;
    }

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 201) {
      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful')));
    } else {
      // Registration failed
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.body}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _role,
                items: [
                  DropdownMenuItem(value: 'farmer', child: Text('Farmer')),
                  DropdownMenuItem(value: 'buyer', child: Text('Buyer')),
                ],
                onChanged: (value) {
                  setState(() {
                    _role = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Role'),
              ),
              if (_role == 'farmer') ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Farm Name'),
                  onSaved: (value) => _farmName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Farm Location'),
                  onSaved: (value) => _farmLocation = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Farm Size (in hectares)'),
                  onSaved: (value) => _farmSize = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Crop Types (comma-separated)'),
                  onSaved: (value) => _cropTypes = value!,
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerUser();
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
