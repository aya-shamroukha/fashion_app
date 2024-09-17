// ignore_for_file: avoid_print

import 'package:fashion_app/core/domain/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'log_in_event.dart';
import 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  bool isPassword = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LogInBloc() : super(LogInInitial()) {
    on<LogInSuccess>((event, emit) async {
      emit(LogInLoadingState());
      final isSuccess = await AuthServiceImpl().logIn(event.logInModel);
      print('----------------');
      print(isSuccess);
      if (isSuccess) {
        emit(LogInSuccessState());
      } else {
        emit(LogInFieldState());
      }
    });
    on<PasswordEvent>(
      (event, emit) {
        isPassword = !isPassword;
        emit(PasswordState());
      },
    );
  }
}
