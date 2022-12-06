import 'package:apod/core/errors/exceptions.dart';
import 'package:apod/core/errors/failures.dart';
import 'package:apod/features/domain/entities/space_media_entity.dart';
import 'package:apod/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetSpaceMediaFromDateUsecase getSpaceMediaFromDateUsecase;

  HomeController(this.getSpaceMediaFromDateUsecase);

  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime? date) async {
    update();
    try {
      return await getSpaceMediaFromDateUsecase(date);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
