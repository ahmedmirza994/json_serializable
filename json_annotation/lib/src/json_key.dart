// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'json_serializable.dart';

/// An annotation used to specify how a field is serialized.
class JsonKey {
  /// The key in a JSON map to use when reading and writing values corresponding
  /// to the annotated fields.
  ///
  /// If `null`, the field name is used.
  final String name;

  /// When `true`, `null` values are handled gracefully when serializing to JSON
  /// and when deserializing `null` and nonexistent values from a JSON map.
  ///
  /// Setting to `false` eliminates `null` verification in the generated code
  /// for the annotated field, which reduces the code size. Errors may be thrown
  /// at runtime if `null` values are encountered, but the original class should
  /// also implement `null` runtime validation if it's critical.
  ///
  /// The default value, `null`, indicates that the behavior should be
  /// acquired from the [JsonSerializable.nullable] annotation on the
  /// enclosing class.
  final bool nullable;

  /// Whether the generator should include fields with `null` values in the
  /// serialized output.
  ///
  /// If `true`, the generator should include the field in the serialized
  /// output, even if the value is `null`.
  ///
  /// The default value, `null`, indicates that the behavior should be
  /// acquired from the [JsonSerializable.includeIfNull] annotation on the
  /// enclosing class.
  ///
  /// If [disallowNullValue] is `true`, this value is treated as `false` to
  /// ensure compatibility between `toJson` and `fromJson`.
  ///
  /// If both [includeIfNull] and [disallowNullValue] are set to `true` on the
  /// same field, an exception will be thrown during code generation.
  final bool includeIfNull;

  /// `true` if the generator should ignore this field completely.
  ///
  /// If `null` (the default) or `false`, the field will be considered for
  /// serialization.
  final bool ignore;

  /// A top-level [Function] to use when deserializing the associated JSON
  /// value to the annotated field.
  ///
  /// The [Function] should take one argument that maps to the expected JSON
  /// value and return a value that can be assigned to the type of the annotated
  /// field.
  ///
  /// When creating a class that supports both `toJson` and `fromJson`
  /// (the default), you should also set [toJson] if you set [fromJson].
  /// Values returned by [toJson] should "round-trip" through [fromJson].
  final Function fromJson;

  /// A top-level [Function] to use when serializing the annotated field to
  /// JSON.
  ///
  /// The [Function] should take one argument that is compatible with the field
  /// being serialized and return a JSON-compatible value.
  ///
  /// When creating a class that supports both `toJson` and `fromJson`
  /// (the default), you should also set [fromJson] if you set [toJson].
  /// Values returned by [toJson] should "round-trip" through [fromJson].
  final Function toJson;

  /// The value to use if the source JSON does not contain this key or if the
  /// value is `null`.
  final Object defaultValue;

  /// When `true`, generated code for `fromJson` will verify that the source
  /// JSON map contains the associated key.
  ///
  /// If the key does not exist, a `MissingRequiredKeysException` exception is
  /// thrown.
  ///
  /// Note: only the existence of the key is checked. A key with a `null` value
  /// is considered valid.
  final bool required;

  /// If `true`, generated code will throw a `DisallowedNullValueException` if
  /// the corresponding key exits, but the value is `null`.
  ///
  /// Note: this value does not affect the behavior of a JSON map *without* the
  /// associated key.
  ///
  /// If [disallowNullValue] is `true`, [includeIfNull] will be treated as
  /// `false` to ensure compatibility between `toJson` and `fromJson`.
  ///
  /// If both [includeIfNull] and [disallowNullValue] are set to `true` on the
  /// same field, an exception will be thrown during code generation.
  final bool disallowNullValue;

  /// Whether the generator should include the annotated field value in the
  /// serialized output if it is empty.
  ///
  /// If `true` (the default), empty values are included in the generated
  /// `toJson` function.
  ///
  /// If `false`, fields with empty collections are omitted from `toJson`.
  ///
  /// Note: setting this property to `false` overrides the [includeIfNull]
  /// value to `false` as well. Explicitly setting [includeIfNull] to `true`
  /// and setting this property to `false` will cause an error at build time.
  ///
  /// Note: setting this property to `false` on a non-collection field
  /// (of types other than [Iterable], [Set], [List], and [Map])
  /// will cause an error at build time.
  final bool encodeEmptyCollection;

  /// Creates a new [JsonKey] instance.
  ///
  /// Only required when the default behavior is not desired.
  const JsonKey({
    this.defaultValue,
    this.disallowNullValue,
    this.encodeEmptyCollection,
    this.fromJson,
    this.ignore,
    this.includeIfNull,
    this.name,
    this.nullable,
    this.required,
    this.toJson,
  });
}
