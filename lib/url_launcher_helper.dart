import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

enum LinkType { mail, telephone, sms, whatsapp, link }

class UrlLauncherX {
  launchUrlX(LinkType linkType, String link) async {
    switch (linkType) {
      case LinkType.link:
        final bool nativeAppLaunchSucceeded = await launch(
          link,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
        if (!nativeAppLaunchSucceeded) {
          await launch(
            link,
            forceSafariVC: true,
          );
        }
        /* if (await canLaunch(link)) {
          await launch(link,
              forceSafariVC: false,
              universalLinksOnly: true,
              forceWebView: false);
          print("3");
        }*/

        break;

      case LinkType.whatsapp:
        var whatsappURl_android =
            "whatsapp://send?phone=" + link + "&text=Bishy";
        var whatappURL_ios = "https://wa.me/$link?text=""}";
        if (Platform.isIOS) {
          if (await canLaunch(whatappURL_ios)) {
            await launch(whatappURL_ios, forceSafariVC: false);
          }
        } else {
          if (await canLaunch(whatsappURl_android)) {
            await launch(whatsappURl_android);
          }
        }

        break;

      case LinkType.sms:
        await launch("sms://$link");
        break;

      case LinkType.telephone:
        Uri a = Uri(
          scheme: 'tel',
          path: link,
          //queryParameters: {'subject': 'Bishy App'}
        );
        await launch(a.toString());
        break;

      case LinkType.mail:
        await launch("mailto:$link");
        break;

      default:
        break;
    }
  }
}