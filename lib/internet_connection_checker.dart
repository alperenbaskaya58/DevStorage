library dev_storage_package;

import 'dart:async';
import 'dart:developer';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionCheckerDev extends GetxController {
  Function() disconnecetFunction;
  Function()? connectedBackFunction;

  InternetConnectionCheckerDev(
      this.disconnecetFunction, this.connectedBackFunction);

  late StreamSubscription<InternetStatus> _connectivitySubscription;

  late bool isConnected;

  int flag = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _connectivitySubscription = InternetConnection.createInstance(
      useDefaultOptions: false,
      customCheckOptions: [
        // Google DNS IP'si (ping testi için hızlı ve güvenilir)

        InternetCheckOption(
          uri: Uri.parse(
            'https://8.8.8.8',
          ), // Doğrudan IP, DNS çözümlemesi olmadan
          timeout: const Duration(seconds: 3),
        ),
        InternetCheckOption(
          uri: Uri.parse(
            'https://connectivitycheck.gstatic.com/generate_204',
          ), // Doğrudan IP, DNS çözümlemesi olmadan
          timeout: const Duration(seconds: 2),
        ),

        InternetCheckOption(
          uri: Uri.parse(
            'https://www.apple.com/library/test/success.html',
          ), // Doğrudan IP, DNS çözümlemesi olmadan
          timeout: const Duration(seconds: 2),
        ),

        InternetCheckOption(
          uri: Uri.parse(
            "https://www.microsoft.com/robots.txt",
          ), // Doğrudan IP, DNS çözümlemesi olmadan
          timeout: const Duration(seconds: 2),
        ),

        InternetCheckOption(
          uri: Uri.parse(
            'https://dns.cloudflare.com/',
          ), // Doğrudan IP, DNS çözümlemesi olmadan
          timeout: const Duration(seconds: 2),
        ),

        // Cloudflare DNS IP'si
        InternetCheckOption(
          uri: Uri.parse('https://1.1.1.1'),
          timeout: const Duration(seconds: 3),
        ),
        // Google'ın web sitesi (HTTP/HTTPS testi için)
        InternetCheckOption(
          uri: Uri.parse('https://www.google.com'),
          timeout: const Duration(
            seconds: 5,
          ), // Web sitesi yanıtı biraz daha uzun sürebilir
        ),
      ],
    ).onStatusChange.listen((InternetStatus result) async {
      log('\x1B[32m${result.toString()}\x1B[0m');

      switch (result) {
        case InternetStatus.connected:
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

        case InternetStatus.disconnected:
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

        // case InternetStatus.:
        //   {
        //     changeConnectionStatus(false);
        //     log('\x1B[32m Not Connected \x1B[0m');
        //     if (flag > 1) {
        //       disconnecetFunction();
        //     }

        //     break;
        //   }
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
