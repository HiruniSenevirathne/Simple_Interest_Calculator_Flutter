import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title:'Simple Interest Calculator App',
    home:SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor:Colors.indigo,
      accentColor:Colors.indigoAccent
    ),
  ));
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget>createState(){
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm>{

  var _formKey=GlobalKey<FormState>();
  var _currencies=['Rupees','Dollars','Pounds'];

  var _currentItemSelected='';

  @override
  void initState(){
    super.initState();
    _currentItemSelected=_currencies[0];
  }

  TextEditingController principalController =TextEditingController();
  TextEditingController roiController =TextEditingController();
  TextEditingController termController =TextEditingController();

  var displayResult='';
  @override
  Widget build(BuildContext context){
    TextStyle textStyle=Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar:AppBar(title: Text('Simple Interest Calculator'),),
      body: Form(
        key: _formKey,
        child:Padding(
          padding: EdgeInsets.all(10),
        child:ListView(children: <Widget>[
          getImageAsset(),
          Padding(
            padding: EdgeInsets.only(top:5.0,bottom:5.0),
            child:TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            controller: principalController,
            validator: (String value){
              if(value.isEmpty){
                return 'Please Enter a Value';
              }
            },
            decoration: InputDecoration(
              labelText: 'Principal',
              labelStyle: textStyle,
              errorStyle: TextStyle(
                color:Colors.yellowAccent,
                fontSize:15.0,
              ),
              hintText: 'Enter Principal e.g. 12000',
              border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(5.0)
              )
            )
          )),
           Padding(
            padding: EdgeInsets.only(top:5.0,bottom:5.0),
            child:TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            validator: (String value){
              if(value.isEmpty){
                return 'Please Enter a Value';
              }
            },
            controller: roiController,
            decoration: InputDecoration(
              labelText: 'Rate of Interest',
              labelStyle: textStyle,
              errorStyle: TextStyle(
                color:Colors.yellowAccent,
                fontSize:15.0,
              ),
              hintText: 'In Percent',
              border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(5.0)
              )
            )
          )),
          Padding(
           padding: EdgeInsets.only(top:5.0,bottom:5.0), 
           child:Row(children: <Widget>[
           Expanded(child: TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            validator: (String value){
              if(value.isEmpty){
                return 'Please Enter a Value';
              }
            },
            controller: termController,
            decoration: InputDecoration(
              labelText: 'Term',
              labelStyle: textStyle,
              errorStyle: TextStyle(
                color:Colors.yellowAccent,
                fontSize:15.0,
              ),
              hintText: 'Time in Years',
              border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(5.0)
              )
            )
          )
          ),
          Container(width:25.0),
          Expanded(
            child:DropdownButton<String>(
            items: _currencies.map((String value){
            return DropdownMenuItem<String>(
              value:value,
              child:Text(value),
              );
         }).toList(),
         value:_currentItemSelected, onChanged: (String newValueSelected) { 
           _onDropDownItemSelected(newValueSelected);
          },
          )
          )
          ],)
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0,top:5.0),
            child:Row(
            children:<Widget>[
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child:Text('Calculate'),
              onPressed: (){
                
                  setState(() {
                    if(_formKey.currentState.validate()){
                       this.displayResult=_calculateTotalReturns();
                    }
                  });
              }),
              ),
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child:Text('Reset'),
              onPressed: (){
                setState(() {
                  _reset();
                });
              }),
              ),
            ],)
          ),
          Padding(padding: EdgeInsets.all(5.0*2),
          child:Text(this.displayResult,style: textStyle,),)
        ],
        )
        )
      ),
    );
  }
Widget getImageAsset(){
  AssetImage assetImage=AssetImage('images/money.png');
  Image image= Image(image: assetImage, height: 130.0,);
  return Container(child:image, margin: EdgeInsets.all(50),);
}
void _onDropDownItemSelected(String newValueSelected){
  setState(() {
    this._currentItemSelected=newValueSelected;
  });
}
String _calculateTotalReturns(){
  double principal=double.parse(principalController.text);
  double roi=double.parse(roiController.text);
  double term=double.parse(termController.text);

  double totalAmountPayable=principal+(principal*roi*term)/100;

  String result = 'After $term yraes, your investment will be worth $totalAmountPayable $_currentItemSelected';
  return result;
}
void _reset(){
  principalController.text='';
  roiController.text='';
  termController.text='';
  displayResult='';
  _currentItemSelected=_currencies[0];
}
}