## JsonSerializable
#### `JsonSerializable.anyMap`

* `build.yaml` key: `any_map`

If `true`, `Map` types are *not* assumed to be `Map<String, dynamic>`
– which is the default type of `Map` instances return by JSON decode in
`dart:convert`.

This will increase the code size, but allows `Map` types returned
from other sources, such as `package:yaml`.

*Note: in many cases the key values are still assumed to be `String`*.

#### `JsonSerializable.checked`

* `build.yaml` key: `checked`

If `true`, generated `fromJson` functions include extra checks to validate
proper deserialization of types.

If an exception is thrown during deserialization, a
`CheckedFromJsonException` is thrown.

#### `JsonSerializable.createFactory`

* `build.yaml` key: `create_factory`

If `true` (the default), a private, static `_$ExampleFromJson` method
is created in the generated part file.

Call this method from a factory constructor added to the source class:

```dart
@JsonSerializable()
class Example {
  // ...
  factory Example.fromJson(Map<String, dynamic> json) =>
    _$ExampleFromJson(json);
}
```

#### `JsonSerializable.createToJson`

* `build.yaml` key: `create_to_json`

If `true` (the default), code for encoding JSON is generated for this
class.

If `json_serializable` is configured with
`generate_to_json_function: true` (the default), a top-level function is
created that you can reference from your class.

```dart
@JsonSerializable()
class Example {
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
```

If `json_serializable` is configured with
`generate_to_json_function: false`, a private `_$ClassNameMixin` class is
created in the generated part file which contains a `toJson` method.

Mix in this class to the source class:

```dart
@JsonSerializable()
class Example extends Object with _$ExampleSerializerMixin {
  // ...
}
```

#### `JsonSerializable.disallowUnrecognizedKeys`

* `build.yaml` key: `disallow_unrecognized_keys`

If `false` (the default), then the generated `FromJson` function will
ignore unrecognized keys in the provided JSON `Map`.

If `true`, unrecognized keys will cause an `UnrecognizedKeysException` to
be thrown.

#### `JsonSerializable.encodeEmptyCollection`

