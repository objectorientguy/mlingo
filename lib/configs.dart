import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

abstract class DatabaseUtil {
  static late final Box box;
}

ThemeData appTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.darkGrey),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.blue),
          borderRadius: BorderRadius.circular(8)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red),
          borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red),
          borderRadius: BorderRadius.circular(8))),
  splashColor: const Color(0x00000000),
  hoverColor: const Color(0x00000000),
  focusColor: const Color(0x00000000),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);

class AppColor {
  static const Color blue = Color(0xff0070ff);
  static const Color blueGrey = Color(0xff344155);
  static const Color grey = Color(0xff7a8294);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color red = Color(0xffC70000);
  static const Color lightGreen = Color(0xffecfef3);
  static const Color green = Color(0xff15ba6d);
  static const Color lighterGrey = Color(0xfff1f4f7);
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color(0xff596372);
}

extension AppTextTheme on TextTheme {
  TextStyle get regular {
    return const TextStyle(
        fontSize: 14, color: AppColor.grey, fontWeight: FontWeight.w500);
  }

  TextStyle get regularSmall {
    return const TextStyle(
        fontSize: 12, color: AppColor.grey, fontWeight: FontWeight.w500);
  }

  TextStyle get bold {
    return const TextStyle(
        fontSize: 14, color: AppColor.black, fontWeight: FontWeight.w600);
  }

  TextStyle get heading {
    return const TextStyle(
        fontSize: 26, color: AppColor.black, fontWeight: FontWeight.w600);
  }

  TextStyle get buttonText {
    return const TextStyle(
        fontSize: 14, color: AppColor.blueGrey, fontWeight: FontWeight.w500);
  }
}
