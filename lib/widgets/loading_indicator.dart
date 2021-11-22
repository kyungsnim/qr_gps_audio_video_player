import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

loadingIndicator() {
  return Center(
    child: Container(
      width: Get.width * 0.08,
      height: Get.width * 0.08,
      child: const LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [Colors.black],
      ),
    ),
  );
}