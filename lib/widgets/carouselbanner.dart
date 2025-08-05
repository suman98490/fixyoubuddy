import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Carouselbanner extends StatefulWidget {
  const Carouselbanner({super.key});

  @override
  State<Carouselbanner> createState() => _CarouselbannerState();
}

class _CarouselbannerState extends State<Carouselbanner> {


  Container carouselBanner(double screenwidth, Color colorName, String bannerHeading, String bannerContent){
    return Container(
      width: screenwidth,
      child: Card(
        color: colorName,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(bannerHeading,
                style: GoogleFonts.lexend(fontSize: 18,fontWeight: FontWeight.normal, color: Colors.white),textAlign: TextAlign.center,),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Text(bannerContent,
                style: GoogleFonts.lexend(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Text("Tap here to Know more",
                style: GoogleFonts.lexend(fontSize: 15,fontWeight: FontWeight.normal, color: Colors.white70),),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeiht = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CarouselSlider(
          items: [
            carouselBanner(screenwidth,Color(0xFF000080),"FLAT 50% OFF","@CHENNAI MGR MALL"),
            carouselBanner(screenwidth, Color(0xff7B2CC9),"AMAZING OFFERS","@MORE RAYACHOTY")
          ],
            options: CarouselOptions(
              height: screenHeiht/5,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              viewportFraction: 1,
              enableInfiniteScroll: true,
              enlargeCenterPage: false,
              padEnds: true
            ),
        )
      ],
    );
  }
}
