import 'package:flutter/material.dart';
import 'package:mlingo/configs.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool border;
  final void Function()? onTap;
  final Decoration? decoration;
  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    this.border = false,
    this.onTap,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          constraints: const BoxConstraints(minHeight: 30),
          decoration: decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColor.blueGrey, size: 22),
              const SizedBox(width: 9),
              Text(label, style: Theme.of(context).textTheme.buttonText),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonFilled extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool border;
  final Color fillColor;
  final void Function()? onTap;
  const CustomButtonFilled({
    super.key,
    required this.icon,
    required this.label,
    this.border = false,
    this.onTap,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          constraints: const BoxConstraints(minHeight: 30),
          decoration: BoxDecoration(
              color: fillColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColor.white, size: 22),
              const SizedBox(width: 9),
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .buttonText
                      .copyWith(color: AppColor.white)),
            ],
          ),
        ),
      ),
    );
  }
}
