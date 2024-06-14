part of 'authentication_bloc.dart';

// AuthenticationEvent instances will be the input to the AuthenticationBloc and will be processed and used to emit new AuthenticationState instances.
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

// This class wont be used outside of the AuthenticationBloc
final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}