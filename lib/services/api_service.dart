// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = 'http://172.20.10.3:8000';

//   /// Sends passenger records to the server
//   static Future<http.Response> sendRecords(List<Map<String, dynamic>> records) {
//     final uri = Uri.parse('$baseUrl/print');
//     return http.post(
//       uri,
//       headers: {'Content-Type': 'application/json; charset=UTF-8'},
//       body: jsonEncode({'records': records}),
//     );
//   }
// }
