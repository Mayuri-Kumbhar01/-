import 'package:flutter/material.dart';
import 'tabs/home_tab.dart';
import 'tabs/learn_tab.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/community_tab.dart';
import 'tabs/profile_tab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;

  final tabs = [
    HomeTab(),
    LearnTab(),
    LeaderboardTab(),
    CommunityTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Ranks'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
