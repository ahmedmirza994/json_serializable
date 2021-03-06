[![Build Status](https://travis-ci.org/dart-lang/json_serializable.svg?branch=master)](https://travis-ci.org/dart-lang/json_serializable)

Provides [Dart Build System] builders for handling JSON.

The builders generate code when they find members annotated with classes defined
in [package:json_annotation].

- To generate to/from JSON code for a class, annotate it with
  `JsonSerializable`. You can provide arguments to `JsonSerializable` to
  configure the generated code. You can also customize individual fields
  by annotating them with `JsonKey` and providing custom arguments.

- To generate a Dart field with the contents of a file containing JSON, use the
  `JsonLiteral` annotation.

To configure your project for the latest released version of,
`json_serializable` see the [example].

## Example

Given a library `example.dart` with an `Person` class annotated with
`@JsonSerializable()`:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable(nullable: false)
class Person {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  Person({this.firstName, this.lastName, this.dateOfBirth});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
```

Building creates the corresponding part `example.g.dart`:

```dart
part of 'example.dart';

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String));
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth.toIso8601String()
    };
```

# Build configuration

Besides setting arguments on the associated annotation classes, you can also
configure code generation by setting values in `build.yaml`.

```yaml
targets:
  $default:
    builders:
      json_serializable:
        options:
          # Options configure how source code is generated for every
          # `@JsonSerializable`-annotated class in the package.
          #
          # The default value for each is listed.
          #
          # For usage information, reference the corresponding field in
          # `JsonSerializableGenerator`.
          any_map: false
          checked: false
          create_factory: true
          create_to_json: true
          disallow_unrecognized_keys: false
          encode_empty_collection: true
          explicit_to_json: false
          field_rename: none
          generate_to_json_function: true
          include_if_null: true
          nullable: true
          use_wrappers: false
```

[example]: https://github.com/dart-lang/json_serializable/blob/master/example
[Dart Build System]: https://github.com/dart-lang/build
[package:json_annotation]: https://pub.dartlang.org/packages/json_annotation
