import 'dart:convert';

class Popular {
  final String name;
  final int rating;
  final int price;
  final String image;
  Popular({
    this.name,
    this.rating,
    this.price,
    this.image,
  });

  Popular copyWith({
    String name,
    int rating,
    int price,
    String image,
  }) {
    return Popular(
      name: name ?? this.name,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'price': price,
      'image': image,
    };
  }

  factory Popular.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Popular(
      name: map['name'],
      rating: map['rating']?.toInt(),
      price: map['price']?.toInt(),
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Popular.fromJson(String source) => Popular.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Popular(name: $name, rating: $rating, price: $price, image: $image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Popular &&
      o.name == name &&
      o.rating == rating &&
      o.price == price &&
      o.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      rating.hashCode ^
      price.hashCode ^
      image.hashCode;
  }
}