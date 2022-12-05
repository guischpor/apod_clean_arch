import 'package:apod/core/errors/exceptions.dart';
import 'package:apod/core/utils/date_input_converter.dart';
import 'package:apod/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockDateInputConverter extends Mock implements DateInputConverter {}

class MockClient extends Mock implements http.Client {}

void main() {
  late SpaceMediaDatasouceImplementation datasource;
  late DateInputConverter converter;
  late http.Client client;

  setUp(() {
    converter = MockDateInputConverter();
    client = MockClient();
    datasource = SpaceMediaDatasouceImplementation(
      converter: converter,
      client: client,
    );
  });

  registerFallbackValue(DateTime(2000));
  registerFallbackValue(Uri());

  void successMock() {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
  }

  test('should call DateInputConverter to convert the DateTime into a String',
      (() async {
    successMock();
    await datasource.getSpaceMediaFromDate(tDateTime);
    verify(() => converter.format(tDateTime)).called(1);
  }));

  test('should call the get method with correct url', () async {
    successMock();
    await datasource.getSpaceMediaFromDate(tDateTime);
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'OSfBFnJDoH0uIkav0j9rpxegwioun3W3eGh3uP0d',
          'date': '2021-02-02'
        }))).called(1);
  });

  test(
    'should return a SpaceMediaModel when the call is successful',
    () async {
      successMock();
      final result = await datasource.getSpaceMediaFromDate(tDateTime);
      expect(result, tSpaceMediaModel);
      verify((() => converter.format(tDateTime))).called(1);
    },
  );

  test('should throw a ServerException when the call is unccessful', () async {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('something went wrong', 400));
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    expect(result, throwsA(ServerException()));
    verify(() => converter.format(tDateTime)).called(1);
  });
}
