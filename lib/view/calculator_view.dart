import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayush Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorView(),
    );
  }
}

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  final _operatorController = TextEditingController();

  double first = 0;
  double second = 0;
  String operator = "";

  double _calculation() {
    if (operator == "+") {
      return first + second;
    } else if (operator == "-") {
      return first - second;
    } else if (operator == "*") {
      return first * second;
    } else if (operator == "/") {
      return first / second;
    } else if (operator == "%") {
      return (first / 100) * second;
    } else {
      return first; // Return 0 if there's no valid operator
    }
  }

  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Ayush Calculator App',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Container with border for the left and right parts
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blue, width: 2), // Border around both parts
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // 1 part: Column on the left
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _operatorController,
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove internal border
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // 9 parts: TextFormField
                  Expanded(
                    flex: 9,
                    child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove internal border
                      ),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // Calculator buttons grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      String buttonText = lstSymbols[index];

                      // Clear all
                      if (buttonText == "C") {
                        _textController.clear();
                        _operatorController.clear();
                        first = 0;
                        second = 0;
                      }
                      // Backspace (remove last character)
                      else if (buttonText == "<-") {
                        String currentText = _textController.text;
                        if (currentText.isNotEmpty) {
                          _textController.text =
                              currentText.substring(0, currentText.length - 1);
                        }
                      }
                      // Operator handling
                      else if (buttonText == "+" ||
                          buttonText == "-" ||
                          buttonText == "*" ||
                          buttonText == "%" ||
                          buttonText == "/") {
                        operator = buttonText;
                        first = double.parse(_textController.text);
                        _operatorController.text =
                            "${_textController.text} $operator ";
                        _textController.text =
                            ""; // Clear the screen for second number
                      }
                      // Equals - perform calculation
                      else if (buttonText == "=") {
                        second = double.parse(_textController.text);
                        double result = _calculation();

                        if (result == result.toInt()) {
                          // If the result is a whole number, display as an integer
                          _textController.text = result.toInt().toString();
                        } else {
                          // If the result has a decimal part, round it to 2 decimal places
                          _textController.text = result.toStringAsFixed(2);
                        }
                      }
                      // Other buttons - append the symbol to the text
                      else {
                        _textController.text =
                            _textController.text + buttonText;
                      }
                    },
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
