part of 'theme_bloc_bloc.dart';

abstract class ThemeBlocState extends Equatable {
  final ThemeMode themeMode;
  const ThemeBlocState(this.themeMode);

  @override
  List<Object> get props => [];
}

// final class ThemeBlocInitial extends ThemeBlocState {
//   final ThemeMode themeMode;

//   const ThemeBlocInitial({required this.themeMode});
// }

// final class ThemeBlocLoading extends ThemeBlocState {}

// final class ThemeBlocFailure extends ThemeBlocState {}

// final class ThemeBlocSuccess extends ThemeBlocState {
//   final ThemeMode themeMode;

//   const ThemeBlocSuccess(this.themeMode);

//   @override
//   List<Object> get props => [themeMode];
// }

class ThemeBlocInitial extends ThemeBlocState {
  const ThemeBlocInitial() : super(ThemeMode.system);
}

class ThemeBlocSuccess extends ThemeBlocState {
  const ThemeBlocSuccess(ThemeMode mode) : super(mode);
}
