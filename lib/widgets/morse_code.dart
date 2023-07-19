// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_code_app/controller/converter.dart';
import 'package:morse_code_app/utils/app_loggers.dart';

final converterProvider = StateNotifierProvider((_) => Converter());

class MorseCodeApp extends StatefulWidget {
  const MorseCodeApp({super.key});

  @override
  State<MorseCodeApp> createState() => _MorseCodeAppState();
}

class _MorseCodeAppState extends State<MorseCodeApp> {
  String beforeData = "";
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Morse Demo App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: textController,
              onTapOutside: (event) {
                beforeData = textController.text;
                FocusScope.of(context).unfocus();
              },
              decoration: const InputDecoration(
                hintText: "Enter the Data",
                labelText: "Enter the Data",
                fillColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Consumer(builder: (builder, watch, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: buttons(
                          context,
                          converterProvider,
                          watch,
                          textController,
                          title: "Encode",
                          isDecodeText: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: buttons(
                          context,
                          converterProvider,
                          watch,
                          textController,
                          title: "Decode",
                          isDecodeText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  beforeData.trim().isNotEmpty
                      ? Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              displayOutput(watch,
                                  inputText: "Given Data",
                                  outputText: beforeData),
                              displayOutput(watch,
                                  inputText: "Converted Data", outputText: ""),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

/// Displaying output using the below function.
/// ref -> reference of State
/// inputText -> Static Text (Given Data or Convereted Data)
/// outputText-> the Text given in TextField or Convereted by Morse Lib
///

Widget displayOutput(
  WidgetRef ref, {
  String inputText = "",
  String outputText = "",
}) {
  return Text.rich(
    TextSpan(
      text: "$inputText: ",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      children: [
        TextSpan(
          text: outputText.trim().isNotEmpty
              ? outputText
              : "${ref.watch(converterProvider)}",
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        )
      ],
    ),
  );
}

/// The below function is used to display
/// Encode and Decode buttons for user interaction.
/// These functions call's the "Converter" class methods to perform morse operations

Widget buttons(
  BuildContext context,
  StateNotifierProvider<Converter, Object?> converterProvider,
  WidgetRef ref,
  TextEditingController data, {
  String title = "",
  bool isDecodeText = false,
}) {
  return OutlinedButton(
    onPressed: () async {
      AppLoggers().appLoggers("${data.text} ::::::::::::::::");
      if (data.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Enter the text")));
      } else {
        isDecodeText
            ? ref.read(converterProvider.notifier).morseDecode(data.text)
            : ref.read(converterProvider.notifier).morseEncode(data.text);
      }
      data.clear();
      ref.read(converterProvider);
    },
    child: Text(title),
  );
}
