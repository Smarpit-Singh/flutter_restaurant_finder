import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String? id;
  final String? name;
  final String? url;
  final String? currency;
  final String? thumbUrl;
  final String? imageUrl;
  final String? cuisines;
  final String? address;
  final Rating? rating;

  final int? priceRange;

  String get priceDisplay {
    final buffer = StringBuffer();
    for (int i = 0; i < priceRange!; i++) {
      buffer.write(currency);
    }
    return buffer.toString();
  }

  Restaurant.fromJson(json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        thumbUrl = json['thumb'],
        imageUrl = json['featured_image'],
        priceRange = json['price_range'],
        currency = json['currency'],
        cuisines = json['cuisines'],
        address = json['location']['address'],
        rating = Rating.fromJson(json['user_rating']);

  @override
  List<Object> get props => [
        id!,
        name!,
        url!,
        currency!,
        thumbUrl!,
        imageUrl!,
        cuisines!,
        address!,
        rating!,
        priceRange!,
      ];
}

class Rating {
  final String? text;
  final String? average;

  Rating.fromJson(Map json)
      : text = json['rating_text'].toString(),
        average = json['aggregate_rating'].toString();
}
