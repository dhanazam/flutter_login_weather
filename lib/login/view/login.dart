import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_weather_flutter/login/bloc/login_bloc.dart';
import 'package:login_weather_flutter/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: BlocProvider(
          create: (context) {
            debugPrint('create LoginBloc');
            return LoginBloc(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),);
          },
          child: const LoginForm(),
        )
      )
    );
  }
}


 
