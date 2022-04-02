
import 'package:auth/bloc/auth_bloc/auth.dart';
import 'package:auth/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/repositories.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({required Key key})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: BlocProvider.of<AuthenticationBloc>(context).userRepository,
          );
        },
        child: LoginForm(key: Key(""),),
      ),
    );
  }
}