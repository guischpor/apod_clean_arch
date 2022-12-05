import 'package:apod/core/errors/exceptions.dart';
import 'package:apod/core/errors/failures.dart';
import 'package:apod/features/data/datasources/i_space_media_datasource.dart';
import 'package:apod/features/data/repositories/space_media_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockISpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockISpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
    registerFallbackValue(DateTime(2000));
  });

  test(
    'should return soace media model when calls the datasource',
    () async {
      //Arrange
      when(() => datasource.getSpaceMediaFromDate(any()))
          .thenAnswer((_) async => tSpaceMediaModel);
      //Act
      final result = await repository.getSpaceMediaFromDate(tDate);

      //Assert
      expect(result, const Right(tSpaceMediaModel));
      verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
    },
  );

  test(
    'should return a server failure when the call to datasource is unsucessful',
    () async {
      when(() => datasource.getSpaceMediaFromDate(any()))
          .thenThrow(ServerException());

      final result = await repository.getSpaceMediaFromDate(tDate);

      expect(result, Left(ServerFailure()));
      verify((() => datasource.getSpaceMediaFromDate(tDate))).called(1);
    },
  );
}
