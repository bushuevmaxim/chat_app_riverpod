import 'package:api_client/api_client.dart';
import 'package:chat_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:message_service/message_service.dart';

final _baseUrlProvider = Provider((ref) => dotenv.env['BASE_URL']!);

final _apiClientProvider = Provider((ref) {
  final baseUrl = ref.watch(_baseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
});

final messageServiceProvider = Provider((ref) {
  final apiClient = ref.watch(_apiClientProvider);
  return MessageServiceImpl(apiClient: apiClient);
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  runApp(const ProviderScope(child: ChatApp()));
}
