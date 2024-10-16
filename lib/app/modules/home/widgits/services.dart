import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../routes/app_routes.dart';
import '../../service/service_page.dart';
import 'header.dart';

class serviceswidgit extends StatefulWidget {
  const serviceswidgit({super.key});

  @override
  State<serviceswidgit> createState() => _serviceswidgitState();
}

class _serviceswidgitState extends State<serviceswidgit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Header(text: "Services", ),
          SizedBox(height: 12,),
          Row(
            children: [
              ServicesType(
                text: "Car Wash",
                borderSides: [BorderSideEnum.bottom, BorderSideEnum.right],
                imagePath: 'assets/services/car wash.png',
                onTap: () => navigateToServicePage("Car Wash"),
              ),
              ServicesType(
                text: "Detailing",
                borderSides: [BorderSideEnum.right, BorderSideEnum.bottom],
                imagePath: 'assets/services/detailing.png',
                onTap: () => navigateToServicePage("Detailing"),
              ),
              ServicesType(
                text: "Denting and Painting",
                borderSides: [BorderSideEnum.bottom, BorderSideEnum.right],
                imagePath: 'assets/services/painting.png',
                onTap: () => navigateToServicePage("Denting and Painting"),
              ),
              ServicesType(
                text: "Repairing",
                borderSides: [BorderSideEnum.bottom],
                imagePath: 'assets/services/repair.png',
                onTap: () => navigateToServicePage("Repairing"),
              ),
            ],
          ),
          Row(
            children: [
              ServicesType(
                text: "Accessories",
                borderSides: [BorderSideEnum.right],
                imagePath: 'assets/services/accessories.png',
                onTap: () => navigateToServicePage("Accessories"),
              ),
              ServicesType(
                text: "Wheel Service",
                borderSides: [BorderSideEnum.right],
                imagePath: 'assets/services/wheelservice.png',
                onTap: () => navigateToServicePage("Wheel Service"),
              ),
              ServicesType(
                text: "Body Parts",
                borderSides: [BorderSideEnum.right],
                imagePath: 'assets/services/body parts.png',
                onTap: () => navigateToServicePage("Body Parts"),
              ),
              ServicesType(
                text: "General Service",
                borderSides: [],
                imagePath: 'assets/services/general service.png',
                onTap: () => navigateToServicePage("General Service"),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void navigateToServicePage(String service) {
    Get.toNamed(AppRoutes.SERVICE, arguments: service);
  }
}


class ServicesType extends StatelessWidget {
  final String text;
  final List<BorderSideEnum> borderSides;
  final Color borderColor;
  final double borderWidth;
  final String imagePath;
  final VoidCallback onTap;


  const ServicesType({
    Key? key,
    required this.text,
    this.borderSides = const [], // Default to no borders
    this.borderColor = const Color(0xffE7E7E7),
    this.borderWidth = 1.0,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.width / 4 - 10,
        width: MediaQuery.of(context).size.width / 4 - 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: _createBorder(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Text(text,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  Border _createBorder() {
    return Border(
      top: borderSides.contains(BorderSideEnum.top)
          ? BorderSide(color: borderColor, width: borderWidth)
          : BorderSide.none,
      bottom: borderSides.contains(BorderSideEnum.bottom)
          ? BorderSide(color: borderColor, width: borderWidth)
          : BorderSide.none,
      left: borderSides.contains(BorderSideEnum.left)
          ? BorderSide(color: borderColor, width: borderWidth)
          : BorderSide.none,
      right: borderSides.contains(BorderSideEnum.right)
          ? BorderSide(color: borderColor, width: borderWidth)
          : BorderSide.none,
    );
  }
}

enum BorderSideEnum {
  top,
  bottom,
  left,
  right,
}
