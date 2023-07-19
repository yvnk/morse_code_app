import 'package:morse_code_app/utils/app_loggers.dart';
import 'package:morse_code_translator/morse_code_translator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// we are using morse_code_translator library
/// to perform emncoding and decoding operations using below functions.
/// deCode(String text) -> For this function we need to pass encoded text to perform decoding operation.
/// enCode(String text) -> For this method we need to pass normal String to encode the data.

class Converter extends StateNotifier<String> {
  Converter() : super("");
  MorseCode morseCode = MorseCode();

  morseDecode(String decodeText) {
    state = morseCode.deCode(decodeText);
    AppLoggers().appLoggers("decode ::::::::: $state");
  }

  morseEncode(String encodeText) {
    AppLoggers().appLoggers("encode  ::::::::: $encodeText");
    state = morseCode.enCode(encodeText);
    AppLoggers().appLoggers("encodeed text::::: $state");
  }
}
