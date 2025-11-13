import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/theme_provider.dart';
import 'weather_helpers.dart';
import 'weather_model.dart';

Widget buildWeatherCard(BuildContext context, Weather weather) {
  final desc = getWeatherDescription(weather.weatherCode);
  final lottieFile = getLottieFile(weather.weatherCode);

  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        SizedBox(
          height: 180,
          child: Lottie.asset(lottieFile, fit: BoxFit.contain),
        ),
        const SizedBox(height: 16),
        Text(desc, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          '${weather.temperature.toStringAsFixed(1)}°C',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.air, size: 24),
                const SizedBox(width: 8),
                Text(
                  '${weather.windSpeed.toStringAsFixed(1)} km/h',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(width: 32),
            Row(
              children: [
                const Icon(Icons.water_drop, size: 24),
                const SizedBox(width: 8),
                Text(
                  '${weather.humidity.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Last fetched: ${formatDateTime(weather.fetchedAt)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}

Widget buildInfoCard(BuildContext context, String title, String? value) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: themeProvider.isDarkMode ? Color(0xFF4F4F4F) : null,
      border: Border.all(color: Color(0xFF4F4F4F)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(value ?? '--', style: Theme.of(context).textTheme.bodyLarge),
      ],
    ),
  );
}
