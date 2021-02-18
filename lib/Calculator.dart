import 'package:calculator_app/CalculatorButton.dart';
import 'package:flutter/material.dart';
import 'ResDisplay.dart';
import 'dart:ui';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  int firstNum;
  String operator;
  int secondNum ;
  int res;

  double width;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  Widget _getButton({String label, Function onTap, Color backgroundColor = Colors.white, Color labelColor = Colors.black}){
    return CalculatorButton(
        label: label,
        onTap: onTap,
        size: width / 4 - 12,
        backgroundColor: backgroundColor,
        labelColor: labelColor
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResDisplay(text: _getDisplayRes()),
        Row(
          children: [
            _getButton(label: '7', onTap: () => numberPressed(7)),
            _getButton(label: '8', onTap: () => numberPressed(8)),
            _getButton(label: '9', onTap: () => numberPressed(9)),
            _getButton(label: '+', onTap: () => operatorPressed('+'), backgroundColor: Colors.grey),
          ],
        ),
        Row(
          children: [
            _getButton(label: '4', onTap: () => numberPressed(4)),
            _getButton(label: '5', onTap: () => numberPressed(5)),
            _getButton(label: '6', onTap: () => numberPressed(6)),
            _getButton(label: '-', onTap: () => operatorPressed('-'), backgroundColor: Colors.grey),
          ],
        ),
        Row(
          children: [
            _getButton(label: '1', onTap: () => numberPressed(1)),
            _getButton(label: '2', onTap: () => numberPressed(2)),
            _getButton(label: '3', onTap: () => numberPressed(3)),
            _getButton(label: 'x', onTap: () => operatorPressed('x'), backgroundColor: Colors.grey),
          ],
        ),
        Row(
          children: [
            _getButton(label: '0', onTap: () => numberPressed(0)),
            _getButton(label: 'C', onTap: () => clear(), backgroundColor: Colors.orange, labelColor: Colors.white),
            _getButton(label: '=', onTap: () => calculateResult(), backgroundColor: Colors.grey),
            _getButton(label: '/', onTap: () => operatorPressed('/'), backgroundColor: Colors.grey),
          ],
        ),
      ],
    );
  }

  String _getDisplayRes() {
    if (res != null)
      return '$res';

    if (secondNum != null) {
      return '$firstNum$operator$secondNum';
    }
    if (operator != null) {
      return '$firstNum$operator';
    }
    if (firstNum != null) {
      return '$firstNum';
    }
    return '0';
  }

  numberPressed(int number){
    setState(() {
      if (res != null){
        res = null;
        firstNum = number;
        return;
      }
      if (firstNum == null){
        firstNum = number;
        return;
      }
      if (operator == null){
        firstNum = int.parse('$firstNum$number');
        return;
      }
      if (secondNum == null){
        secondNum = number;
        return;
      }

      secondNum = int.parse('$secondNum$number');
    });
  }

  operatorPressed(String op){
    setState(() {
      if (firstNum == null) firstNum = 0;
      this.operator = op;
    });
  }

  clear(){
    setState(() {
      res = null;
      firstNum = null;
      secondNum = null;
      operator = null;
    });
  }

  calculateResult(){
    if (operator == null || secondNum == null) return;

    setState(() {
      switch (operator){
        case '+':
          res = firstNum + secondNum;
          break;
        case '-':
          res = firstNum - secondNum;
          break;
        case 'x':
          res = firstNum * secondNum;
          break;
        case '/':
          if (secondNum == 0) return;
          res = firstNum ~/ secondNum;
          break;
      }
      firstNum = res;
      operator = null;
      secondNum = null;
      res = null;
    });
  }
}

