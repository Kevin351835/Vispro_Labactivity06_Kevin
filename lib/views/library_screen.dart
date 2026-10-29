import 'package:flutter/material.dart';
import 'package:university_library/viewmodels/library_view_model.dart'; 
import 'book_card.dart';

const currentStudentId = '2086022510029';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key, required this.vm});
  final LibraryViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        if (vm.books.isEmpty) {
          return const Center(child: Text('Belum ada buku.'));
        }
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            for (final book in vm.books)
              BookCard(
                book: book,
                onBorrow: () {
                  final error = vm.borrowBook(book.id, currentStudentId);
                  if (error != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(error)));
                  }
                },
              ),
          ],
        );
      },
    );
  }
}