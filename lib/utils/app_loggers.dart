// ignore: file_names
import 'dart:developer';
import 'package:flutter/foundation.dart';

// hide prints in product builds.
class AppLoggers {
  appLoggers(String text) {
    if (!kReleaseMode) {
      log(text);
    }
  }

  appPrint(String text) {
    if (!kReleaseMode) {
      print(text);
    }
  }
}
