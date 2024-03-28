import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/giftHistoryModel.dart';
import 'package:atticadesign/Helper/myAccount.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/notifications.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GiftHistory extends StatefulWidget {
  final String userId;
  const GiftHistory({Key? key, required this.userId}) : super(key: key);

  @override
  State<GiftHistory> createState() => _GiftHistoryState();
}

class _GiftHistoryState extends State<GiftHistory> {
  List<GiftHistoryList> list = [];
  bool isLoading = true;
  getOrderList() async {
    setState(() {
      isLoading = true;
      list.clear();
    });
    GiftHistoryDetails giftDetails =
        await getGiftHistoryDetails(widget.userId, context);
    list.addAll(giftDetails.data ?? []);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOrderList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0C1723),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff0C1723),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/newbackss.png",
                height: 80,
              )),
          title: Text(
            "Gift History",
            style: TextStyle(
              color: Color(0xffF3F3F3),
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.shopping_cart_rounded, color: Color(0xffF1D459)),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotiPage()),
                        );
                      },
                      child: Icon(Icons.notifications_active,
                          color: Color(0xffF1D459))),
                ),
              ],
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: MyColorName.primaryDark,
                      ),
                    )
                  : list.length > 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              // leading: text(list[index].metalType ?? ''),
                              title: Text(
                                  '${list[index].donee ?? ''} (${list[index].metalType})'),
                              trailing: Text(
                                  "₹ ${list[index].amount ?? ''} (${list[index].gm} g)"),
                              subtitle: Text(list[index].createdAt.toString()),
                            );
                          },
                        )
                      : Center(
                          child: text("No Order Available"),
                        ),
            ],
          ),
        ));
  }
}
