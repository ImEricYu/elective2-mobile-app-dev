import 'package:realm/realm.dart';

part 'items.realm.dart';

@RealmModel()
class _Items{

  late String itemName;
  late bool isChecked;
}