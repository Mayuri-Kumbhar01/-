import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('🏆 Track your position in the rankings!',
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
