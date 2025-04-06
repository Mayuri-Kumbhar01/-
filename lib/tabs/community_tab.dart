import 'package:flutter/material.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('💬 Ask questions, discuss and learn with others!',
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
