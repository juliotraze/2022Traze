import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_blue_example/Covid API/Models/world_stats_model.dart';
import 'package:flutter_blue_example/Covid API/Services/app_urls.dart';

class WorldStats {
  Future<WorldStatsModel> fetchWorldStatsRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldstatsApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
