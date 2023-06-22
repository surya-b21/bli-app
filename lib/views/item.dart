import 'package:bli_app/cubit/transaksi/transaksi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  final int sort;

  const ItemList({super.key, required this.sort});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final currency = NumberFormat("#,###", "pt");
  @override
  void initState() {
    // TODO: implement initState
    context.read<TransaksiCubit>().getItem(widget.sort);
    super.initState();
  }

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
        child: BlocBuilder<TransaksiCubit, TransaksiState>(
          builder: (context, state) {
            if (state is ItemFound) {
              int total = 0;
              for (int i = 0; i < state.data.length; i++) {
                total = total + state.data[i].hargaSetelahPajak;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Total Rp. ${currency.format(total)}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: Text(
                            "${state.data[index].qty.toString()} ${state.data[index].item.unitOfMaterial}",
                            style: const TextStyle(fontSize: 17),
                          ),
                          title: Text(state.data[index].item.nama,
                              style: const TextStyle(fontSize: 17)),
                          trailing: Text(
                              'Rp. ${currency.format(state.data[index].hargaSetelahPajak)}',
                              style: const TextStyle(fontSize: 17)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
