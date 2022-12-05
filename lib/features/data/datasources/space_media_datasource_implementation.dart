// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apod/core/endpoints/space_endpoints.dart';
import 'package:apod/core/errors/exceptions.dart';
import 'package:apod/core/utils/date_input_converter.dart';
import 'package:apod/features/data/datasources/i_space_media_datasource.dart';
import 'package:apod/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final DateInputConverter converter;
  final http.Client client;

  SpaceMediaDatasouceImplementation({
    required this.converter,
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverter = converter.format(date);
    final response = await client.get(NasaEndpoints.getSpaceMedia(
      'OSfBFnJDoH0uIkav0j9rpxegwioun3W3eGh3uP0d',
      dateConverter,
    ));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
