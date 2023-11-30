import 'package:chat_app/main.dart';
import 'package:chat_app/src/theme/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:message_service/message_service.dart';

final class Message {
  final String text;
  final bool isLocalUser;

  Message({required this.text, required this.isLocalUser});
}

List<Message> messages = <Message>[
  Message(text: AppStrings.greet, isLocalUser: false),
];

final class MessageList extends Notifier<List<Message>> {
  @override
  List<Message> build() {
    return messages;
  }

  void add(Message message) {
    state = [...state, message];
  }

  void send(Message message) {
    try {
      final MessageService messageService = ref.watch(messageServiceProvider);
      messageService.send(message.text);
    } catch (e) {}
  }
}
