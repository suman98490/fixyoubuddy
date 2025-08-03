import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';



class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  int maxlength=10;
  final mobilenumber = TextEditingController();
  bool issubmitenabled=false;



  Row newTextRow(String label,MainAxisAlignment MainAxisalign, Color color, FontWeight fontweight, double fontsize,double Width){
    return Row(
      mainAxisAlignment: MainAxisalign,
      children: [
        SizedBox(width: Width),
        Text(label,
          style: GoogleFonts.lato(fontSize: 20, color: color, fontWeight: fontweight),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  height: screenheight * (1/2),
                  width: screenwidth,
                  color: Color(0xFF000080),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt,
                              size: 50,
                              color: Colors.white),
                          Text("Fix you Buddy",
                            style: GoogleFonts.lato(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 10.0),
                      newTextRow("-- We Solve Your Problems --", MainAxisAlignment.center,Colors.white,FontWeight.bold,20.0,10.0)
                    ],
                  ),
                ),
                Container(
                  height: screenheight * (1/2),
                  width: screenwidth,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          newTextRow("Sign up or Login", MainAxisAlignment.start,Colors.black,FontWeight.bold,20.0,0),
                          SizedBox(height: 15.0),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength:maxlength,
                            controller: mobilenumber,
                            decoration: InputDecoration(
                                label: Text("Enter your Mobile Number",
                                  style: GoogleFonts.lato(fontSize: 20),),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                counterText: ""
                            ),
                              onChanged: (value){
                              if(value.length == maxlength){
                                setState(() {
                                  issubmitenabled = true;
                                });
                                FocusScope.of(context).unfocus();
                              }else{
                                setState(() {
                                  issubmitenabled = false;
                                });
                              }
                              },
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed :  issubmitenabled ? () async {
                            final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                            sharedpreferences.setString('MobileNumber', mobilenumber.text);
                            Navigator.pushNamed(context, '/home',
                            arguments:  {'MobileNumber' : mobilenumber.text});
                          }:null,
                          child: Text("Submit",
                            style: GoogleFonts.lato(color: issubmitenabled ? Colors.white : Colors.black,fontSize:20, fontWeight: issubmitenabled ? FontWeight.bold : FontWeight.normal),),
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF000080),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ))
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}
