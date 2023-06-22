// ignore_for_file: depend_on_referenced_packages

import 'package:bli_app/model/item.dart';
import 'package:bli_app/services/transaksi_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaksi_state.dart';

class TransaksiCubit extends Cubit<TransaksiState> {
  final _transaksi = TransaksiServices();

  TransaksiCubit() : super(TransaksiInitial());

  void getInvoice() async {
    emit(TransaksiLoading());
    List<dynamic> data = await _transaksi.invoice();
    if (data.isEmpty) {
      emit(TransaksiNotFound());
    } else {
      emit(TransaksiFound(data: data));
    }
  }

  void getItem(int sort) async {
    emit(ItemLoading());
    List<ItemModel> data = await _transaksi.itemList(sort);

    emit(ItemFound(data: data));
  }
}
