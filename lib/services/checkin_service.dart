import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckinService {
  static const String _baseUrl = 'http://10.0.2.2:3000';
  static const String _token = 'meu_token_simples';

  static Future<List<DateTime>> fetchCheckins(
    String userId,
    int challengeId,
  ) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/checkins/$userId/$challengeId'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['checkins'];
      return data.map<DateTime>((d) => DateTime.parse(d)).toList();
    } else {
      throw Exception('Erro ao buscar check-ins');
    }
  }
}
