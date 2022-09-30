import 'dart:convert';

OpenAIData openAIDataFromJson(String str) =>
    OpenAIData.fromJson(json.decode(str));

String openAIDataToJson(OpenAIData data) => json.encode(data.toJson());

class OpenAIData {
  OpenAIData({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  String id;
  String object;
  int created;
  String model;
  List<Choices> choices;
  Usage usage;

  factory OpenAIData.fromJson(Map<String, dynamic> json) => OpenAIData(
      id: json["id"],
      object: json["object"],
      created: json["created"],
      model: json["model"],
      choices:
          List<Choices>.from(json["choices"].map((e) => Choices.fromJson(e))),
      usage: Usage.fromJson(json["usage"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": List<dynamic>.from(choices.map((e) => toJson()))
      };
}

class Choices {
  Choices({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  String text;
  int index;
  dynamic logprobs;
  String finishReason;

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        text: json["text"],
        index: json["index"],
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "index": index,
        "logprobs": logprobs,
        "finish_reason": finishReason,
      };
}

class Usage {
  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  int promptTokens;
  int completionTokens;
  int totalTokens;

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
      promptTokens: json["prompt_tokens"],
      completionTokens: json["completion_tokens"],
      totalTokens: json["total_tokens"]);

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
