import 'package:intl/intl.dart';
import 'package:weather_application/utils/image_strings.dart';

String getWeatherDescription(int code) {
  if ([0].contains(code)) return 'Clear Sky';
  if ([1, 2, 3].contains(code)) return 'Cloudy';
  if ([45, 48].contains(code)) return 'Fog';
  if ([51, 53, 55, 56, 57, 80].contains(code)) return 'Drizzle';
  if ([61, 63, 65, 66, 67, 81, 82].contains(code)) return 'Rain';
  if ([71, 73, 75, 77, 85, 86].contains(code)) return 'Snow';
  if ([95, 96, 99].contains(code)) return 'Thunderstorm';
  return 'Unknown';
}

String getLottieFile(int code) {
  final hour = DateTime.now().hour;
  final isDayTime = hour >= 6 && hour < 18;

  if ([0].contains(code)) {
    return isDayTime ? ImageStrings.dayClear : ImageStrings.nightClear;
  }
  if ([1, 2, 3].contains(code)) {
    return isDayTime ? ImageStrings.dayCloudy : ImageStrings.nightCloudy;
  }
  if ([45, 48].contains(code)) return ImageStrings.fog;
  if ([51, 53, 55, 56, 57, 80].contains(code)) {
    return isDayTime ? ImageStrings.dayShower : ImageStrings.nightShower;
  }
  if ([61, 63, 65, 66, 67, 81, 82].contains(code)) {
    return ImageStrings.heavyRain;
  }
  if ([71, 73, 75, 77, 85, 86].contains(code)) return ImageStrings.snow;
  if ([95, 96, 99].contains(code)) return ImageStrings.thunderStorm;
  return ImageStrings.nightClear;
}

String formatDateTime(DateTime? dt) {
  if (dt == null) return '--';
  return DateFormat('MMM d, hh:mm a').format(dt);
}
