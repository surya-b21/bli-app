part of 'transaksi_cubit.dart';

@immutable
abstract class TransaksiState {}

class TransaksiInitial extends TransaksiState {}

class TransaksiFound extends TransaksiState {
  final List<dynamic> data;

  TransaksiFound({required this.data});
}

class TransaksiNotFound extends TransaksiState {}

class TransaksiLoading extends TransaksiState {}

class ItemFound extends TransaksiState {
  final List<ItemModel> data;

  ItemFound({required this.data});
}

class ItemLoading extends TransaksiState {}
