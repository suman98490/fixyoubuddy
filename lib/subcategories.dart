import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({super.key});

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  var subCategories;
  var subCategories1 = [{"name" : "Electrician", "image_url" : ""},
    {"name" : "Plumber", "image_url" : ""},
    {"name" : "Carpenter", "image_url" : ""},
    {"name" : "Painter", "image_url" : ""},
    {"name" : "Painter", "image_url" : ""},
    {"name" : "Wi-Fi Services", "image_url" : ""},
    {"name" : "TV Installation", "image_url" : ""}
  ] ;

  void initState(){
    super.initState();
    getSubCategories();
  }

  Future getSubCategories() async{
    final getSubCategories = await get(Uri.parse("https://fixubuddy-api-978338023784.asia-south1.run.app/categories/1")) ;
    final getSubCategoriesResponse = getSubCategories.body;
    print(getSubCategoriesResponse);

  }

  @override
  Widget build(BuildContext context) {
    subCategories = ModalRoute.of(context)!.settings.arguments;
    print("you are inside sub");
    print(subCategories);

    Container subCategorygrid(){
      return Container(
        child: GridView.count(
          childAspectRatio: 1,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(subCategories.length, (index){
            return Column(
              children: [
                Expanded(child: Image.network(subCategories[index]["image_url"])),
                SizedBox(height: 5.0),
                Expanded(child:  Text("${subCategories[index]["name"]}",
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),),)
              ],
            );
          }),

        ),
      );
    }
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Sub Categories",
          style: GoogleFonts.lato(fontSize: 20, color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
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
        body: (subCategories == null || subCategories.isEmpty) ? Center(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Text("No Sub Categories are available for the selected category", style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF000080)),)
            ],
          ),
        ) :  SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height: 10,),
                subCategorygrid()
              ]
          ),
        )
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
    );;
  }
}
