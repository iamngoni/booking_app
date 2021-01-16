import 'dart:convert';

class Application {
  final String type;
  final String destination;
  final int guests;
  final int bedrooms;
  final String necessities;
  final int lowerLimit;
  final int upperLimit;
  final int nights;
  final String date;
  final int offers;
  Application({
    this.type,
    this.destination,
    this.guests,
    this.bedrooms,
    this.necessities,
    this.lowerLimit,
    this.upperLimit,
    this.nights,
    this.date,
    this.offers,
  });

  Application copyWith(
      {String type,
      String destination,
      int guests,
      int bedrooms,
      String necessities,
      int lowerLimit,
      int upperLimit,
      int nights,
      String date,
      int offers}) {
    return Application(
      type: type ?? this.type,
      destination: destination ?? this.destination,
      guests: guests ?? this.guests,
      bedrooms: bedrooms ?? this.bedrooms,
      necessities: necessities ?? this.necessities,
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
      nights: nights ?? this.nights,
      date: date ?? this.date,
      offers: offers ?? this.offers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'destination': destination,
      'guests': guests,
      'bedrooms': bedrooms,
      'necessities': necessities,
      'lowerLimit': lowerLimit,
      'upperLimit': upperLimit,
      'nights': nights,
      'date': date,
      'offers': offers
    };
  }

  factory Application.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Application(
        type: map['type'],
        destination: map['destination'],
        guests: map['guests']?.toInt(),
        bedrooms: map['bedrooms']?.toInt(),
        necessities: map['necessities'],
        lowerLimit: map['lowerLimit']?.toInt(),
        upperLimit: map['upperLimit']?.toInt(),
        nights: map['nights']?.toInt(),
        date: map['date'],
        offers: map['offers']);
  }

  String toJson() => json.encode(toMap());

  factory Application.fromJson(String source) =>
      Application.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Application(type: $type, destination: $destination, guests: $guests, bedrooms: $bedrooms, necessities: $necessities, lowerLimit: $lowerLimit, upperLimit: $upperLimit, nights: $nights, date: $date, offers: $offers)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Application &&
        o.type == type &&
        o.destination == destination &&
        o.guests == guests &&
        o.bedrooms == bedrooms &&
        o.necessities == necessities &&
        o.lowerLimit == lowerLimit &&
        o.upperLimit == upperLimit &&
        o.nights == nights &&
        o.date == date &&
        o.offers == offers;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        destination.hashCode ^
        guests.hashCode ^
        bedrooms.hashCode ^
        necessities.hashCode ^
        lowerLimit.hashCode ^
        upperLimit.hashCode ^
        nights.hashCode ^
        date.hashCode;
  }
}
