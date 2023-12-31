import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/view/calculator/quiz2_screen.dart';
import 'package:uroapplication/view/calculator/quiz_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class OABScreen extends StatefulWidget {
  @override
  State<OABScreen> createState() => _OABScreenState();
}

class _OABScreenState extends State<OABScreen> {
  bool isFinished = false;

  final userId = FirebaseAuth.instance.currentUser!.uid;
  int check = 0;
  String name = "loading....";
  String email = "loading....";
  String phone = 'loading....';

  void getInfo() async {
    var collection = FirebaseFirestore.instance.collection('Patients');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        email = data?["Email"];
        //phone = data?["Phone"];
      });
    }
    print(userId);
  }

  LinearGradient getProgressBarGradient(double percentage) {
    // Your gradient color logic here
    // Example:
    if (percentage <= 0.4) {
      return LinearGradient(colors: [Colors.green.shade900, Colors.green]);
    } else if (percentage < 0.7) {
      return LinearGradient(colors: [Colors.orange, Colors.yellow.shade300]);
    } else {
      return LinearGradient(colors: [Colors.orange.shade700, Colors.red]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final subheading = screenWidth * 0.06 * textScaleFactor;
    final heading = screenWidth * 0.08 * textScaleFactor;

    // Determine the text direction to set the alignment of the slide buttons
    //final isRTL = Directionality.of(context) == TextDirection.rtl;
    // final slideButtonAlignment =
    //     isRTL ? Alignment.centerRight : Alignment.centerLeft;

    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xff0047ba),
          toolbarHeight: screenHeight * 0.09,
          centerTitle: true,
          title: Image.asset(
            'assets/images/logo.png',
            height: 80,
            color: Colors.white,
          ),
          elevation: 0,
          leading: IconButton(
            icon:  Icon(CupertinoIcons.left_chevron),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor:  Color(0xff0047ba),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(
                                         AppLocalizations.of(context)!.healthTestQuickAssesment,
         textAlign: TextAlign.center,
                    style: TextStyle(fontSize: subheading, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: screenHeight / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Image(
                              height: screenHeight / 7,
                              width: screenWidth,
                              color: Colors.pink.shade300,
                              image:  AssetImage(
                                'assets/images/oab.png',
                              ),
                            ),
                            Text(                              AppLocalizations.of(context)!.oabDiag,

                              style: TextStyle(
                                  fontSize: heading,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.020,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  OAB()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  Color(0xff3d6bb4),
                            ),
                            child:  Text(                              AppLocalizations.of(context)!.takeoabQuiz,

                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                //quiz2
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: screenHeight / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Image(
                              height: screenHeight / 7,
                              width: screenWidth,
                              image:  AssetImage('assets/images/ipss.png'),
                            ),
                            Text(
                              "IPSS Diagnosis",
                              style: TextStyle(
                                  fontSize: heading,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.020,
                        ),
                        // Padding(
                        //   padding:  EdgeInsets.symmetric(horizontal: 20),
                        //   child: SwipeableButtonView(
                        //     buttonText: 'Start IPSS Diagnosis',
                        //     buttonWidget: Container(
                        //       child: Icon(
                        //         Icons.arrow_forward_ios_rounded,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //     activeColor: Colors.white.withOpacity(0.2),
                        //     isFinished: isFinished,
                        //     onWaitingProcess: () {
                        //       Future.delayed(Duration(seconds: 2), () {
                        //         setState(() {
                        //           isFinished = true;
                        //         });
                        //       });
                        //     },
                        //     onFinish: () async {
                        //       await Navigator.push(
                        //           context,
                        //           PageTransition(
                        //               type: PageTransitionType.fade, child: IPSS()));

                        //       setState(() {
                        //         isFinished = false;
                        //       });
                        //     },
                        //   ),
                        // )
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  IPSS()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  Color(0xff3d6bb4),
                            ),
                            child:  Text(
                                                            AppLocalizations.of(context)!.takeipssQuiz,

                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
