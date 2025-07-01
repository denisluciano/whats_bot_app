// lib/pages/desafios_page.dart
import 'package:flutter/material.dart';
import '../services/challenge_service.dart';
import '../models/challenge.dart';
import 'usuarios_page.dart';

class DesafiosPage extends StatefulWidget {
  @override
  _DesafiosPageState createState() => _DesafiosPageState();
}

class _DesafiosPageState extends State<DesafiosPage> {
  late Future<List<Challenge>> desafios;

  @override
  void initState() {
    super.initState();
    desafios = ChallengeService.fetchChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Desafios')),
      body: FutureBuilder<List<Challenge>>(
        future: desafios,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lista = snapshot.data!;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final c = lista[index];
                return ListTile(
                  title: Text(c.name),
                  subtitle: Text('Grupo: ${c.groupId}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UsuariosPage(
                          challengeId: c.id,
                          challengeName: c.name,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
