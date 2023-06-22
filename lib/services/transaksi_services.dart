import 'dart:convert';

import 'package:bli_app/model/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TransaksiServices {
  final _storage = const FlutterSecureStorage();
  final _http = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      contentType: "application/json",
    ),
  )..interceptors.add(PrettyDioLogger());

  Future<List<dynamic>> invoice() async {
    String? token = await _storage.read(key: 'token');
    final response = await _http.get(
      '/transaksi/invoice',
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );

    return response.data;
  }

  Future<List<ItemModel>> itemList(int sort) async {
    String? token = await _storage.read(key: 'token');
    final response = await _http.get(
      '/transaksi?sort=$sort',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        responseType: ResponseType.plain,
      ),
    );

    return itemModelFromJson(response.data);
  }

  Future<List<Item>> getItem(String search) async {
    String? token = await _storage.read(key: 'token');
    final response = await _http.get(
      '/item?search=$search',
      options: Options(
          headers: {"Authorization": "Bearer $token"},
          responseType: ResponseType.plain),
    );

    List<Item> data =
        List<Item>.from(jsonDecode(response.data).map((x) => Item.fromJson(x)));

    return data;
  }

  Future<void> storeTransaksi(List<Map<String, int>> payload) async {
    String? token = await _storage.read(key: 'token');
    await _http.post(
      '/transaksi',
      data: jsonEncode(payload),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
