class Challenge {
  final int id;
  final String groupId;
  final String name;

  Challenge({required this.id, required this.groupId, required this.name});

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      groupId: json['groupId'],
      name: json['name'],
    );
  }
}
