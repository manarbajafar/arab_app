// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';

import 'HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:passwordfield/passwordfield.dart';

import 'otpScreen.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //---------
  String phoneController = "";
  bool showLoading = false;
  String verificationFailedMessage = "";
  //-------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF4A7E4B),
            title: const Text("تسجيل  الدخول "),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              fontSize: 22,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w500,
            )),
        body: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            :
            //  const MyStatefulWidget(),
            Directionality(
                //Make text right to left
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'مطوفي العرب',
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 35),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'مرحبًا بعودتك',
                              style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: BorderSide.strokeAlignOutside,
                                  color: Colors.black,
                                  fontSize: 25),
                            )),
                        IntlPhoneField(
                          decoration: const InputDecoration(
                            //labelText: 'رقم الهاتف',
                            labelStyle: TextStyle(
                              fontFamily: "Sans",
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal()),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          initialCountryCode: 'SA',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                            phoneController = phone.completeNumber;
                          },
                        ),
//                 PasswordField(
//                   errorMessage: '''
// - أحرف كبيرة
// - أحرف صغيرة
// - أرقام
// - رموز خاصة
// - يجب ان لا تقل كلمة المرور عن 8 خانات
//  ''',
//                   hintText: 'كلمة المرور ',
//                   passwordDecoration: PasswordDecoration(
//                       inputPadding: const EdgeInsets.symmetric(horizontal: 10),
//                       hintStyle: const TextStyle(fontFamily: "Sans"),
//                       errorStyle: const TextStyle(fontFamily: "Sans")),
//                   border: PasswordBorder(
//                     border: const OutlineInputBorder(
//                       borderSide:
//                           BorderSide(width: 0, color: Color(0xFF4A7E4B)),
//                     ),
//                   ),
//                 ),
                        const SizedBox(
                          height: 10,
                        ),
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     foregroundColor: Colors.black, // Background color
                        //   ),
                        //   onPressed: () {
                        //     //forgot password screen
                        //   },
                        //   child: const Text(
                        //     'نسيت كلمة السر؟',
                        //     style: TextStyle(fontSize: 15, fontFamily: 'Sans'),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 150,
                        // ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  showLoading = true;
                                });

                                //login with phone number
                                await login();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A7E4B),
                              ),
                              child: const Text('تسجيل الدخول',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Sans',
                                      color: Colors.white)),
                            )),
                        const SizedBox(
                          height: 100,
                        ),
                        Text(verificationFailedMessage),
                        const Spacer(),
                      ],
                    ))));
  }

  login() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          showLoading = false;
        });
        setState(() {
          verificationFailedMessage = e.message ?? "error!";
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        print("verificationId: ${verificationId}");
        setState(() {
          showLoading = false;
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                OTPScreen(isTimeOut2: false, verificationId: verificationId)));
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                OTPScreen(isTimeOut2: true, verificationId: verificationId)));
      },
    );

    // FirebaseAuth auth = FirebaseAuth.instance;

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: '+966558122218',
    //   verificationCompleted: (PhoneAuthCredential credential) {},
    //   verificationFailed: (FirebaseAuthException e) {
    //     if (e.code == 'invalid-phone-number') {
    //       print('The provided phone number is not valid.');
    //     }
    //   },
    //   codeSent: (String verificationId, int? resendToken) async {
    //     //1- go to otp screen with (verificationId)

    //     //2- Update the UI - wait for the user to enter the SMS code
    //     String smsCode = 'xxxx';

    //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //         verificationId: verificationId, smsCode: smsCode);

    //     await auth.signInWithCredential(credential);
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {},
    // );
  }
}
