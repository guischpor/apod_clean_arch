
import 'package:apod/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeController(this.usecase);

  getSpaceMediaFromDate(DateTime? date) async {
    await usecase(date);
    update();
    // setLoading(true);
    // final result = await usecase(date);
    // result.fold((error) => setError(error), (success) => update(success));
    // setLoading(false);
  }
}
