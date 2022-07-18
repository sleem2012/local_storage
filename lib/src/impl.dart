import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  T? get<T>(String key);

  bool has(String key);

  void clear(String key);

  void put(String key, dynamic value);

  SharedPreferences get sharedPreferences;
}

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences _sharedPreferences;

  LocalStorageImpl(this._sharedPreferences);

  @override
  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  bool has(String key) {
    return (_sharedPreferences.containsKey(key) && _sharedPreferences.get(key) != null);
  }

  @override
  void clear(String key) {
    _sharedPreferences.remove(key);
  }

  @override
  T? get<T>(String key) {
    if (has(key)) {
      return jsonDecode(_sharedPreferences.getString(key)!);
    } else {
      return null;
    }
  }

  @override
  void put(String key, dynamic value) {
    _sharedPreferences.setString(key, jsonEncode(value));
  }
}
