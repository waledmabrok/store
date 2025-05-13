import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _loginViewedKey = 'login';

  // حفظ أن المستخدم شاهد الـ Onboarding
  static Future<void> setLoginViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginViewedKey, true);
  }

  // استرجاع هل المستخدم شاهد الـ Onboarding أم لا
  static Future<bool> hasSeenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginViewedKey) ?? false;
  }
}
