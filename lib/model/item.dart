// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

List<ItemModel> itemModelFromJson(String str) =>
    List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemModelToJson(List<ItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int sort;
  final int itemId;
  final int qty;
  final int hargaSetelahPajak;
  final int userId;
  final Item item;

  ItemModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.sort,
    required this.itemId,
    required this.qty,
    required this.hargaSetelahPajak,
    required this.userId,
    required this.item,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sort: json["sort"],
        itemId: json["item_id"],
        qty: json["qty"],
        hargaSetelahPajak: json["harga_setelah_pajak"],
        userId: json["user_id"],
        item: Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sort": sort,
        "item_id": itemId,
        "qty": qty,
        "harga_setelah_pajak": hargaSetelahPajak,
        "user_id": userId,
        "item": item.toJson(),
      };
}

class Item {
  final int id;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String sku;
  final String nama;
  final int harga;
  final int stok;
  final String unitOfMaterial;

  Item({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.sku,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.unitOfMaterial,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sku: json["sku"],
        nama: json["nama"],
        harga: json["harga"],
        stok: json["stok"],
        unitOfMaterial: json["unit_of_material"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sku": sku,
        "nama": nama,
        "harga": harga,
        "stok": stok,
        "unit_of_material": unitOfMaterial,
      };
}
