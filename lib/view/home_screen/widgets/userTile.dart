import 'package:chit_chat/utils/constants/colorconstants.dart';
import 'package:flutter/material.dart';

class Usertile extends StatelessWidget {
  final String text;
  final void Function()? ontap;

  const Usertile({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: Colorconstants.primarycolor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(text,
                  style: TextStyle(
                      fontSize: 16, color: Colorconstants.blackcolor)),
            ],
          ),
        ));
  }
}
