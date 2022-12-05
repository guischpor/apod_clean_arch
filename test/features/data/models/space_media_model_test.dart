import 'dart:convert';

import 'package:apod/features/data/models/space_media_model.dart';
import 'package:apod/features/domain/entities/space_media_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/space_media_entity_mock.dart';

void main() {
  test('should be a subclass of SpaceMediaEntity', (() {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  }));

  test(
    'should return a valid model',
    () {
      final Map<String, dynamic> jsonMap = jsonDecode(spaceMediaMock);
      final result = SpaceMediaModel.fromJson(jsonMap);
      expect(result, tSpaceMediaModel);
    },
  );

  test(
    'should return a json map containing the proper data',
    () {
      final result = tSpaceMediaModel.toJson();
      expect(result, expectedMap);
    },
  );
}
