// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['id'] as int,
      json['name'] as String,
      json['image'] as String,
      json['status'] as String,
      json['gender'] as String,
      json['species'] as String,
      Origin.fromJson(json['origin'] as Map<String, dynamic>),
      Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'gender': instance.gender,
      'species': instance.species,
      'origin': instance.origin,
      'location': instance.location,
    };

Origin _$OriginFromJson(Map<String, dynamic> json) => Origin(
      name: json['name'] as String,
    );

Map<String, dynamic> _$OriginToJson(Origin instance) => <String, dynamic>{
      'name': instance.name,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      name: json['name'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.name,
    };
