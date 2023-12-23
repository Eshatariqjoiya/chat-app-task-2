// Add necessary dependencies in your pubspec.yaml file:
// dependencies:
//   web_socket_channel: ^2.0.0
//   image_picker: ^0.8.4
//   firebase_messaging: ^10.0.5

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real-time Chat',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool isPinned = false;
  bool isNightMode = false;

  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    // Initialize WebSocket connection
    channel = WebSocketChannel.connect(
      Uri.parse('wss://your-websocket-server-url'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat App'),
        actions: [
          // Pin button
          IconButton(
            icon: Icon(isPinned ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                isPinned = !isPinned;
              });
            },
          ),
          // Night mode button
          IconButton(
            icon: Icon(isNightMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isNightMode = !isNightMode;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // List of chat rooms
          Expanded(
            child: Container(
              // Add your chat room list here
              child: ListView.builder(
                itemCount: 5, // Replace with the actual number of chat rooms
                itemBuilder: (context, index) {
                  // Build chat room list item
                  return ListTile(
                    title: Text('Chat Room $index'),
                    onTap: () {
                      // Navigate to the selected chat room
                      // Add navigation logic here
                    },
                  );
                },
              ),
            ),
          ),
          // Message input
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                // Send message button
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send message logic
                    // Implement sending logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Close WebSocket connection when the widget is disposed
    channel.sink.close();
    super.dispose();
  }
}
