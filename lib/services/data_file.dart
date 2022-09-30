import 'package:http/http.dart' as http;
import 'package:bot/services/mapping_file.dart';

Future<OpenAIData> getDataFromOpenAPI(String text) async {
  final Uri apiURL = Uri.parse("https://api.openai.com/v1/completions");
  final header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer <YOUR API KEY>"
  };
  String body =
      '{"model": "text-davinci-002", "prompt": "{$text}", "temperature": 0.7, "max_tokens": 1000}';
  final response = await http.post(apiURL, headers: header, body: body);
  return openAIDataFromJson(response.body);
}
