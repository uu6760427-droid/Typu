import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ConnectionCard extends StatelessWidget {
  final bool isConnected;
  final VoidCallback onTap;
  final AnimationController pulseController;

  const ConnectionCard({
    super.key,
    required this.isConnected,
    required this.onTap,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              AnimatedBuilder(
                animation: pulseController,
                builder: (context, child) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isConnected ? Colors.green : Colors.grey.shade300,
                      boxShadow: isConnected
                          ? [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3 * pulseController.value),
                                blurRadius: 20,
                                spreadRadius: 5,
                              )
                            ]
                          : null,
                    ),
                    child: Icon(
                      isConnected ? Icons.power_settings_new : Icons.power_off,
                      color: Colors.white,
                      size: 30,
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isConnected ? 'Подключено' : 'Отключено',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      isConnected ? 'Скорость: 12.4 Мбит/с' : 'Нажмите, чтобы подключиться',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Switch(
                value: isConnected,
                onChanged: (_) => onTap(),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1);
  }
}
