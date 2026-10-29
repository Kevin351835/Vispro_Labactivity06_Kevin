import 'package:flutter/material.dart';
import 'package:university_library/viewmodels/library_view_model.dart'; 
import 'views/borrowed_books_screen.dart';
import 'views/library_screen.dart';

void main() => runApp(const LibraryApp());

class LibraryApp extends StatefulWidget {
  const LibraryApp({super.key});
  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  final vm = LibraryViewModel(); // satu instance untuk seluruh aplikasi
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Library',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: const Text('University Library')),
        body: tab == 0 ? LibraryScreen(vm: vm) : BorrowedBooksScreen(vm: vm),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.menu_book), label: 'Katalog'),
            NavigationDestination(icon: Icon(Icons.assignment), label: 'Dipinjam'),
          ],
        ),
      ),
    );
  }
}