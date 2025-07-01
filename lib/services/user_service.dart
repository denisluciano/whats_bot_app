import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String _baseUrl = 'http://10.0.2.2:3000';
  static const String _token = 'meu_token_simples';

  static Future<List<User>> fetchUsersByChallenge(int challengeId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/desafios/$challengeId/usuarios'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar usuários');
    }
  }
}
