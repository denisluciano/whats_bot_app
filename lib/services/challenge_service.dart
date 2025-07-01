import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/challenge.dart';

class ChallengeService {
  static const String _baseUrl =
      'http://10.0.2.2:3000'; // Android emulador → localhost
  static const String _token = 'meu_token_simples'; // seu token do .env

  static Future<List<Challenge>> fetchChallenges() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/desafios'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Challenge.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar desafios');
    }
  }
}
