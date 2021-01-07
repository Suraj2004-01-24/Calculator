import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  SimpCalculatorState createState() => SimpCalculatorState();
}

class SimpCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  String Ans = "0";

  buttonPressed(buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "del") {
        equation = equation.substring(0, equation.length - 1);
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if (equation.length == 0) {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        } finally {
          if(result != "Error"){
            Ans = result;
          }else{
            Ans="0";
          }
          equation = "0";
          expression = "0";
        }
      }else if(buttonText=="Ans"){
        equation=equation+Ans;
      }else {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if (equation == "0") {
          equation = buttonText;
        } else if (equation == "00") {
          equation = "0";
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.white, width: 1.0, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SimpleCalculator"), centerTitle: true),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
            color: Colors.white,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
            color: Colors.white,
          ),
          Expanded(
            child: Divider(),
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            // width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton("C", 1, Colors.redAccent),
                    buildButton("del", 1, Colors.blue),
                    buildButton("÷", 1, Colors.blue),
                    buildButton("Ans", 1, Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", 1, Colors.black54),
                    buildButton("8", 1, Colors.black54),
                    buildButton("9", 1, Colors.black54),
                    buildButton("+", 1, Colors.blue)
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", 1, Colors.black54),
                    buildButton("5", 1, Colors.black54),
                    buildButton("6", 1, Colors.black54),
                    buildButton("-", 1, Colors.blue)
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", 1, Colors.black54),
                    buildButton("2", 1, Colors.black54),
                    buildButton("3", 1, Colors.black54),
                    buildButton("×", 1, Colors.blue)
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", 1, Colors.black54),
                    buildButton("0", 1, Colors.black54),
                    buildButton("00", 1, Colors.black54),
                    buildButton("=", 1, Colors.redAccent)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
