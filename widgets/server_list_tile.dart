import 'package:flutter/material.dart';
import '../models/server_model.dart';

class ServerListTile extends StatelessWidget {
  final ServerModel server;
  final VoidCallback onTap;

  const ServerListTile({super.key, required this.server, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: server.isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
          child: Text(
            server.ping.toString(),
            style: TextStyle(
              color: server.isSelected ? Colors.white : Colors.black87,
              fontSize: 12,
            ),
          ),
        ),
        title: Text(server.name),
        subtitle: Text('Пинг: ${server.ping} мс'),
        trailing: server.isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
