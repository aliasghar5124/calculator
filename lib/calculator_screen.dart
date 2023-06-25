import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList=[
    'AC',
    '(',
    ')',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/3,
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.topRight,
              child: Text(
                userInput,
                style: TextStyle(fontSize: 32,color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.all(47),
              alignment: Alignment.topLeft,
              child: Text(
                "Result",
                style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
              ),
            )
          ],
          ),
          ),
          Divider(color: Colors.white,),
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:4,
                crossAxisSpacing:12,
                mainAxisSpacing:12,
    ),
                itemBuilder: (BuildContext context, int index){
                  return CustomButton(buttonList[index]);
                },
            ),
          ))
        ],
      ),
    );
  }
  Widget CustomButton(String text){
    return InkWell(
      splashColor: Color(0xFFC0C0C0),
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0.5,
            offset: Offset(-3,-3),
          )]

    ),
        child: Center(
          child: Text(text,style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
        ),
      ),
    );
  }
  handleButtons(String text){
    if(text=='AC'){
      userInput="";
      result="0";
      return;
    }
    if(text=='C'){
      if(userInput.isNotEmpty){
        userInput=userInput.substring(0, userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }
    if(text=="="){
      result=calculate();
      userInput=result;
      if(userInput.endsWith(".0")){
        userInput=userInput.replaceAll(".0", "");
        return;
      }
      if(result.endsWith(".0")){
        result=result.replaceAll(".0", "");
        return;
      }
    }
    userInput=userInput+text;
  }
  String calculate(){
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL,ContextModel());
      return evaluation.toString();
    }catch(e){
      return "Error";
    }
  }
}
