import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class LearnTab extends StatefulWidget {
  const LearnTab({super.key});

  @override
  State<LearnTab> createState() => _LearnTabState();
}

class _LearnTabState extends State<LearnTab> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chat = [];
  final List<String> _lessons = List.generate(10, (index) => 'Lesson ${index + 1}');
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final userMessage = _messageController.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        _chat.add({'sender': 'You', 'message': userMessage});
        _messageController.clear();
      });
      _scrollToBottom();
      _getFinnyResponse(userMessage);
    }
  }

  void _getFinnyResponse(String message) async {
    final reply = await GeminiService.getResponse(message);
    setState(() {
      _chat.add({'sender': 'Finny 🤖', 'message': reply});
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildLessonCard(String lessonTitle) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        title: Text(lessonTitle),
        onTap: () {
          _sendMessageFromLesson(lessonTitle);
        },
      ),
    );
  }

  void _sendMessageFromLesson(String lessonTitle) {
    final message = 'Tell me about $lessonTitle';
    setState(() {
      _chat.add({'sender': 'You', 'message': message});
    });
    _getFinnyResponse(message);
  }

  Widget _buildChatMessage(Map<String, String> message) {
    final isUser = message['sender'] == 'You';
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.orange[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text('${message['sender']}: ${message['message']}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              '📚 Tap a lesson to start learning!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                // Lesson list
                ..._lessons.map(_buildLessonCard).toList(),

                const Divider(),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    '💬 Chat with Finny:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),

                // Chat messages
                ..._chat.map(_buildChatMessage).toList(),

                const SizedBox(height: 80), // space for input box
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ask Finny...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepOrange),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
