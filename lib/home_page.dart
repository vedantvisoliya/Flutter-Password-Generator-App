import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_generator_app/generate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // genrated password variable
  String? _genratedPassword;

  // checkbox variables
  bool allowUpperCase = true;
  bool allowLowercase = true;
  bool allowNumbers = false;
  bool allowSymbols = false;
  bool allowDuplicates = true;

  // password length controller
  TextEditingController lengthController = TextEditingController();

  // instance of password generator
  Generate generate = Generate();

  @override
  Widget build(BuildContext context) {
    // screen width and height
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // height and width.
        width: screenWidth,
        height: screenHeight,

        // background colors blend of 3.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 214, 196, 242),
              Color.fromARGB(255, 178, 141, 255),
              Color.fromARGB(255, 138, 77, 255),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),

        // container
        child: Center(
          child: Container(
            width: 700,
            height: 330,
            // glass like transparency
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.22,
                red: 255,
                green: 255,
                blue: 255,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    // TITLE ------>
                    Text(
                      "Password Generator!",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // SUBTITLE ------>
                    Column(
                      children: [
                        Text(
                          "Protect your online accounts with confidence using our password generator.",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "Create unique combinations in seconds to enhance digital security.",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // DISPLAY AND BUTTON ------->
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(
                                alpha: 0.27,
                                red: 255,
                                green: 255,
                                blue: 255,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // display the password
                                Text(
                                  _genratedPassword ?? "Create Now.",
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // copy icon
                                IconButton(
                                  onPressed: () => generate.copyText(
                                    context,
                                    _genratedPassword ?? "Create Now.",
                                  ),
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.grey.shade500,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 10.0),

                        // generate password button
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 35, 59),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if (lengthController.text.isNotEmpty) {
                                  setState(() {
                                    _genratedPassword = generate
                                        .generatePassword(
                                          passwordLength: int.parse(
                                            lengthController.text,
                                          ),
                                          isNumber: allowNumbers,
                                          isUpperCase: allowUpperCase,
                                          isLowerCase: allowLowercase,
                                          isSymbol: allowSymbols,
                                          isDuplicates: allowDuplicates,
                                          context: context,
                                        );
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Error: Enter password length between 6 and 32.",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Generate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    // CUSTOMISE PASSWORD ------>
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.27,
                            red: 255,
                            green: 255,
                            blue: 255,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // column 1 ----------->
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // password length
                                Row(
                                  children: [
                                    // text
                                    Text(
                                      "Password Length",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),

                                    const SizedBox(width: 10.0),

                                    // text field
                                    SizedBox(
                                      width: 40,
                                      height: 30,
                                      child: TextField(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        maxLength: 2,
                                        keyboardType: TextInputType.number,
                                        controller: lengthController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            bottom: 5.0,
                                          ),
                                          counterText: "",
                                          filled: true,
                                          fillColor: Colors.black,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4.0,
                                            ), // Adjust value for more/less curve
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // allow numbers
                                Row(
                                  children: [
                                    // text
                                    Text(
                                      "Allow Numbers",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    // check box
                                    Checkbox(
                                      value: allowNumbers,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          allowNumbers = newValue!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // allow uppercase letters
                                Row(
                                  children: [
                                    // text
                                    Text(
                                      "Allow UpperCase Letters",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    // check box
                                    Checkbox(
                                      value: allowUpperCase,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          allowUpperCase = newValue!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // column 2 ----------->
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // allow lowercase letters
                                Row(
                                  children: [
                                    // text
                                    Text(
                                      "Allow LowerCase Letters",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    // check box
                                    Checkbox(
                                      value: allowLowercase,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          allowLowercase = newValue!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // allow symbols
                                Row(
                                  children: [
                                    // text
                                    Text(
                                      "Allow Symbols",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    // check box
                                    Checkbox(
                                      value: allowSymbols,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          allowSymbols = newValue!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // allow duplicates
                                Row(
                                  children: [
                                    // text
                                    Text(
                                      "Allow Duplicates",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    // check box
                                    Checkbox(
                                      value: allowDuplicates,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          allowDuplicates = newValue!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
