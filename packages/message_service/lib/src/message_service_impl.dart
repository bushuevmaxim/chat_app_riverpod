import 'package:api_client/api_client.dart';
import 'package:message_service/src/message_service.dart';

enum _MessageServiceEndpoints {
  message('generate');

  const _MessageServiceEndpoints(this.endpoint);
  final String endpoint;
}

final class MessageServiceImpl implements MessageService {
  final ApiClient _apiClient;

  MessageServiceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<String> send(String message) async {
    final response = await _apiClient.dio.post(
        _MessageServiceEndpoints.message.endpoint,
        queryParameters: {'message_from_user': message});
    final answer = response.data;
    return answer;
  }
}
