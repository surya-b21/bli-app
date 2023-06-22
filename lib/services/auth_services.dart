import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class UserServices {
  final _storage = const FlutterSecureStorage();
  final _http = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      contentType: "application/json",
    ),
  )..interceptors.add(PrettyDioLogger());

  Future<String> login(String email, String password) async {
    final response = await _http.post('/login',
        data: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
        options: Options(
          validateStatus: (status) => status! < 500,
        ));

    await _storage.write(key: 'token', value: response.data['access_token']);

    return response.data['message'];
  }

  Future<void> logout(String token) async {
    await _storage.delete(key: 'token');

    await _http.post(
      '/logout',
      options: Options(
        headers: {
          "Authorization": "Beare $token",
        },
      ),
    );
  }
}
