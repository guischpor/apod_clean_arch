import 'package:apod/core/errors/failures.dart';
import 'package:apod/features/domain/entities/space_media_entity.dart';
import 'package:apod/features/domain/repositories/space_media_repository.dart';
import 'package:apod/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
    registerFallbackValue(DateTime(2000));
  });

  test('should get space media entity for a given date from the repository ',
      () async {
    when(() => repository.getSpaceMediaFromDate(any())).thenAnswer(
        (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    final result = await usecase(tDate);

    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
