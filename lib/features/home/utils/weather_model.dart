class Weather {
  final double temperature;
  final int weatherCode;
  final double windSpeed;
  final double humidity;
  final DateTime fetchedAt;

  Weather({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.humidity,
    required this.fetchedAt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['temperature'] as num).toDouble(),
      weatherCode: json['weatherCode'],
      windSpeed: (json['windSpeed'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      fetchedAt: DateTime.parse(json['fetchedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'weatherCode': weatherCode,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'fetchedAt': fetchedAt.toIso8601String(),
    };
  }
}
