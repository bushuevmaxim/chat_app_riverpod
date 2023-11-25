import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/src/features/chat/models/message.dart';
import 'package:chat_app/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isLastMessage;
  const MessageWidget(
      {super.key, required this.message, required this.isLastMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: message.isLocalUser
            ? const EdgeInsets.only(left: 40)
            : const EdgeInsets.only(right: 40),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryColor, width: 1),
            color: message.isLocalUser
                ? AppColors.secondaryColor
                : AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12)),
        child: isLastMessage && !message.isLocalUser
            ? DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 22, color: AppColors.secondaryColor),
                child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    totalRepeatCount: 1,
                    animatedTexts: [TyperAnimatedText(message.text)]))
            : Text(
                message.text,
                style: TextStyle(
                    fontSize: 22,
                    color: message.isLocalUser
                        ? AppColors.backgroundColor
                        : AppColors.secondaryColor),
              ));
  }
}
