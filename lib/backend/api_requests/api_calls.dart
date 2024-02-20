import 'dart:convert';
import 'dart:typed_data';
import '../cloud_functions/cloud_functions.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetImgCall {
  static Future<ApiCallResponse> call({
    String? token = 'r8_P7pjR0ulGCivFjJBWVBhH7ZoSd9fH9u2giyMw',
    String? prompt = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetImgCall',
        'variables': {
          'token': token,
          'prompt': prompt,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetPredictionCall {
  static Future<ApiCallResponse> call({
    String? token = 'r8_P7pjR0ulGCivFjJBWVBhH7ZoSd9fH9u2giyMw',
    String? prediction = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetPredictionCall',
        'variables': {
          'token': token,
          'prediction': prediction,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GeneratePassCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GeneratePass',
      apiUrl:
          'https://walletobjects.googleapis.com/walletobjects/v1/genericClass',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
