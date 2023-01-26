import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future dialogX(
  title,
  content,
  Color bgColor,
  Color txtColor
) {
  return Get.defaultDialog(
    title: title,
    backgroundColor: bgColor,
    titleStyle: TextStyle(color: txtColor),
    middleTextStyle: TextStyle(color: txtColor),
    cancelTextColor: Colors.white,
    confirmTextColor: txtColor,
    radius: 10,
    content: Text(
      content.toString(),
      style: TextStyle(
        color: txtColor,
      ),
    ),
  );
}


Future dialogProgress(
  title,
  content,
  Color bgColor,
  Color txtColor,
  Color progressColor
) {
  return Get.defaultDialog(
    title: title,
    //middleText: content,
    backgroundColor: bgColor,
    titleStyle: TextStyle(color: txtColor),
    middleTextStyle: TextStyle(color: txtColor),
    //textConfirm: "Confirm",
    //textCancel: "Cancel",
    cancelTextColor: Colors.white,
    confirmTextColor: Colors.white,
    buttonColor: Colors.red,
    barrierDismissible: false,
    radius: 10,
    content: Column(
      children: [
        CircularProgressIndicator(
          color: progressColor,
        ),
        Text(
          content.toString(),
          style: TextStyle(color: txtColor),
        )
      ],
    ),
  );
}

Future<bool?> dialogReturnTrueFalse(
  String title, 
  String content,
  Color bgColor,
  Color contentTxtColor,
  String yesTxt,
  String noTxt) 
  async {
    bool? state;
    await Get.defaultDialog(
      title: title,

      backgroundColor: bgColor,
      titleStyle: TextStyle(color: contentTxtColor),
      cancelTextColor: contentTxtColor,
      confirmTextColor: bgColor,
      buttonColor:  contentTxtColor,
      radius: 10,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            content,
            style: TextStyle(color: contentTxtColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () {
                  state = true;
                  Get.back();
                },
                backgroundColor: bgColor,
                child: Text(noTxt,
                style: TextStyle(
                  color: contentTxtColor
                ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  state = false;
                  Get.back();
                },
                backgroundColor: bgColor,
                child: Text(yesTxt,
                style: TextStyle(
                  color: contentTxtColor
                ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return state;
}