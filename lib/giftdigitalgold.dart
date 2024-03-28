import 'package:atticadesign/Helper/verifyUserModel.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/screen/giftHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Api/api.dart';
import 'Helper/myCart.dart';
import 'Helper/sellSilverModel.dart';
import 'Model/UserDetailsModel.dart';
import 'Utils/Common.dart';

class GiftDigitalGold extends StatefulWidget {
  String goldGrams;
  String silverGrams;
  GiftDigitalGold(
      {required this.goldGrams, required this.silverGrams, Key? key})
      : super(key: key);

  @override
  State<GiftDigitalGold> createState() => _GiftDigitalGoldState();
}

class _GiftDigitalGoldState extends State<GiftDigitalGold> {
  final choiceAmountController = TextEditingController();
  final choiceAmountControllerGram = TextEditingController();

  bool isBuyNow = true;
  String? isWallet;
  String? bankDetails;
  double resultGram = 0.0;
  double taotalPrice = 0.00;
  double goldenWallet = 0.00, totalBalance = 0.00;
  // silverGram = 62.00,
  // goldGram = 5246.96;

  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;
  double goldRate = 5362.96, silverRate = 62.00;
  TextStyle kTextStyle = TextStyle(fontSize: 14.0, color: Color(0xfffafcfb));
  double min = 0, max = 100;
  RangeValues rangeValues = RangeValues(0, 100);
  bool isUpi = true;
  bool isBank = true;
  TextEditingController acccountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController upiId = TextEditingController();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String receiverUserId = '';
  bool isVerifiedUser = false;
  bool isVerifiedLoading = false;
  @override
  void initState() {
    super.initState();
    goldRate = double.parse(App.localStorage.getString("goldPrice").toString());
    silverRate =
        double.parse(App.localStorage.getString("silverPrice").toString());
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double goldWallet = 0.00, silverWallet = 0.00;
  bool isGold = true;

  void getWallet() async {
    userDetailsModel =
        await userDetails(App.localStorage.getString("userId").toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].silverWallet != null &&
        userDetailsModel.data![0].silverWallet != "") {
      setState(() {
        print(userDetailsModel.data![0].silverWallet.toString());
        availebaleSilveGram =
            double.parse(userDetailsModel.data![0].silverWallet.toString());
        silverWallet =
            double.parse(userDetailsModel.data![0].silverWallet.toString()) *
                silverRate;
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].goldWallet != null &&
        userDetailsModel.data![0].goldWallet != "") {
      setState(() {
        print(userDetailsModel.data![0].goldWallet.toString());
        availeGoldgram =
            double.parse(userDetailsModel.data![0].goldWallet.toString());
        goldWallet =
            double.parse(userDetailsModel.data![0].goldWallet.toString()) *
                goldRate;
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].balance != null &&
        userDetailsModel.data![0].balance != "") {
      setState(() {
        print(userDetailsModel.data![0].balance.toString());
        totalBalance =
            double.parse(userDetailsModel.data![0].balance.toString());
      });
    }
  }

  gift() async {
    if (isVerifiedUser == false || mobileNumberController.text.length != 10) {
      Fluttertoast.showToast(msg: "Please verified user first!");
      return;
    } else {
      if (double.parse(resultGram.toStringAsFixed(4)) <= availeGoldgram ||
          double.parse(resultGram.toStringAsFixed(4)) <= availebaleSilveGram) {
        String value = await giftGold(context,
            userId: userDetailsModel.data![0].id ?? '',
            giftTo: receiverUserId,
            giftType: isGold ? "Gold" : "Silver",
            giftValue: choiceAmountControllerGram.value.text,
            giftAmount: choiceAmountController.value.text);
        Fluttertoast.showToast(msg: value);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Insufficient Balance!");
      }
    }
  }

  // void getWallet() async {
  //   userDetailsModel =
  //       await userDetails(App.localStorage.getString("userId").toString());
  //   if (userDetailsModel != null &&
  //       userDetailsModel.data![0].goldWallet != null) {
  //     setState(() {
  //       double balance =
  //           double.parse(userDetailsModel.data![0].goldWallet.toString());
  //       goldWallet = balance / goldRate;
  //     });
  //   }if( userDetailsModel != null &&userDetailsModel.data![0].silverWallet != null) {
  //     setState(() {
  //       double balance =
  //       double.parse(userDetailsModel.data![0].silverWallet.toString());
  //       silverWallet = balance / silverRate;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff0C1723),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 10,
            width: 10,
          ),
        ),
        title: Text(
          "Gift Digital ${isGold ? "Gold" : "Silver"} ",
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => MyCart()));
        //     },
        //     child: Image.asset(
        //       "assets/images/shop.png",
        //       height: 20,
        //       width: 20,
        //     ),
        //   ),
        //   SizedBox(
        //     width: 10,
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: Image.asset(
        //       "assets/images/well.png",
        //       height: 20,
        //       width: 20,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/homepage/vertical.png',
            ),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: isGold ? Colors.green : Colors.grey,
                            border: Border.all(
                                color: isGold ? Colors.green : Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0) //
                                    ),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isGold = !isGold;
                                choiceAmountControllerGram.clear();
                                choiceAmountController.clear();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/homepage/gold.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Gold',
                                    style: TextStyle(
                                      color: isGold
                                          ? Colors.white
                                          : Color(0xff0C1723),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 15),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: !isGold ? Colors.green : Colors.grey,
                            border: Border.all(
                                color: !isGold ? Colors.green : Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0) //
                                    ),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isGold = !isGold;
                                choiceAmountControllerGram.clear();
                                choiceAmountController.clear();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/homepage/silverbrick.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Silver',
                                    style: TextStyle(
                                      color: !isGold
                                          ? Colors.white
                                          : Color(0xff0C1723),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 210,
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xff0C1723),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/onboarding/sellDidital.png"),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 100.0, left: 20, top: 20),
                          child: Text(
                            'Start gifting \ndigital  ${isGold ? "gold" : "silver"}\nnow',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //             Row(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(left: 10.0),
                    //                   child: Text(
                    //                     '₹',
                    //                     style: TextStyle(
                    //                       color: Color(0xffF1D459),
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 10,
                    //                     ),
                    //                   ),
                    //                 ),
                    // //                 Row(
                    // //                   mainAxisAlignment: MainAxisAlignment.center,
                    // //                   children: [Text(
                    // //                     '${isGold ? goldRate : silverRate} /gm',
                    // //                     style: TextStyle(
                    // //                       color: Color(0xffF1D459),
                    // //                       fontWeight: FontWeight.bold,
                    // //                       fontSize: 10,
                    // //                     ),
                    // //                   ),
                    // // ]
                    // //                 )
                    //               ],
                    //             ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10.0),
                    //       child: Text(
                    //         'Current selling price',
                    //         style: TextStyle(
                    //           color: Color(0xffffffff),
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 10,
                    //         ),
                    //       ),
                    //     ),
                    //     Text(
                    //       ': ₹ ${isGold ? goldRate : silverRate} /gms',
                    //       style: TextStyle(
                    //         color: Color(0xffF1D459),
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 10,
                    //       ),
                    //     ),
                    //     // Padding(
                    //     //   padding: const EdgeInsets.only(left: 50),
                    //     //   child: Text(
                    //     //     'Price Valid For',
                    //     //     style: TextStyle(
                    //     //       color: Color(0xffffffff),
                    //     //       fontWeight: FontWeight.bold,
                    //     //       fontSize: 10,
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //     // Padding(
                    //     //   padding: const EdgeInsets.only(left: 5.0),
                    //     //   child: Text(
                    //     //     '02:44',
                    //     //     style: TextStyle(
                    //     //       color: Color(0xffF1D459),
                    //     //       fontWeight: FontWeight.bold,
                    //     //       fontSize: 10,
                    //     //     ),
                    //     //   ),
                    //     // )
                    //   ],
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120.0, top: 12.0),
                child: Text(
                  'How much you want to Gift?',
                  style: TextStyle(
                    color: Color(0xffF3F3F3),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 60,
                  // width: 340,
                  decoration: BoxDecoration(
                    color: Color(0xff0C1723),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Total Available Gram :',
                              style: TextStyle(
                                color: Color(0xffE2E2E2),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            '${isGold ? availeGoldgram.toStringAsFixed(4).toString() : availebaleSilveGram.toStringAsFixed(4).toString()} g',
                            style: TextStyle(
                              color: Color(0xffF1D459),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Total Available Rupees :',
                              style: TextStyle(
                                color: Color(0xffE2E2E2),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            '₹ ${isGold ? goldWallet.toStringAsFixed(2).toString() : silverWallet.toStringAsFixed(2).toString()} ',
                            style: TextStyle(
                              color: Color(0xffF1D459),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              

              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: choiceAmountController,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              var reate = isGold ? goldRate : silverRate;
                              resultGram = int.parse(value) / reate;
                              choiceAmountControllerGram.text =
                                  resultGram.toStringAsFixed(6).toString();
                            } else {
                              choiceAmountControllerGram.clear();
                            }
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,4}')),
                          ],
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "₹ Amount",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            labelText: '₹ Enter Amount',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Icon(Icons.compare_arrows,
                        color: Colors.white, size: 35),
                    width: 35,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: choiceAmountControllerGram,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            double a = isGold ? goldRate : silverRate;
                            taotalPrice = double.parse(value) * a;
                            resultGram = double.parse(value);

                            choiceAmountController.text =
                                taotalPrice.toStringAsFixed(2);
                          } else {
                            taotalPrice = 0.00;
                            choiceAmountController.clear();
                          }
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}')),
                        ],
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Gram",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Enter Gram',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: EdgeInsets.only(top: 10.0, left: 15.0),
              //           child: Container(
              //             height: 50,
              //             width: 150,
              //             decoration: BoxDecoration(
              //               color: isBank ? Colors.green : Colors.grey,
              //               border: Border.all(
              //                   color: isBank ? Colors.green : Colors.black12),
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(7.0) //
              //                       ),
              //             ),
              //             child: InkWell(
              //               onTap: () {
              //                 setState(() {
              //                   isBank = !isBank;
              //                 });
              //               },
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'Wallet',
              //                     style: TextStyle(
              //                       color: isBank
              //                           ? Colors.white
              //                           : Color(0xff0C1723),
              //                       fontSize: 15,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.only(top: 10.0, right: 15),
              //           child: Container(
              //             height: 50,
              //             width: 150,
              //             decoration: BoxDecoration(
              //               color: !isBank ? Colors.green : Colors.grey,
              //               border: Border.all(
              //                   color: !isBank ? Colors.green : Colors.black12),
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(7.0) //
              //                       ),
              //             ),
              //             child: InkWell(
              //               onTap: () {
              //                 setState(() {
              //                   isBank = !isBank;
              //                 });
              //               },
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'Bank Transfer',
              //                     style: TextStyle(
              //                       color: !isBank
              //                           ? Colors.white
              //                           : Color(0xff0C1723),
              //                       fontSize: 15,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // !isBank
              //     ? Column(
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.only(top: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Expanded(
              //                   child: Padding(
              //                     padding:
              //                         EdgeInsets.only(top: 10.0, left: 15.0),
              //                     child: Container(
              //                       height: 50,
              //                       width: 150,
              //                       decoration: BoxDecoration(
              //                         color: isUpi ? Colors.green : Colors.grey,
              //                         border: Border.all(
              //                             color: isUpi
              //                                 ? Colors.green
              //                                 : Colors.black12),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(7.0) //
              //                             ),
              //                       ),
              //                       child: InkWell(
              //                         onTap: () {
              //                           setState(() {
              //                             isUpi = !isUpi;
              //                           });
              //                         },
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             Text(
              //                               '@-UPI',
              //                               style: TextStyle(
              //                                 color: isUpi
              //                                     ? Colors.white
              //                                     : Color(0xff0C1723),
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.bold,
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(
              //                         top: 10.0, right: 15),
              //                     child: Container(
              //                       height: 50,
              //                       width: 150,
              //                       decoration: BoxDecoration(
              //                         color:
              //                             !isUpi ? Colors.green : Colors.grey,
              //                         border: Border.all(
              //                             color: !isUpi
              //                                 ? Colors.green
              //                                 : Colors.black12),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(7.0) //
              //                             ),
              //                       ),
              //                       child: InkWell(
              //                         onTap: () {
              //                           setState(() {
              //                             isUpi = !isUpi;
              //                           });
              //                         },
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             Text(
              //                               'Bank Details',
              //                               style: TextStyle(
              //                                 color: !isUpi
              //                                     ? Colors.white
              //                                     : Color(0xff0C1723),
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.bold,
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           if (isUpi)
              //             Container(
              //               margin: EdgeInsets.all(15),
              //               child: TextFormField(
              //                 controller: upiId,
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                   color: Colors.blue,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 keyboardType: TextInputType.text,
              //                 decoration: InputDecoration(
              //                   focusColor: Colors.white,
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   focusedBorder: OutlineInputBorder(
              //                     borderSide: const BorderSide(
              //                         color: Colors.blue, width: 1.0),
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   fillColor: Colors.grey,
              //                   hintText: "Enter UPI ID",
              //                   hintStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                   labelText: 'Enter UPI ID',
              //                   labelStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           if (!isUpi)
              //             Container(
              //               margin: EdgeInsets.all(15),
              //               child: TextFormField(
              //                 controller: bankName,
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                   color: Colors.blue,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 keyboardType: TextInputType.text,
              //                 decoration: InputDecoration(
              //                   focusColor: Colors.white,
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   focusedBorder: OutlineInputBorder(
              //                     borderSide: const BorderSide(
              //                         color: Colors.blue, width: 1.0),
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   fillColor: Colors.grey,
              //                   hintText: "Enter Bank Name",
              //                   hintStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                   labelText: 'Enter Bank Name',
              //                   labelStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           if (!isUpi)
              //             Container(
              //               margin: EdgeInsets.all(15),
              //               child: TextFormField(
              //                 controller: acccountNumber,
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                   color: Colors.blue,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 keyboardType: TextInputType.number,
              //                 decoration: InputDecoration(
              //                   focusColor: Colors.white,
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   focusedBorder: OutlineInputBorder(
              //                     borderSide: const BorderSide(
              //                         color: Colors.blue, width: 1.0),
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   fillColor: Colors.grey,
              //                   hintText: "Enter Account Number",
              //                   hintStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                   labelText: 'Enter Account Number',
              //                   labelStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           if (!isUpi)
              //             Container(
              //               margin: EdgeInsets.all(15),
              //               child: TextFormField(
              //                 controller: accountHolderName,
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                   color: Colors.blue,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 keyboardType: TextInputType.text,
              //                 decoration: InputDecoration(
              //                   focusColor: Colors.white,
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   focusedBorder: OutlineInputBorder(
              //                     borderSide: const BorderSide(
              //                         color: Colors.blue, width: 1.0),
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   fillColor: Colors.grey,
              //                   hintText: "Enter Holder Name",
              //                   hintStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                   labelText: 'Enter Holder Name',
              //                   labelStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           if (!isUpi)
              //             Container(
              //               margin: EdgeInsets.all(15),
              //               child: TextFormField(
              //                 controller: ifscCode,
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                   color: Colors.blue,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 keyboardType: TextInputType.text,
              //                 decoration: InputDecoration(
              //                   focusColor: Colors.white,
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   focusedBorder: OutlineInputBorder(
              //                     borderSide: const BorderSide(
              //                         color: Colors.blue, width: 1.0),
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ),
              //                   fillColor: Colors.grey,
              //                   hintText: "Enter IFSC Code",
              //                   hintStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                   labelText: "Enter IFSC Code",
              //                   labelStyle: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //         ],
              //       )
              //     : SizedBox.shrink(),
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                height: 15,
              ),

              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  controller: mobileNumberController,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    counter: Container(),
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Enter Mobile Number",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'Enter Mobile Number',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isVerifiedLoading = true;
                  });
                  if (mobileNumberController.text.length == 10) {
                    VerifyUserDetails verifyUserDetails =
                        await verifyUserToGiftGold(
                            mobileNumberController.text, context);
                    if (verifyUserDetails.message == 'User Get Sucessfully !' &&
                        verifyUserDetails.data != null) {
                      receiverUserId = verifyUserDetails.data!.id ?? '';
                      userNameController.text =
                          verifyUserDetails.data!.username ?? '';
                      isVerifiedUser = true;
                      Fluttertoast.showToast(
                          msg: verifyUserDetails.message ?? '');
                    } else {
                      Fluttertoast.showToast(
                          msg: verifyUserDetails.message ?? '');
                      isVerifiedUser = false;
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please enter Valid Mobile Number");
                  }
                  setState(() {
                    isVerifiedLoading = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gradient: LinearGradient(colors: [
                            Color(0xffF1D459),
                            Color(0xffB27E29),
                          ])),
                      child: Center(
                        child: isVerifiedLoading == true
                            ? CircularProgressIndicator()
                            : Text(
                                'Verify User',
                                style: TextStyle(
                                  color: Color(0xff0C1723),
                                  fontSize: 18,
                                ),
                              ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  controller: userNameController,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "User Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'User Name',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (isVerifiedUser)
                GestureDetector(
                  onTap: () async {
                    gift();
                    Future.delayed(Duration(seconds: 3), () {
                      getWallet();
                    });
                    //if (isBuyNow) {
                    //   setState(() {
                    //     isBuyNow = false;
                    //   });
                  },
                  child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gradient: LinearGradient(colors: [
                            Color(0xffF1D459),
                            Color(0xffB27E29),
                          ])),
                      child: Center(
                        child: Text(
                          'Gift NOW ₹ ${choiceAmountController.text.toString()}',
                          style: TextStyle(
                            color: Color(0xff0C1723),
                            fontSize: 18,
                          ),
                        ),
                      )),
                ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffF1D459),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GiftHistory(
                          userId: userDetailsModel.data![0].id ?? '',
                        )));
          },
          child: Center(
            child: Text(
              'Gift History',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          )),
    );
  }
}
