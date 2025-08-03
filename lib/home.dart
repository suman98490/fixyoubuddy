import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/widgets/carouselbanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var  MobileNumber;
   var categoryList=[
     {"categoryName":"Electrician","icon":"electrician"},
     {"categoryName":"Plumbing","icon":"plumber"},
     {"categoryName":"Air Conditioning","icon":"ac"},
     {"categoryName":"Washing Machine","icon":"washingmachine"},
   ];
   var mostPopular=[
     {"categoryName":"Fan Repair","icon":"fan"},
     {"categoryName":"AC Install","icon":"acrepair"},
     {"categoryName":"Transport","icon":"transport"},
     {"categoryName":"Catering","icon":"catering"},
   ];
   var topRated=[
     {"categoryName":"Suman","icon":"user"},
     {"categoryName":"Ayub","icon":"user"},
     {"categoryName":"Munendra","icon":"user"},
     {"categoryName":"Ramesh","icon":"user"},
   ];

  @override
  void initState(){
    super.initState();
    getCategories();
  }
  void initiaization() async{
    await Future.delayed(Duration(seconds: 5));
  }
  Future getMobileNumber() async{
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    var obtainedvalue =  sharedpreferences.getString('MobileNumber');
    setState(() {
      MobileNumber = obtainedvalue;
    });
  }
  Future getCategories() async{
    final getCategories = await get(Uri.parse('https://fixubuddy-api-978338023784.asia-south1.run.app/categories/'));
    final categories = getCategories.body;
    print("categories are");
    print(categories);
  }

   Card categoryCard(double screenHeight, double screenWidth, String cardName, String imageName){
     return  Card(
         color: Colors.white70,
         child: Container(
           height: screenHeight/8,
           width: screenWidth/2,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: EdgeInsets.all(5.0),
                 child: Text(cardName,
                   style:  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.normal),),
               ),
               Flexible(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Flexible(child:  Image.asset("assets/$imageName.png",
                         height: 80,width: 80, alignment: Alignment.bottomRight))
                   ],
                 ),
               )
             ],
           ),
         )
     );
   }
   Card businessCard(double screenHeight, double screenWidth, String cardText, Color cardColor, String buttonText){
    return  Card(
      color: cardColor,
      child: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Text(cardText,
                  style: GoogleFonts.lexend(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
                onPressed: ()=>{},
                child: Text(buttonText,
                  style: GoogleFonts.lexend(color: cardColor,fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                )
            )
          ],
        ),
      ),
    );
   }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    MobileNumber = ModalRoute.of(context)?.settings.arguments;
    print(MobileNumber);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(Icons.person_2_sharp,
        color: Colors.white,size: 30),
        backgroundColor: Color(0xFF000080),
        /*leading: IconButton(
          onPressed: null,
          icon: Icon(Icons.menu, color: Colors.white,),),*/
        actions: [
          IconButton(
              onPressed: () async{
                final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                sharedpreferences.remove('MobileNumber');
                print("removed number is");
                print(sharedpreferences);
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout, color: Colors.white),),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning Suman",
              style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF000080)),),
              //servicesCardRow(screenHeight, screenWidth,"Electrician","Plumbing","electrician","plumber"),
             // servicesCardRow(screenHeight, screenWidth,"Air Conditioning","Washing Machine","ac","washingmachine"),
              GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  children: List.generate(categoryList.length,(index){
                    return  categoryCard(screenHeight, screenWidth,categoryList[index]["categoryName"]!,categoryList[index]["icon"]!);
                  })
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("View All", style: GoogleFonts.lato(fontSize: 18),),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              Carouselbanner(),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Most Popular", style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),),
                    Text("View All", style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: 20),)
                  ],
                ),
              ),
              Container(
                height: screenHeight/7,
                width: screenWidth,
                padding: EdgeInsets.all(5.0),
                child:  GridView.count(
                  crossAxisCount: 4,
                  children: List.generate(4, (index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.transparent
                              ),
                              child: Center(
                                child: Image.asset('assets/${mostPopular  [index]["icon"]}.png',
                                    fit: BoxFit.cover),
                              )
                          ),
                        ),
                        SizedBox(height: 5),
                        Flexible(child:  Text("${mostPopular[index]["categoryName"]}",
                          style: GoogleFonts.lato(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                      ],
                    );
                  }),
                )
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Top Technicians", style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),),
                    Text("View All", style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: 20),)
                  ],
                ),
              ),
              Container(
                  height: screenHeight/7,
                  width: screenWidth,
                  padding: EdgeInsets.all(5.0),
                  child:  GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(4, (index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.transparent
                                ),
                                child: Center(
                                  child: Image.asset('assets/${topRated[index]["icon"]}.png',
                                      fit: BoxFit.cover),
                                )
                            ),
                          ),
                          SizedBox(height: 5),
                          Flexible(child:  Text("${topRated[index]["categoryName"]}",
                            style: GoogleFonts.lato(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                        ],
                      );
                    }),
                  )
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1,
                children: [
                  businessCard(screenHeight, screenWidth, "PLANNING TO BOOST YOUR BUSINESS ?", Color(0xFF000080),"JOIN US"),
                  businessCard(screenHeight, screenWidth, "MISSING OUR PREMIUM SERVICES ?", Color(0xFF526faa),"SUBSCRIBE NOW")
                ],
              ),
              ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>{},
        backgroundColor: Color(0xFF000080),
        shape: CircleBorder(),
        child: Icon(Icons.home,color: Colors.white, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu,color: Color(0xFF000080)),label: "Menu"),
            BottomNavigationBarItem(icon: Icon(Icons.add_alert, color: Color(0xFF000080)),label: "Notifications")
          ],
        selectedItemColor: Color(0xFF000080),
        unselectedItemColor: Color(0xFF000080),
      )
    );
  }
}
