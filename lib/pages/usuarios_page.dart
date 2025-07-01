import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'checkins_page.dart';

class UsuariosPage extends StatelessWidget {
  final int challengeId;
  final String challengeName;

  const UsuariosPage({
    super.key,
    required this.challengeId,
    required this.challengeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuários - $challengeName')),
      body: FutureBuilder<List<User>>(
        future: UserService.fetchUsersByChallenge(challengeId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final u = users[index];
                return ListTile(
                  title: Text(u.userName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckinsPage(
                          userId: u.userId,
                          userName: u.userName,
                          challengeId: challengeId,
                          challengeName: challengeName,
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
