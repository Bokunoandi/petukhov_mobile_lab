import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LabSix extends StatelessWidget {
  const LabSix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLabSix(title: 'Петухов Андрій лабораторна робота 7'),
    );
  }
}

class MyLabSix extends StatefulWidget {
  const MyLabSix({super.key, required this.title});

  final String title;

  @override
  State<MyLabSix> createState() => _MyLabSixPageState();
}

class _MyLabSixPageState extends State<MyLabSix> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
  }

  Future<void> _requestContactsPermission() async {
    final PermissionStatus status = await Permission.contacts.request();
    if (status == PermissionStatus.granted) {
      _loadContacts();
    } else {
      // Пользователь отказал в доступе к контактам, добавьте обработку ошибок
    }
  }

  Future<void> _loadContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      _contacts = contacts.toList(); // Просто загрузка контактов без сортировки
    });
  }


  List<Contact> _filterContacts(String query) {
    return _contacts.where((contact) {
      return contact.displayName?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();
  }

  void _showFilteredContacts() {
    List<Contact> filteredContacts = _contacts.where((contact) {
      String name = contact.displayName?.toLowerCase() ?? '';
      return name.endsWith('a') || name.endsWith('а'); // Русская и английская 'a'
    }).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Контакти, які закінчуються на "a"'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredContacts.length,
            itemBuilder: (context, index) {
              final contact = filteredContacts[index];
              return ListTile(
                title: Text(contact.displayName ?? ''),
                subtitle: Text(contact.phones?.isNotEmpty == true
                    ? contact.phones!.first.value ?? ''
                    : 'No phone number'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрити'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: _loadContacts,
            child: Text('Завантажити контакти'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? 'No Name'),
                  subtitle: Text(contact.phones?.isNotEmpty == true
                      ? contact.phones!.first.value ?? 'No phone number'
                      : 'No phone number'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showFilteredContacts,
            child: Text('Показати контакти, які закінчується на: "a"'),
          ),
        ],
      ),
    );
  }
}