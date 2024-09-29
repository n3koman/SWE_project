import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://swe-project-liard.vercel.app"; // Change to your backend's actual URL

  // Method to register a new user
  Future<http.Response> registerUser(String name, String email, String password, String role) async {
    final url = Uri.parse("$baseUrl/register");  // Endpoint for user registration
    
    // Payload data to send to the backend
    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': password,
      'role': role
    };

    try {
      // Make POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body), // Convert the map to JSON string
      );

      if (response.statusCode == 201) {
        // Registration success
        return response;
      } else {
        // Handle errors, you can throw or return an error response
        throw Exception("Failed to register user. Error: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  // Method to login a user
  Future<http.Response> loginUser(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");  // Endpoint for login
    
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return response; // Successful login
      } else {
        throw Exception("Login failed. Error: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  // Method to fetch user data (e.g., profile)
  Future<http.Response> getUserData(String userId) async {
    final url = Uri.parse("$baseUrl/user/$userId");  // Endpoint to fetch user data

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response; // Successfully fetched user data
      } else {
        throw Exception("Failed to fetch user data. Error: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
}
