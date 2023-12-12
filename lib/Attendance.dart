// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:arab_app/HomeScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

int? indexLocation;
bool? vl;
String data = "";
DateTime? chcekinTime;
DateTime? checkoutTime;
Position? checkoutLoction;
Position? checkinLocation;
bool isCheckinbuttonActive = true;
bool isCheckoutbuttonActive = false;
double pi = 3.1415926535897932;
String? Massege = ''; //location statuse
String? currentLocationName;

class _AttendanceState extends State<Attendance> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  List<dynamic> placeData = [
    {
      "id": '1234',
      "LocationName": 'company 1',
      "lat": 21.5578729,
      "lng": 39.7885081,
      "radius": 0.02
    },
    {
      "id": '1235',
      "LocationName": 'company 2',
      "lat": 21.5576717,
      "lng": 39.7882433,
      "radius": 0.02
    },
    {
      "id": '1236',
      "LocationName": 'company 3',
      "lat": 21.5576786,
      "lng": 39.7882422,
      "radius": 0.02
    },
    {
      "id": '1237',
      "LocationName": 'company 4',
      "lat": 21.5576477,
      "lng": 39.7881299,
      "radius": 0.02
    },
    {
      "id": '1239',
      "LocationName": 'company 5',
      "lat": 21.5576412,
      "lng": 39.7879485,
      "radius": 0.02
    },
  ];
  double DISTANCE = 0;
  ///////////
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontFamily: "Sans"),
      backgroundColor: const Color(0xFF4A7E4B), // background (button) color
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(20),
          ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تسجيل الحضور",
          style: TextStyle(
              fontFamily: 'Sans',
              fontSize: 25,
              color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A7E4B),
        leading: BackButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              DigitalClock(
                is24HourTimeFormat: false,
                showSecondsDigit: false,
                hourMinuteDigitTextStyle:
                    const TextStyle(fontFamily: 'Sans', fontSize: 80),
                secondDigitTextStyle:
                    const TextStyle(fontFamily: 'Sans', fontSize: 30),
              ),
              const SizedBox(
                height: 100,
                //width: 200,
              ),
              //button

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //child: Image.asset('asset/img_2.png'),
                onPressed: isCheckinbuttonActive
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Qrbuild(context),
                        ));
                      }
                    : null,
                child: const Text(
                  'الحضور',
                  style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 23,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),


              const SizedBox(
                height: 30,
                width: 200,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 60,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: SlideAction(
                    borderRadius: 20,
                    innerColor: const Color.fromARGB(255, 229, 89, 79),
                    outerColor: const Color.fromARGB(143, 191, 190, 199),
                    sliderButtonIcon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    text: "الخروج",
                    textStyle: const TextStyle(
                        //color: Color.fromARGB(185, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 23),
                    sliderRotate: false,
                    onSubmit: isCheckoutbuttonActive
                        ? () async {
                            _CheckoutconfirmationDailog();
                          }
                        : null,
                  ),
                ),
              ),
            ],
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

  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  Future<Position> determinePosition() async {
    requstp();
    requstp();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future requstp() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Widget Qrbuild(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )),
            Expanded(flex: 3, child: _buildQrView(context)),
            const Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xFF4A7E4B),
          borderRadius: 25,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        readQr(scanData);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p' as num);
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void readQr(e) async {
    requstp();
    if (e != null) {
      controller!.pauseCamera();
      controller!.dispose();
      data = e.code;
      indexLocation = checklocation(data);
      //currentLocationName = placeData[indexLocation!]['LocationName'];
//////////////////////////////////////////////////////////////
      if (indexLocation! >= 0) {
        checkinLocation = await determinePosition();
        DISTANCE = getDistanceFromLatLonInKm(
            placeData[indexLocation!]["lat"],
            placeData[indexLocation!]["lng"],
            checkinLocation?.latitude,
            checkinLocation?.longitude);
        vl = veriftLocation(DISTANCE, placeData[indexLocation!]["radius"]);
        print(vl);
        if (vl == true) {
          print(vl);
          chcekinTime = DateTime.now();
          setState(() => isCheckinbuttonActive = false);
          setState(() => isCheckoutbuttonActive = true);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Attendance()));
          print("---------------------------------------------------------");
          print(e!.code);
          print(indexLocation);
          print("yessssssssssssssssssssssssss");
          print(DISTANCE);
          print(Massege);
        } else {
          _UserOutLocationDialog();
        }
      } else {
        print('error');
        _ScanErrorDialog();
      }
    }
  }

  bool veriftLocation(distance, radius) {
    bool co = false;
    if (distance < radius) {
      Massege = 'in the location';
      co = true;
    } else {
      Massege = 'out the location';
      co = false;
    }
    return co;
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  int checklocation(String value) {
    for (var i = 0; i < placeData.length; i++) {
      if (value.compareTo(placeData[i]['id']) == 0) {
        //print(i);
        return i;
      }
    }
    return -1;
  }

  Future<void> _ScanErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خطأ',
              style: TextStyle(fontSize: 20, fontFamily: "Sans"),
              textAlign: TextAlign.end),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('مشكلة في قراءة الرمز',
                    style: TextStyle(fontSize: 16, fontFamily: "Sans"),
                    textAlign: TextAlign.end),
                Text('الرجاء المحاولة مره اخرى',
                    style: TextStyle(fontSize: 16, fontFamily: "Sans"),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('حسنا',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Attendance(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _CheckoutconfirmationDailog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تسجيل خروج',
              style: TextStyle(fontSize: 20, fontFamily: "Sans"),
              textAlign: TextAlign.end),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '   هل انت متاكد من تسجيل الخروج',
                  style: TextStyle(fontSize: 16, fontFamily: "Sans"),
                  textAlign: TextAlign.end,
                ),
                Text(
                  '   للتاكيد الرجاء الضفط على تاكيد',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Attendance()));
              },
              child: const Text('الغاء',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Sans",
                      fontWeight: FontWeight.w700,
                      color: Colors.red),
                  textAlign: TextAlign.end),
            ),
            TextButton(
              child: const Text('تاكيد',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end),
              onPressed: () async {
                checkoutLoction = await determinePosition();
                DISTANCE = getDistanceFromLatLonInKm(
                    placeData[indexLocation!]["lat"],
                    placeData[indexLocation!]["lng"],
                    checkoutLoction?.latitude,
                    checkoutLoction?.longitude);
                vl = veriftLocation(
                    DISTANCE, placeData[indexLocation!]["radius"]);
                if (vl == true) {
                  checkoutTime = DateTime.now();
                  print('checkout info.');
                  print(DISTANCE);
                  print(
                      "${checkoutTime?.hour}:${checkoutTime?.minute}:${checkoutTime?.second}");
                  print(indexLocation);
                  // data = '';
                  // vl = false;
                  // chcekinTime = null;
                  setState(() => isCheckinbuttonActive = true);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                } else {
                  _UserOutLocationDialog();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _UserOutLocationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خطأ',
              style: TextStyle(fontSize: 20, fontFamily: "Sans"),
              textAlign: TextAlign.end),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('المستخدم خارج الشركة  ',
                    style: TextStyle(fontSize: 16, fontFamily: "Sans"),
                    textAlign: TextAlign.end),
                Text(' الرجاء المحاولة مره اخرى',
                    style: TextStyle(fontSize: 16, fontFamily: "Sans"),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('حسنا',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Attendance(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Text(
//                   ' Data: $currentLocationName',
//                   style: const TextStyle(fontSize: 20, fontFamily: "Sans"),
//                 ),
//                 Text(
//                   "${chcekinTime?.hour}:${chcekinTime?.minute}:${chcekinTime?.second}",
//                   style: const TextStyle(fontSize: 20, fontFamily: "Sans"),
//                 ),
//                 Text(
//                   '$vl',
//                   style: const TextStyle(fontSize: 20, fontFamily: "Sans"),
//                 ),
//                 Text(
//                   '$Massege',
//                   style: const TextStyle(fontSize: 20, fontFamily: "Sans"),
//                 ),
