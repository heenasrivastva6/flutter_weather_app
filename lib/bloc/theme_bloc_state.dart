part of 'theme_bloc_bloc.dart';

abstract class ThemeBlocState extends Equatable {
  final ThemeMode themeMode;
  const ThemeBlocState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ThemeBlocSuccess extends ThemeBlocState {
  const ThemeBlocSuccess(super.mode);
}
