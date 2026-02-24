import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/bloc/theme_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  final Position position;
  const HomeScreen({super.key, required this.position});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherBlocBloc weatherBloc;

  @override
  void initState() {
    weatherBloc = BlocProvider.of<WeatherBlocBloc>(context);
    weatherBloc.add(FetchWeather(widget.position));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark; // Detect current mode

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Use theme's surface color instead of hardcoded Colors.black
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<ThemeBloc, ThemeBlocState>(
            builder: (context, state) {
              //if (state is ThemeBlocSuccess) {
              return Switch(
                value: state.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                activeThumbColor: Colors.deepOrange,
              );
              // } else {
              //   return Container();
              // }
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          // Adjust status bar icons based on theme
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(
          40,
          1.2 * kToolbarHeight,
          40,
          20,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Background circles: Use primary/secondary container colors for softer glows
              Align(
                alignment: AlignmentGeometry.directional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? Colors.deepPurple
                        : Colors.blue.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.directional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? Colors.deepPurple
                        : Colors.blue.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.directional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.deepOrange
                        : Colors.red.withValues(alpha: 0.5),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                bloc: weatherBloc,
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    final textColor = isDark ? Colors.white : Colors.black87;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.weather.areaName}',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8), // 8-point gap below text
                        // Centers icon horizontally within the Column without using a Row
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.thunderstorm,
                            color: Colors.white,
                            size: 150,
                          ),
                        ),
                        Center(
                          child: Text(
                            '${state.weather.temperature!.celsius!.round()}°C',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 55,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${state.weather.weatherDescription}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            '12-February-2026',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.sunny,
                                  color: textColor,
                                  size: 24, // Large size as requested
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: [
                                    Text(
                                      'Sunrise',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '5:34 am',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.nights_stay,
                                  color: textColor,
                                  size: 24, // Large size as requested
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: [
                                    Text(
                                      'Sunset',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '6:35 pm',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.thermostat,
                                  color: textColor,
                                  size: 24, // Large size as requested
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: [
                                    Text(
                                      'Maximum Temp',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '${state.weather.tempMax!.celsius!.round()}°C',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  color: textColor,
                                  size: 24, // Large size as requested
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: [
                                    Text(
                                      'Minimum Temp',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '${state.weather.tempMin!.celsius!.round()}°C',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper with theme-aware styling
  Widget _buildThemedDetail(
    ThemeData theme,
    IconData icon,
    String title,
    String value,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, color: isDark ? Colors.white : theme.colorScheme.primary),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
            Text(
              value,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
