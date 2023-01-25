import 'package:anitocorn_work_shop_json_feed/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String isLoginSuccess = "isLogin";
  static const String username = "username";

  Future login({User? user}) async {
    if (user!.username == "admin@gmail.com" && user.password == "password") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(username, user.username!);
      sharedPreferences.setBool(isLoginSuccess, true);

      return true;
    }
    return false;
  }

  Future<bool> isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLoginSuccess) ?? false;
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(isLoginSuccess);

    return await Future<void>.delayed(const Duration(seconds: 2));
  }
}
