import 'dart:ui';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/components/resuable_card.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {


  Gender selectedGender;
  int _height = 180;
  int _weight = 60;
  int _age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(
                child: ResuableCard(
                  colour: selectedGender == Gender.male ? kActiveCardColour : kInactiveCardColour,
                  cardChild: IconWidgets(
                    icon: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                  onPress: (){setState(() {selectedGender = Gender.male;});
                  },
                ),
              ),
              Expanded(child: ResuableCard(
                onPress: (){setState(() {selectedGender = Gender.female;});},
                colour: selectedGender == Gender.female ? kActiveCardColour : kInactiveCardColour,
                cardChild: IconWidgets(
                  icon: FontAwesomeIcons.venus,
                  label: 'FEMALE',
                ),
              ),),
            ],
          ),),
          Expanded(child: ResuableCard(
            colour: kInactiveCardColour,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("HEIGHT",style:kLabelTextStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(_height.toString(),style: kNumberTextStyle),
                    Text('cm',style: kLabelTextStyle),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0X29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: _height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    onChanged: (double newValue){
                      setState(() {_height = newValue.round();});},
                  ),
                ),
              ],
            ),
          ),),
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: ResuableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("WEIGHT",style: kLabelTextStyle),
                    Text(_weight.toString(),style: kNumberTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(icon: FontAwesomeIcons.minus,onPressed: (){
                          setState(() {_weight > 20 ? _weight-- : _weight = 350;});
                        },),
                        SizedBox(width: 10,),
                        RoundIconButton(icon: FontAwesomeIcons.plus,onPressed: (){
                          setState(() {_weight < 350 ? _weight++ : _weight = 20;});
                        },),
                      ],
                    ),
                  ],
                ),
                colour: kInactiveCardColour,
              ),),
              Expanded(child: ResuableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("AGE",style: kLabelTextStyle),
                    Text(_age.toString(),style:kNumberTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(icon: FontAwesomeIcons.minus,onPressed: (){
                          setState(() {
                            setState(() {_age > 1 ? _age-- : _age = 150;});
                          });
                        },),
                        SizedBox(width: 10.0,),
                        RoundIconButton(icon: FontAwesomeIcons.plus,onPressed:(){
                          setState(() {
                            setState(() {_age < 150 ? _age++ : _age = 0;});
                          });
                        }),
                      ],
                    ),
                  ],
                ),
                colour: kInactiveCardColour,
              ),),
            ],
          ),),
          BottomButton(
            buttonTitle:'CALCULATE',
            onTab: (){
              CalculatorBrain calc = CalculatorBrain(height: _height,weight: _weight);
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=> Result(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
              ),),);
            },),
        ],
      ),
    );
  }
}





