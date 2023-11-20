import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FlutterWebSocket extends StatefulWidget {
  const FlutterWebSocket({Key? key}) : super(key: key);

  @override
  State<FlutterWebSocket> createState() => _FlutterWebSocketState();
}

class _FlutterWebSocketState extends State<FlutterWebSocket> {
  var channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'));

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Web Socket"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 40),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                }
                if (snapshot.hasData) {
                  return Text("Received : ${snapshot.data}");
                }
                return const CircularProgressIndicator();
              },
              stream: channel.stream,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          channel.sink.add(_messageController.text.trim());
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
