import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../widgets/connection_card.dart';
import '../widgets/server_list_tile.dart';
import '../models/server_model.dart';
import '../utils/animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _isConnected = false;
  late AnimationController _pulseController;
  final List<ServerModel> _servers = [
    ServerModel(name: '🇺🇸 USA - Premium', ping: 32, isSelected: true),
    ServerModel(name: '🇩🇪 Germany - Fast', ping: 45, isSelected: false),
    ServerModel(name: '🇯🇵 Japan - Low Latency', ping: 89, isSelected: false),
    ServerModel(name: '🇸🇬 Singapore - Optimized', ping: 67, isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('VPN Combine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Кнопка подключения с анимацией
            ConnectionCard(
              isConnected: _isConnected,
              onTap: () {
                setState(() {
                  _isConnected = !_isConnected;
                });
              },
              pulseController: _pulseController,
            ),
            const SizedBox(height: 20),
            // Список серверов с анимацией появления
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _servers.length,
                itemBuilder: (context, index) {
                  return ServerListTile(
                    server: _servers[index],
                    onTap: () {
                      setState(() {
                        for (var s in _servers) s.isSelected = false;
                        _servers[index].isSelected = true;
                      });
                    },
                  ).animate().fadeIn(duration: 300.ms, delay: (100 * index).ms).slideY(begin: 0.2, end: 0);
                },
              ),
            ),
            // Кнопка обновления подписки
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Подписка обновлена: сегодня 12:34',
                    style: theme.textTheme.bodySmall,
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Обновление подписок...')),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Обновить'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
