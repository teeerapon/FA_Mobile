import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/hex_color.dart';

// ignore: must_be_immutable
class CheckCode extends StatefulWidget {
  final oCcy = NumberFormat("#,##0.00", "th");
  final String titleName;
  final String codeAssets;
  final int brachID;
  late String images;
  CheckCode({
    Key? key,
    required this.titleName,
    required this.codeAssets,
    required this.brachID,
    required this.images,
  }) : super(key: key);
  @override
  _CheckCodeState createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCode> {
  bool checkBox2 = false;
  bool checkBox = false;
  bool checkBox3 = false;
  var referenceController = TextEditingController();
  String referenceSetState1 = 'ชำรุดรอซ่อม';
  String referenceSetState2 = 'รอตัดชำรุด';
  String referenceSetState3 = '';
  var titleName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setState(() {
      titleName.text = widget.titleName;
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: Row(children: <Widget>[
          const SizedBox(
            width: 5.0,
          ),
          IconButton(
            color: Colors.black,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: HexColor('#283B71'),
      body: assetsReported(),
    );
  }

  Widget assetsReported() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/purethai.png",
                    width: 250,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 30, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  readOnly: true,
                  controller: titleName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Code :  ' + widget.codeAssets,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'สาขาที่อยู่ของทรัพย์สิน :  ' + widget.brachID.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: widget.images == 'null'
                      ? Image.asset(
                          "assets/images/ATT_220300020.png",
                          width: 250,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                      : Image.network(widget.images, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
