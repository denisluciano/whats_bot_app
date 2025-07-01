class User {
  final String userId;
  final String userName;

  User({required this.userId, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(userId: json['userId'], userName: json['userName']);
  }
}
