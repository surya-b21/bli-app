// ignore_for_file: iterable_contains_unrelated_type, use_build_context_synchronously

import 'package:bli_app/model/item.dart';
import 'package:bli_app/services/transaksi_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final List<Item> _cart = [];
  final _transaksiService = TransaksiServices();
  List<Map<String, int>> payload = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'BLI Kasir',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TypeAheadField(
                textFieldConfiguration: const TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: "Masukkan nama barang",
                    hintStyle: TextStyle(color: Colors.black38),
                    labelText: "Pencarian",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.shopping_bag,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  List<Item> item = await _transaksiService.getItem(pattern);

                  return item;
                },
                itemBuilder: (context, itemData) => ListTile(
                  title: Text(itemData.nama),
                ),
                onSuggestionSelected: (suggestion) {
                  if (_cart.contains(suggestion.nama)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item telah ditambahkan'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    setState(() {
                      _cart.add(suggestion);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _cart.length,
                  itemBuilder: (context, index) => Card(
                    child: SizedBox(
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _cart[index].nama,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 65,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (payload
                                          .where((element) =>
                                              element['item_id'] ==
                                              _cart[index].id)
                                          .isNotEmpty) {
                                        // find index
                                        var indexItem = payload.indexWhere(
                                            (element) =>
                                                element['item_id'] ==
                                                _cart[index].id);

                                        payload[indexItem]['qty'] =
                                            int.parse(value);
                                      } else {
                                        Map<String, int> data = {
                                          "item_id": _cart[index].id,
                                          "qty": int.parse(value)
                                        };

                                        payload.add(data);
                                      }

                                      // if (_timer?.isActive ?? false) {
                                      //   _timer!.cancel();
                                      // }
                                      // _timer = Timer(
                                      //     const Duration(seconds: 3), () {
                                      //   print(
                                      //       "Field ke ${index + 1} dengan nilai $value");
                                      // });
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                        hintText: 'Jumlah'),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        payload.removeWhere((element) =>
                                            element['item_id'] ==
                                            _cart[index].id);
                                        _cart.remove(_cart[index]);
                                      });
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (payload.isNotEmpty) {
            await _transaksiService.storeTransaksi(payload);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('berhasil menambahkan transaksi'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Silahkan pilih item terlebih dahulu'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
