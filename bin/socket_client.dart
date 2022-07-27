import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:socket_io_client/socket_io_client.dart';

void main(List<String> args) {
  final client = io(
    'http://localhost:3000/chat',
    <String, dynamic> {'transports': ['websocket']}
  );

  client.onConnect((data) {
    print("Conectado");
    client.emit("name", args[0]);
    readLine().listen((String event) {
      client.emit('msg' ,event);
    });
  });

  client.on("msg", (data) => print(data));

  client.onDisconnect((data) => print('Desconectado'));
}

Stream<String> readLine() => stdin.transform(utf8.decoder).transform(const LineSplitter());