import 'package:morse_code_app/utils/app_loggers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// we are using morse_code_translator library
/// to perform emncoding and decoding operations using below functions.
/// deCode(String text) -> For this function we need to pass encoded text to perform decoding operation.
/// enCode(String text) -> For this method we need to pass normal String to encode the data.

class Converter extends StateNotifier<String> {
  Converter() : super("");
// taken this data from the library
  final Map<String, String> morseJson = {
    '': '⍰',
    ' ': '/',
    'a': '.-',
    'b': '-...',
    'c': '-.-.',
    'd': '-..',
    'e': '.',
    'f': '..-.',
    'g': '--.',
    'h': '....',
    'i': '..',
    'j': '.---',
    'k': '-.-',
    'l': '.-..',
    'm': '--',
    'n': '-.',
    'o': '---',
    'p': '.--.',
    'q': '--.-',
    'r': '.-.',
    's': '...',
    't': '-',
    'u': '..-',
    'v': '...-',
    'w': '.--',
    'x': '-..-',
    'y': '-.--',
    'z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    '!': '-.-.--',
    '?': '..--..',
    '@': '.--.-.',
    '=': '-...-',
    '&': '.-...',
    '(': '-.--.',
    ')': '-.--.-',
    '-': '-....-',
    '_': '..--.-',
    '+': '.-.-.',
    ';': '-.-.-.',
    ':': '---...',
    '\$': '...-..-',
    '\'': '.----.',
    '\"': '.-..-.',
    ',': '--..--',
    '.': '.-.-.-',
    '/': '-..-.',
  };

  morseDecode(String decodeText) {
    AppLoggers().appLoggers("decodeString::::: ${decodeText.split(" ")}");

    state = decodeText.split(" ").map((e) => convertion(e, false)).join("");
    AppLoggers().appLoggers("decoded text::::: $state");
  }

  morseEncode(String encodeText) {
    AppLoggers().appLoggers("checkk::::: ${encodeText.split("")}");
    state = encodeText
        .toLowerCase()
        .split("")
        .map((e) => convertion(e, true))
        .join(" ");

    AppLoggers().appLoggers("   encoded text::::: $state");
  }

// this function calls to make String to Morse or Morse to String
  String convertion(String letter, bool toConvertMorseCode) {
    String convertionLetter = '';
    morseJson.forEach((key, code) {
      if ((toConvertMorseCode ? letter.toLowerCase() : letter) ==
          (toConvertMorseCode ? key.toLowerCase() : code)) {
        convertionLetter = toConvertMorseCode ? code : key;
        AppLoggers().appLoggers("encoded text::::: $convertionLetter");
      }
    });
    return convertionLetter;
  }
}
