// ignore_for_file: file_names

//import 'dart:html';
import 'package:arab_app/Attendance.dart';
import 'package:arab_app/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, fontFamily: "Sans"),
    backgroundColor: const Color(0xFF4A7E4B), // background (button) color
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  );
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الرئيسية",
          style: TextStyle(
              fontFamily: 'Sans',
              fontSize: 25,
              color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF4A7E4B),
        leading: BackButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const login())),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: screenWidth,
                  height: 200, // specify height
                  child: Container(
                    color: Colors.green[100],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //height: 150,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          //child: Image.asset('asset/img_2.png'),
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset('asset/img_2.png',
                                  height: 50, width: 50),
                              const Text(
                                'المساهمين',
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset('asset/img.png',
                                  height: 50, width: 50),
                              const Text(
                                'الموظفين',
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //height: 150,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          //child: Image.asset('asset/img_2.png'),
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset('asset/img_1.png',
                                  height: 50, width: 50),
                              const Text(
                                'الأداء',
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset('asset/img_3.png',
                                  height: 50, width: 50),
                              const Text(
                                'نظام الحج',
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //height: 150,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          //child: Image.asset('asset/img_2.png'),
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Attendance()));
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('asset/img_5.png',
                                  height: 50, width: 50),
                              const Text(
                                'الحضور',
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          //temp
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Image.asset('asset/img_4.png',
                                    height: 50, width: 50),
                                const Text(
                                  'البطاقة الإلكترونية',
                                  style: TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 30,
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.more),
              onPressed: () {},
            ),
            const SizedBox(width: 80),
            IconButton(
              iconSize: 30,
              tooltip: 'Search',
              icon: const Icon(Icons.home),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
            const SizedBox(width: 80),
            IconButton(
              iconSize: 30,
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.message),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
