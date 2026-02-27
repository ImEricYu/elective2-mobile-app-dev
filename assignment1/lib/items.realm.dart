// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Items extends _Items with RealmEntity, RealmObjectBase, RealmObject {
  Items(String itemName, bool isChecked) {
    RealmObjectBase.set(this, 'itemName', itemName);
    RealmObjectBase.set(this, 'isChecked', isChecked);
  }

  Items._();

  @override
  String get itemName =>
      RealmObjectBase.get<String>(this, 'itemName') as String;
  @override
  set itemName(String value) => RealmObjectBase.set(this, 'itemName', value);

  @override
  bool get isChecked => RealmObjectBase.get<bool>(this, 'isChecked') as bool;
  @override
  set isChecked(bool value) => RealmObjectBase.set(this, 'isChecked', value);

  @override
  Stream<RealmObjectChanges<Items>> get changes =>
      RealmObjectBase.getChanges<Items>(this);

  @override
  Stream<RealmObjectChanges<Items>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Items>(this, keyPaths);

  @override
  Items freeze() => RealmObjectBase.freezeObject<Items>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'itemName': itemName.toEJson(),
      'isChecked': isChecked.toEJson(),
    };
  }

  static EJsonValue _toEJson(Items value) => value.toEJson();
  static Items _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'itemName': EJsonValue itemName, 'isChecked': EJsonValue isChecked} =>
        Items(fromEJson(itemName), fromEJson(isChecked)),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Items._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Items, 'Items', [
      SchemaProperty('itemName', RealmPropertyType.string),
      SchemaProperty('isChecked', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
