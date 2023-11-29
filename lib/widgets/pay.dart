import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../helper/req_helper.dart';

class PayWidget extends StatelessWidget {
  final String uri;
  final String url;
  final String api;
  final Function paid;
  final bool testMode;
  final Function unpaid;
  late WebViewController controller;
  PayWidget(
      {Key? key,
      required this.uri,
      required this.paid,
      required this.unpaid,
      required this.url,
      required this.api,
      required this.testMode})
      : super(key: key) {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xffffffff))
      ..loadRequest(Uri.parse(url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            )
            // _webview(context),
          ],
        ),
      ),
    );
  }
}
