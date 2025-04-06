import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyAbbPjKMiUhWBYJ5tpcL4KlB-YHu1Ie-q0'; 
  static const String _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey';

  static Future<String> getResponse(String userMessage) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": userMessage}
          ]
        }
      ]
    });

    final response = await http.post(
      Uri.parse(_url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
      return 'Sorry, I couldn’t reach Gemini. Try again later.';
    }
  }
}
