import 'dart:convert';

import 'package:flutter_restaurant_finder/DataLayer/location.dart';
import 'package:flutter_restaurant_finder/DataLayer/restaurant.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class ZomatoClient {
  final _apiKey = 'PASTE YOUR API KEY HERE';
  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';


  ///This returns raw data(Map)
  Future<Map> request(
      {required String path, Map<String, String>? parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await get(uri, headers: _headers);
    return json.decode(results.body);
  }


  ///This is a Header by which we provide API key
  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};

  ///This returns List of Restaurants
  Future<List<Restaurant>> fetchRestaurants(Location l, String q) async {

    final results = await request(path: 'search',
        parameters: {
          'entity_id': l.id.toString(),
          'entity_type': l.type.toString(),
          'q': q
        });

    return results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);
  }

  ///This returns List of Locations
  Future<List<Location>> fetchLocations(String q) async {
    final results = await request(
        path: 'locations', parameters: {'query': q, 'count': '10'});

    final suggestions = results['location_suggestions'];
    return suggestions
        .map<Location>((json) => Location.fromJson(json))
        .toList(growable: false);
  }
}