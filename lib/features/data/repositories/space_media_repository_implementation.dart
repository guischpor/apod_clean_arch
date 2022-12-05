// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:apod/core/errors/exceptions.dart';
import 'package:apod/core/errors/failures.dart';
import 'package:apod/features/data/datasources/i_space_media_datasource.dart';
import 'package:apod/features/domain/entities/space_media_entity.dart';
import 'package:apod/features/domain/repositories/i_space_media_repository.dart';
import 'package:dartz/dartz.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
