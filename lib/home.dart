import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/widgets/carouselbanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var  MobileNumber;
   bool isappLoaded = false;
   List<dynamic> categoryList=[];
   Map<String, dynamic> subCategories = {};
   var categoryList1=[
     {"name":"Home Services","image_url":"https://cdn-icons-png.flaticon.com/128/10364/10364864.png"},
     {"name":"Cool Services","image_url":"https://cdn-icons-png.flaticon.com/128/9047/9047865.png"},
     {"name":"Health Services","image_url":"https://cdn-icons-png.flaticon.com/128/4326/4326328.png"},
   ];
   var mostPopular=[
     {"name":"Fan Repair","icon":"fan"},
     {"name":"AC Install","icon":"acrepair"},
     {"name":"Transport","icon":"transport"},
     {"name":"Catering Services","icon":"catering"},
   ];
   var topRated=[
     {"name":"Suman","icon":"user"},
     {"name":"Ayub","icon":"user"},
     {"name":"Munendra","icon":"user"},
     {"name":"Ramesh","icon":"user"},
   ];

  @override
  /* Initial Function which will be called */
  void initState(){
    super.initState();
    getCategories();
    setState(() {
      isappLoaded = true;
    });
  }
  /* Not Referred initialization any where. just kept this for reference*/
  void initiaization() async{
    await Future.delayed(Duration(seconds: 5));
  }
   /* Get Mobile Number from Cache*/
  Future getMobileNumber() async{
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    var obtainedvalue =  sharedpreferences.getString('MobileNumber');
    setState(() {
      MobileNumber = obtainedvalue;
    });
  }
   /* Call Get Categories API. Screen will be loaded after this API call*/
  Future getCategories() async{
    final getCategories = await get(Uri.parse('https://fixubuddy-api-978338023784.asia-south1.run.app/categories/'));
    final categories = getCategories.body;
    print("categories are");
    setState(() {
    categoryList = jsonDecode(categories);
    });
  }

   Future getSubCategories(int index) async{
     final getSubCategories = await get(Uri.parse("https://fixubuddy-api-978338023784.asia-south1.run.app/categories/$index")) ;
     final getSubCategoriesResponse = getSubCategories.body;
     print(getSubCategoriesResponse);
     setState(() {
       subCategories = jsonDecode(getSubCategoriesResponse);
     });
   }

   Card categoryCard(double screenHeight, double screenWidth, String cardName, String imageName, int index){
     return  Card(
         color: Colors.white70,
         child: InkWell(
           onTap: () async =>{
            getSubCategories(index).whenComplete(
                () async{
                  if(subCategories != null){
                    print("you are in get subcategories");
                  print(subCategories["sub_categories"]);
                  Navigator.pushNamed(context,'/subcategories',
                  arguments: subCategories["sub_categories"]);
                  }

                }
            ),
           },
           child: Container(
             height: screenHeight/8,
             width: screenWidth/2,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: EdgeInsets.all(5.0),
                   child: Text("$cardName",
                     style:  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.normal),),
                 ),
                 Flexible(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Flexible(child:  Image.network("$imageName",
                           height: 80,width: 80, alignment: Alignment.bottomRight)),
                     ],
                   ),
                 )
               ],
             ),
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
   Container fourIconCardWidget(double screenHeight, double screenWidth, var arrayName, String widgetName){
    return Container(
        height: screenHeight/6,
        width: screenWidth,
        child:  Card(
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widgetName, style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),),
                      Text("View All", style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: 18),)
                    ],
                  ),
                ),
              ),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 2,
                  children: List.generate(4, (index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Image.asset('assets/${arrayName[index]["icon"]}.png',
                              fit: BoxFit.cover,
                        ),
                        ),
                        Expanded(
                          child: Text("${arrayName[index]["name"]}",
                            style: GoogleFonts.lato(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,

                          ),
                        )
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
        )
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: [
                categoryList.isNotEmpty ? Visibility(
                  visible: isappLoaded,
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
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(4,(index){
                              return  categoryCard(screenHeight, screenWidth,"${categoryList[index]["name"]}","${categoryList[index]["image_url"]}",categoryList[index]["id"]);
                            })
                        ),
                        SizedBox(height: 10),
                        Visibility(
                          visible: categoryList.length >
                              4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("View All", style: GoogleFonts.lato(fontSize: 18),),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        Carouselbanner(),
                        fourIconCardWidget(screenHeight, screenWidth,mostPopular,"Most Popular"),
                        fourIconCardWidget(screenHeight, screenWidth,topRated,"Top Technicians"),
                        GridView.count(
                          crossAxisCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childAspectRatio: 1,
                          children: [
                            businessCard(screenHeight, screenWidth, "PLANNING TO BOOST YOUR BUSINESS ?", Color(0xFF000080),"JOIN US"),
                            businessCard(screenHeight, screenWidth, "MISSING OUR PREMIUM SERVICES ?", Color(0xFF526faa),"SUBSCRIBE NOW")
                          ],
                        ),
                      ]
                  ),
                ) : Shimmer(
                    duration: const Duration(seconds: 3),
                    interval: const Duration(seconds: 5),
                    enabled: true,
                    color: Color(0xFF000080),
                    direction: const ShimmerDirection.fromLTRB(),
                    child: Container(
                      height: screenHeight,

                    )
                )
              ],
            )
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
