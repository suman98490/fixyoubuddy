import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Technicians extends StatefulWidget {
  const Technicians({super.key});

  @override
  State<Technicians> createState() => _TechniciansState();
}

class _TechniciansState extends State<Technicians> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("}",
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
        body: (true) ? Center(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Center(child: Text("No Technicials are available for the selected Sub category", style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF000080)),))
            ],
          ),
        ) :  SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(height: 5.0),
                    Container(
                      height: screenHeight/5,
                      width: screenWidth,
                      padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      child: Card(
                        color: Color(0xFF000080),
                      ),
                    ),
                    SizedBox(height: 10),
                    subCategorygrid(),

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
