import 'package:chat_app/src/theme/app_strings.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/src/theme/app_colors.dart';

class InputField extends StatelessWidget {
  final void Function(String) onPressed;

  const InputField({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 8.0, top: 8, bottom: 8),
              child: TextField(
                controller: inputController,
                onSubmitted: (value) {
                  onPressed(value);
                  inputController.clear();
                },
                cursorColor: AppColors.secondaryColor,
                style: const TextStyle(
                    color: AppColors.secondaryColor, fontSize: 16),
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: AppColors.secondaryColor),
                    hintText: AppStrings.hint,
                    border: InputBorder.none),
              ),
            )),
            IconButton(
                onPressed: () {
                  onPressed(inputController.text);
                  inputController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: AppColors.secondaryColor,
                ))
          ],
        ));
  }
}
