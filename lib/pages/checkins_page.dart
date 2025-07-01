import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/checkin_service.dart';

class CheckinsPage extends StatefulWidget {
  final String userId;
  final String userName;
  final int challengeId;
  final String challengeName;

  const CheckinsPage({
    super.key,
    required this.userId,
    required this.userName,
    required this.challengeId,
    required this.challengeName,
  });

  @override
  State<CheckinsPage> createState() => _CheckinsPageState();
}

class _CheckinsPageState extends State<CheckinsPage> {
  List<DateTime> checkinDates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCheckins();
  }

  void loadCheckins() async {
    try {
      final dates = await CheckinService.fetchCheckins(
        widget.userId,
        widget.challengeId,
      );
      setState(() {
        checkinDates = dates;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Erro: $e');
    }
  }

  bool isCheckin(DateTime day) {
    return checkinDates.any(
      (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Check-ins de ${widget.userName}')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                markerDecoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  shape: BoxShape.circle,
                ),
              ),
              selectedDayPredicate: isCheckin,
              availableGestures: AvailableGestures.all,
            ),
    );
  }
}
