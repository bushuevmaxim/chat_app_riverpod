import 'dart:developer';

import 'package:chat_app/main.dart';
import 'package:chat_app/src/features/chat/models/message.dart';
import 'package:chat_app/src/features/chat/view/widgets/input_field.dart';
import 'package:chat_app/src/features/chat/view/widgets/message.dart';
import 'package:chat_app/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageListProvider =
    NotifierProvider<MessageList, List<Message>>(MessageList.new);

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageList = ref.watch(messageListProvider);
    final messageService = ref.watch(messageServiceProvider);

    ref.listen<List<Message>>(messageListProvider, (previous, next) async {
      if (next[next.length - 1].isLocalUser) {
        log(next.length.toString());
        final answer = await messageService.send(next[next.length - 1].text);
        ref
            .read(messageListProvider.notifier)
            .add(Message(text: answer, isLocalUser: false));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat app'),
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: messageList[index].isLocalUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: MessageWidget(
                      key: ValueKey(index),
                      message: messageList[index],
                      isLastMessage: index == messageList.length - 1,
                    ),
                  );
                }),
          )),
          InputField(
            onPressed: (message) {
              if (message.isNotEmpty) {
                ref
                    .read(messageListProvider.notifier)
                    .add(Message(text: message, isLocalUser: true));
              }
            },
          ),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}
