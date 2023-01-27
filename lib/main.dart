import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';

import 'globals/Globals.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> car = [
    'Nature',
    'Cars',
    'Dogs',
    'flowers',
    'Cats',
    'buildings',
  ];
  int _currentIndex = 0;
  int currentPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gallary",
        ),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChipList(
                  listOfChipNames: car,
                  activeBgColorList: [Colors.greenAccent],
                  inactiveBgColorList: [Colors.cyan],
                  activeTextColorList: [Colors.black87],
                  inactiveTextColorList: [Colors.black],
                  activeBorderColorList: [Colors.black],
                  listOfChipIndicesCurrentlySeclected: [_currentIndex],
                  extraOnToggle: (val) {
                    _currentIndex = val;
                    setState(() {
                      Images = allList[val];
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              initialPage: currentPage,
              onPageChanged: (val, _) {
                setState(() {
                  currentPage = val;
                });
                print(currentPage);
              },
              scrollDirection: Axis.horizontal,
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: false,
              autoPlayCurve: Curves.easeInOutBack,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.7,
            ),
            items: Images.map(
              (e) => Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("${e['image']}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ).toList(),
          ),
          SizedBox(height: 10),
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Images.map((e) {
                int i = Images.indexOf(e);
                return GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(
                      i,
                      duration: Duration(milliseconds: 800),
                    );
                  },
                  child: CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          (currentPage == i) ? Colors.black87 : Colors.white60),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
