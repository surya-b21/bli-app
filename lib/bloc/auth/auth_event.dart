part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStart extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String email;
  final String password;

  LoggedIn({required this.email, required this.password});

  @override
  String toString() => 'LoggedIn { email: $email, password: $password }';
}

class Logout extends AuthEvent {}
