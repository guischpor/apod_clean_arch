import 'package:apod/core/errors/failures.dart';
import 'package:apod/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:apod/features/presenter/controller/home_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeController controller;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediaFromDateUsecase();
    controller = HomeController(mockUsecase);
    registerFallbackValue(DateTime(0, 0, 0));
  });

  test('should return a SpaceMedia from the usecase', () async {
    when(() => mockUsecase(any()))
        .thenAnswer((_) async => const Right(tSpaceMedia));
    final result = await controller.getSpaceMediaFromDate(tDate);

    print("result: $result");

    expect(result, const Right(tSpaceMedia));
    verify(() => mockUsecase(tDate)).called(1);
  });

  final tFailure = ServerFailure();

  test('should return a Failure from the usecase when there is an error',
      () async {
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(tFailure));

    final result = await controller.getSpaceMediaFromDate(tDate);

    expect(result, Left(tFailure));
    verify(() => mockUsecase(tDate)).called(1);
  });
}
