library dev_storage_package;

import 'dart:async';
import 'dart:developer';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionCheckerDev extends GetxController {
  Function() disconnecetFunction;
  Function()? connectedBackFunction;

  InternetConnectionCheckerDev(
      this.disconnecetFunction, this.connectedBackFunction);

  late StreamSubscription<InternetConnectionStatus> _connectivitySubscription;

  late bool isConnected;

  int flag = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _connectivitySubscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus result) async {
      log('\x1B[32m${result.toString()}\x1B[0m');

      switch (result) {
        case InternetConnectionStatus.connected:
          {
            // final result = await InternetAddress.lookup('example.com');
            // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            changeConnectionStatus(true);
            update();

            // } on SocketException catch (_) {
            //  changeConnectionStatus(false);
            //    log('\x1B[32m Not Connected \x1B[0m');
            //    disconnecetFunction();
            // }

            break;
          }

        case InternetConnectionStatus.disconnected:
          {
            changeConnectionStatus(false);
            log('\x1B[32m Not Connected \x1B[0m');
            if (flag > 1) {
              disconnecetFunction();
            }

            break;
          }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }

  changeConnectionStatus(boolX) {
    if (boolX == true && flag > 0) {
      if (connectedBackFunction != null) {
        connectedBackFunction!();
      }
    }

    isConnected = boolX;
    flag++;
  }
}
