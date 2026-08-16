import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoUpdate = true;
  bool _notifications = true;
  double _pingThreshold = 100;
  int _updateInterval = 6;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Тема
          SwitchListTile(
            title: const Text('Тёмная тема'),
            subtitle: const Text('Изменить оформление приложения'),
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),

          // Автообновление
          SwitchListTile(
            title: const Text('Автообновление подписок'),
            subtitle: const Text('Обновлять каждый час'),
            value: _autoUpdate,
            onChanged: (v) => setState(() => _autoUpdate = v),
            secondary: const Icon(Icons.update),
          ),
          const Divider(),

          // Уведомления
          SwitchListTile(
            title: const Text('Уведомления'),
            subtitle: const Text('Показывать уведомления о статусе'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
            secondary: const Icon(Icons.notifications_active),
          ),
          const Divider(),

          // Ползунок порога пинга
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Максимальный пинг (мс)'),
            subtitle: Text('${_pingThreshold.toInt()} мс'),
            trailing: SizedBox(
              width: 150,
              child: Slider(
                value: _pingThreshold,
                min: 20,
                max: 300,
                divisions: 28,
                label: '${_pingThreshold.toInt()} мс',
                onChanged: (v) => setState(() => _pingThreshold = v),
              ),
            ),
          ),
          const Divider(),

          // Интервал обновления
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Интервал обновления (ч)'),
            subtitle: Text('$_updateInterval ч'),
            trailing: SizedBox(
              width: 150,
              child: Slider(
                value: _updateInterval.toDouble(),
                min: 1,
                max: 24,
                divisions: 23,
                label: '$_updateInterval ч',
                onChanged: (v) => setState(() => _updateInterval = v.toInt()),
              ),
            ),
          ),
          const Divider(),

          // Кнопка сброса
          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _autoUpdate = true;
                  _notifications = true;
                  _pingThreshold = 100;
                  _updateInterval = 6;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Настройки сброшены')),
                );
              },
              icon: const Icon(Icons.restore),
              label: const Text('Сбросить настройки'),
            ),
          ),
        ],
      ),
    );
  }
}
