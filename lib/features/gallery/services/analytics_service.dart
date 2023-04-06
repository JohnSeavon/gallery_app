import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:gallery_app/features/gallery/analytics/analytics_events.dart';

class AnalyticsService {
  static void log(AbstractAnalyticsEvent event) {
    Amplify.Analytics.recordEvent(event: event.value);
  }
}
