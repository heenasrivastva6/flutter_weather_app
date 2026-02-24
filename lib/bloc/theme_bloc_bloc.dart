import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

// Events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class LoadTheme extends ThemeEvent {}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeBlocState> {
  ThemeBloc() : super(ThemeBlocInitial()) {
    on<LoadTheme>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDark') ?? true;
      emit(
        isDark
            ? ThemeBlocSuccess(ThemeMode.dark)
            : ThemeBlocSuccess(ThemeMode.light),
      );
    });

    on<ToggleTheme>((event, emit) async {
      final nextMode = state.themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
      emit(ThemeBlocSuccess(nextMode));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', nextMode == ThemeMode.dark);
    });
  }
}
