import 'package:bli_app/bloc/auth/auth_bloc.dart';
import 'package:bli_app/cubit/transaksi/transaksi_cubit.dart';
import 'package:bli_app/views/item.dart';
import 'package:bli_app/views/transaksi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<TransaksiCubit>().getInvoice();
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
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(Logout());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<TransaksiCubit, TransaksiState>(
          builder: (context, state) {
            if (state is TransaksiNotFound) {
              return const Text('Anda belum mempunyai transaksi');
            } else if (state is TransaksiFound) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.data[index]["${index + 1}"]),
                      ],
                    ),
                    onTap: () {
                      Map map = state.data[index];
                      String key = map.keys.firstWhere(
                        (k) => map[k] == state.data[index]["${index + 1}"],
                        orElse: () => '',
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => TransaksiCubit(),
                            child: ItemList(sort: int.parse(key)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Transaksi(),
            ),
          );

          setState(() {
            context.read<TransaksiCubit>().getInvoice();
          });
        },
        label: const Text(
          'Transaksi',
          style: TextStyle(fontSize: 16),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
