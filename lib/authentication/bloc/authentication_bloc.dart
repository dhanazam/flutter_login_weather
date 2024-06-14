import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// The AuthenticationBloc manages the authenticaiton state of the application which is used to determine things like
// whether or not to start the user at a login page or a home page.
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({ required UserRepository userRepository, required AuthenticationRepository authenticationRepository }) 
    : _authenticationRepository = authenticationRepository,
      _userRepository = userRepository,
      super(const AuthenticationState.unknown()) {
        on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
        on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
        _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(_AuthenticationStatusChanged(status)),
        );
      }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated());
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }
  

  FutureOr<void> _onAuthenticationLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
