import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflitecred/provider/update_provider.dart';

class ButtonWidget extends StatelessWidget {
  String title;
  Color color;
  final VoidCallback press;
  ButtonWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.press});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<UpdateProvider>(context, listen: true);
    return InkWell(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 55,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 1)
            ]),
        child: Align(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
