import 'package:auth/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc/auth.dart';
import 'repositories/repositories.dart';
import 'screens/auth/intro_screen.dart';
import 'package:auth/style/theme.dart' as Style;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository, key: Key(""),),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({required Key key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('mn', 'MN'),
      theme: ThemeData(
          fontFamily: 'Rubik',
          primarySwatch: Colors.blueGrey,
          ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return MainScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return IntroPage(key: Key("g"),);
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
                body: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                                          child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
          strokeWidth: 4.0,
        ),
                      )
                    ],
                  ),
                ),
              );
          }
          return Scaffold(
                body: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                                          child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
          strokeWidth: 4.0,
        ),
                      )
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }
}
