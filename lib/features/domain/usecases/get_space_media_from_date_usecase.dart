// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:apod/core/errors/failures.dart';
import 'package:apod/core/usecase/usecase.dart';
import 'package:apod/features/domain/entities/space_media_entity.dart';
import 'package:apod/features/domain/repositories/i_space_media_repository.dart';
import 'package:dartz/dartz.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime? date) async {
    return date != null
        ? await repository.getSpaceMediaFromDate(date)
        : Left(NullParamFailure());
  }
}