* `build.yaml` key: `encode_empty_collection`
* See also [`JsonKey.encodeEmptyCollection`](#jsonkeyencodeemptycollection)

Whether the generator should include empty collection field values in the
serialized output.

If `true` (the default), empty collection fields
(of type `Iterable`, `Set`, `List`, and `Map`)
are included in generated `toJson` functions.

If `false`, fields with empty collections are omitted from `toJson`.

Note: setting this property to `false` overrides the [`JsonSerializable.includeIfNull`](#jsonserializableincludeifnull)
value to `false` as well.

Note: non-collection fields are not affected by this value.

#### `JsonSerializable.explicitToJson`

* `build.yaml` key: `explicit_to_json`

If `true`, generated `toJson` methods will explicitly call `toJson` on
nested objects.

When using JSON encoding support in `dart:convert`, `toJson` is
automatically called on objects, so the default behavior
(`explicitToJson: false`) is to omit the `toJson` call.

Example of `explicitToJson: false` (default)

```dart
Map<String, dynamic> toJson() => {'child': child};
```

Example of `explicitToJson: true`

```dart
Map<String, dynamic> toJson() => {'child': child?.toJson()};
```

#### `JsonSerializable.fieldRename`

* `build.yaml` key: `field_rename`

Defines the automatic naming strategy when converting class field names
into JSON map keys.

With a value `FieldRename.none` (the default), the name of the field is
used without modification.

See `FieldRename` for details on the other options.

Note: the value for [`JsonKey.name`](#jsonkeyname) takes precedence over this option for
fields annotated with `JsonKey`.

#### `JsonSerializable.generateToJsonFunction`

* `build.yaml` key: `generate_to_json_function`

Controls how `toJson` functionality is generated for all types processed
by this generator.

If `true` (the default), a top-level function is created.

```dart
@JsonSerializable()
class Example {
  // ...
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
```

If `false`, a private `_$ClassNameSerializerMixin` class is
created in the generated part file which contains a `toJson` method.

Mix in this class to the source class:

```dart
@JsonSerializable()
class Example extends Object with _$ExampleSerializerMixin {
  // ...
}
```

#### `JsonSerializable.includeIfNull`

* `build.yaml` key: `include_if_null`
* See also [`JsonKey.includeIfNull`](#jsonkeyincludeifnull)

Whether the generator should include fields with `null` values in the
serialized output.

If `true` (the default), all fields are written to JSON, even if they are
`null`.

If a field is annotated with `JsonKey` with a non-`null` value for
`includeIfNull`, that value takes precedent.

#### `JsonSerializable.nullable`

* `build.yaml` key: `nullable`
* See also [`JsonKey.nullable`](#jsonkeynullable)

When `true` (the default), `null` fields are handled gracefully when
encoding to JSON and when decoding `null` and nonexistent values from
JSON.

Setting to `false` eliminates `null` verification in the generated code,
which reduces the code size. Errors may be thrown at runtime if `null`
values are encountered, but the original class should also implement
`null` runtime validation if it's critical.

#### `JsonSerializable.useWrappers`

* `build.yaml` key: `use_wrappers`

If `true`, wrappers are used to minimize the number of
`Map` and `List` instances created during serialization.

This will increase the code size, but it may improve runtime performance,
especially for large object graphs.

## JsonKey
#### `JsonKey.defaultValue`

The value to use if the source JSON does not contain this key or if the
value is `null`.

#### `JsonKey.disallowNullValue`

If `true`, generated code will throw a `DisallowedNullValueException` if
the corresponding key exits, but the value is `null`.

Note: this value does not affect the behavior of a JSON map *without* the
associated key.

If [`JsonKey.disallowNullValue`](#jsonkeydisallownullvalue) is `true`, [`JsonKey.includeIfNull`](#jsonkeyincludeifnull) will be treated as
`false` to ensure compatibility between `toJson` and `fromJson`.

If both [`JsonKey.includeIfNull`](#jsonkeyincludeifnull) and [`JsonKey.disallowNullValue`](#jsonkeydisallownullvalue) are set to `true` on the
same field, an exception will be thrown during code generation.

#### `JsonKey.encodeEmptyCollection`

* See also [`JsonSerializable.encodeEmptyCollection`](#jsonserializableencodeemptycollection)

Whether the generator should include the annotated field value in the
serialized output if it is empty.

If `true` (the default), empty values are included in the generated
`toJson` function.

If `false`, fields with empty collections are omitted from `toJson`.

Note: setting this property to `false` overrides the [`JsonKey.includeIfNull`](#jsonkeyincludeifnull)
value to `false` as well. Explicitly setting [`JsonKey.includeIfNull`](#jsonkeyincludeifnull) to `true`
and setting this property to `false` will cause an error at build time.

Note: setting this property to `false` on a non-collection field
(of types other than `Iterable`, `Set`, `List`, and `Map`)
will cause an error at build time.

The default value, `null`, indicates that the behavior should be
acquired from the [`JsonSerializable.encodeEmptyCollection`](#jsonserializableencodeemptycollection) annotation on
the enclosing class.

#### `JsonKey.fromJson`

A `Function` to use when decoding the associated JSON value to the
annotated field.

Must be a top-level or static `Function` that takes one argument mapping
a JSON literal to a value compatible with the type of the annotated field.

When creating a class that supports both `toJson` and `fromJson`
(the default), you should also set [`JsonKey.toJson`](#jsonkeytojson) if you set [`JsonKey.fromJson`](#jsonkeyfromjson).
Values returned by [`JsonKey.toJson`](#jsonkeytojson) should "round-trip" through [`JsonKey.fromJson`](#jsonkeyfromjson).

#### `JsonKey.ignore`

`true` if the generator should ignore this field completely.

If `null` (the default) or `false`, the field will be considered for
serialization.

#### `JsonKey.includeIfNull`

* See also [`JsonSerializable.includeIfNull`](#jsonserializableincludeifnull)

Whether the generator should include fields with `null` values in the
serialized output.

If `true`, the generator should include the field in the serialized
output, even if the value is `null`.

The default value, `null`, indicates that the behavior should be
acquired from the [`JsonSerializable.includeIfNull`](#jsonserializableincludeifnull) annotation on the
enclosing class.

If [`JsonKey.disallowNullValue`](#jsonkeydisallownullvalue) is `true`, this value is treated as `false` to
ensure compatibility between `toJson` and `fromJson`.

If both [`JsonKey.includeIfNull`](#jsonkeyincludeifnull) and [`JsonKey.disallowNullValue`](#jsonkeydisallownullvalue) are set to `true` on the
same field, an exception will be thrown during code generation.

#### `JsonKey.name`

The key in a JSON map to use when reading and writing values corresponding
to the annotated fields.

If `null`, the field name is used.

#### `JsonKey.nullable`

* See also [`JsonSerializable.nullable`](#jsonserializablenullable)

When `true`, `null` fields are handled gracefully when encoding to JSON
and when decoding `null` and nonexistent values from JSON.

Setting to `false` eliminates `null` verification in the generated code
for the annotated field, which reduces the code size. Errors may be thrown
at runtime if `null` values are encountered, but the original class should
also implement `null` runtime validation if it's critical.

The default value, `null`, indicates that the behavior should be
acquired from the [`JsonSerializable.nullable`](#jsonserializablenullable) annotation on the
enclosing class.

#### `JsonKey.required`

When `true`, generated code for `fromJson` will verify that the source
JSON map contains the associated key.

If the key does not exist, a `MissingRequiredKeysException` exception is
thrown.

Note: only the existence of the key is checked. A key with a `null` value
is considered valid.

#### `JsonKey.toJson`

A `Function` to use when encoding the annotated field to JSON.

Must be a top-level or static `Function` with one parameter compatible
with the field being serialized that returns a JSON-compatible value.

When creating a class that supports both `toJson` and `fromJson`
(the default), you should also set [`JsonKey.fromJson`](#jsonkeyfromjson) if you set [`JsonKey.toJson`](#jsonkeytojson).
Values returned by [`JsonKey.toJson`](#jsonkeytojson) should "round-trip" through [`JsonKey.fromJson`](#jsonkeyfromjson).

