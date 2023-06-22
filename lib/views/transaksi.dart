import 'package:flutter/material.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final List<String> _options = ['Kaca', 'Pipa', 'Kran Besi'];
  final List<String> _cart = ['Kaca'];

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
              Autocomplete<String>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }

                  return _options.where(
                    (element) => element.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ),
                  );
                },
                // fieldViewBuilder: (
                //   context,
                //   textEditingController,
                //   focusNode,
                //   onFieldSubmitted,
                // ) =>
                //     const TextField(
                //   decoration: InputDecoration(
                //     hintText: "Masukkan nama barang",
                //     hintStyle: TextStyle(color: Colors.black38),
                //     labelText: "Pencarian",
                //     labelStyle: TextStyle(color: Colors.black),
                //     prefixIcon: Icon(
                //       Icons.shopping_bag,
                //       color: Colors.grey,
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey)),
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey)),
                //     focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey)),
                //   ),
                // ),
                onSelected: (option) {
                  if (_cart.contains(option)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item telah ditambahkan'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    setState(() {
                      _cart.add(option);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
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
                              _cart[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 65,
                                  child: Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration:
                                          InputDecoration(hintText: 'Jumlah'),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
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
    );
  }
}
