import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Generate {
  // letters, nummbers, symbols
  final String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
  final String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String numbers = "1234567890";
  final String symbols = "!@#\$%^&*<>?(){}[],+=/\\";

  // random number generator
  int generateRandInt(int min, int max) {
    Random random = Random();
    return (min + random.nextInt(max - min));
  }


  // password generator
  // ignore: body_might_complete_normally_nullable
  String? generatePassword({
    required int passwordLength,
    required bool isNumber,
    required bool isUpperCase,
    required bool isLowerCase,
    required bool isSymbol,
    required bool isDuplicates,
    required BuildContext context,
  }) {
    String password = "";
    String megaString = "";
    int? randInt;

    if (passwordLength < 6 || passwordLength > 32) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Invalid-Password-Length(should be between 6 and 32)")),
      );
    }
    else if (isNumber == false && isUpperCase == false && isLowerCase == false && isSymbol == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: No field selected")),
      ); 
    }
    else {
      if (isNumber) {
        megaString += numbers;
      }
      if (isUpperCase) {
        megaString += upperCaseLetters;
      }
      if (isLowerCase) {
        megaString += lowerCaseLetters;
      }
      if (isSymbol) {
        megaString += symbols;
      }
      
      if (isDuplicates) {
        for (int i = 0; i < passwordLength; i++)  {
          randInt = generateRandInt(0, megaString.length);
          password += megaString[randInt];
        }
        return password;
      }
      else {
        for (int i = 0; i < passwordLength; i++) {
          randInt = generateRandInt(0, megaString.length);
          for (int j = 0; j < password.length; j++) {
            if(megaString[randInt!] == password[j]) {
              randInt = generateRandInt(0, megaString.length);
              while(true) {
                if (megaString[randInt!] == password[j]) {
                  randInt = generateRandInt(0, megaString.length);
                }
                else {
                  break;
                }
              }
              break;
            }
          }
          password += megaString[randInt!];
        }
        return password;
      }
    }
  }

  // copy text from textfield
  void copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied to Clipboard!"),
      ),
    );
  }
}