import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_test/sceen/menu.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

import 'menu_reported.dart';

class PeriodRound extends StatefulWidget {
  final int branchPermission;
  const PeriodRound({
    Key? key,
    required this.branchPermission,
  }) : super(key: key);

  @override
  _PeriodRoundState createState() => _PeriodRoundState();
}

class _PeriodRoundState extends State<PeriodRound> {
  final now = DateTime.now();
  @override
  List<dynamic> period_round = [];
  @override
  void initState() {
    super.initState();
    fetchPeriod();
  }

  Future<void> fetchPeriod() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json;charset=utf-8',
    };
    var client = http.Client();
    var url = Uri.http(Config.apiURL, Config.roundPeriod);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        period_round = items as List;
      });
    } else {
      period_round = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Periods',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Row(
          children: <Widget>[
            const SizedBox(
              width: 5.0,
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scanner(
                      brachID: widget.branchPermission,
                      dateTimeNow: now.toString(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(40, 59, 113, 1),
      ),
      body: fetchPeriodList(context),
    );
  }

  Widget fetchPeriodList(BuildContext context) {
    return ListView.builder(
      itemCount: period_round.length,
      itemBuilder: (context, index) {
        return get_Item_period(period_round[index]);
      },
    );
  }

  Widget get_Item_period(index) {
    var period_round = index['PeriodID'];
    var beginDate = index['BeginDate'];
    var endDate = index['EndDate'];
    var branchID = index['BranchID'];
    var description = index['Description'];
    DateTime dateBegin = DateTime.parse(beginDate);
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final String period_dateBegin = formatter.format(dateBegin);
    DateTime dateEnd = DateTime.parse(endDate);
    final DateFormat formatter2 = DateFormat('yyyy/MM/dd');
    final String period_dateEnd = formatter2.format(dateEnd);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        color: const Color.fromRGBO(40, 59, 113, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewDetails(
                    period_round: period_round,
                    beginDate: period_dateBegin,
                    endDate: period_dateEnd,
                    branchPermission: widget.branchPermission,
                  ),
                ),
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 280,
                      child: Text('$description',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 280,
                      child: Text('รอบที่บันทึก : รอบที่ $period_round',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    Text('เวลา : $period_dateBegin - $period_dateEnd',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.yellow)),
                    // const SizedBox(height: 8),
                    // Text('การเปิดให้บันทึกเฉพาะสาขา : ' + branchID.toString(),
                    //     style: const TextStyle(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.orangeAccent)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
