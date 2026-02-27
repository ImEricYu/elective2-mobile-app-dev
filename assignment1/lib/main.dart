import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import 'items.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Realm realm;
  late RealmResults<Items> results;
  final itemCtrl = TextEditingController();
  bool allChecked = false;
  @override
  void initState() {
    super.initState();
    final config = Configuration.local([Items.schema]);
    realm = Realm(config);
    results = realm.all<Items>();
  }

  void addItem() {
    if (itemCtrl.text.trim().isEmpty) return;
    realm.write(() {
      realm.add(Items(itemCtrl.text.trim(), false));
    });
    itemCtrl.clear();
    setState(() {});
  }

  void toggleItem(Items item) {
    realm.write(() {
      item.isChecked = !item.isChecked;
    });
    setState(() {});
  }

  void toggleAll() {
    allChecked = !allChecked;
    realm.write(() {
      for (var item in results) {
        item.isChecked = allChecked;
      }
    });
    setState(() {});
  }

  void sweep() {
    realm.write(() {
      final toDelete = results.where((item) => item.isChecked).toList();
      for (var item in toDelete) {
        realm.delete(item);
      }
    });
    allChecked = false;
    setState(() {});
  }

  @override
  void dispose() {
    itemCtrl.dispose();
    realm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.black,

        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1E5F99),
          statusBarIconBrightness: Brightness.light,
        ),

        leading: IconButton(
          onPressed: toggleAll,
          icon: Icon(
            allChecked ? Icons.check_circle : Icons.check_circle_outline,
            size: 28,
          ),
        ),
        title: const Text(
          'Shopping List',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            onPressed: sweep,
            icon: const Icon(Icons.cleaning_services_outlined, size: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: itemCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Item',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: addItem,
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        item.itemName,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: item.isChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => toggleItem(item),
                        icon: Icon(
                          item.isChecked
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.grey[700],
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
