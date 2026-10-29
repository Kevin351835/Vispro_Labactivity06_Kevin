import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book, required this.onBorrow});
  final Book book;
  final VoidCallback onBorrow;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('${book.author} • ${book.isAvailable ? "Tersedia" : "Dipinjam"}'),
        trailing: FilledButton(
          onPressed: onBorrow, 
          child: const Text('Borrow'),
        ),
      ),
    );
  }
}