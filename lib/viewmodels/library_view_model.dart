import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/fine_policy.dart';
import '../models/loan.dart';

class LibraryViewModel extends ChangeNotifier {
  final DateTime Function() _now;
  final List<Book> _books;
  final List<Loan> _loans;
  final String currentStudentId;

  LibraryViewModel({
    List<Book>? books,
    List<Loan>? loans,
    this.currentStudentId = 'S001',
    DateTime Function()? now,
  })  : _now = now ?? DateTime.now,
        _books = books ?? List.from(_defaultBooks),
        _loans = loans ?? [];

  static const List<Book> _defaultBooks = [
    Book(id: 'B1', title: 'To Kill a Mockingbird', author: 'Harper Lee', replacementPrice: 135000),
    Book(id: 'B2', title: '1984', author: 'George Orwell', replacementPrice: 120000),
    Book(id: 'B3', title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', replacementPrice: 110000),
    Book(id: 'B4', title: 'Pride and Prejudice', author: 'Jane Austen', replacementPrice: 125000),
    Book(id: 'B5', title: 'The Catcher in the Rye', author: 'J.D. Salinger', replacementPrice: 140000),
    Book(id: 'B6', title: 'Bumi Manusia', author: 'Pramoedya Ananta Toer', replacementPrice: 160000),
    Book(id: 'B7', title: 'Laskar Pelangi', author: 'Andrea Hirata', replacementPrice: 110000),
  ];

  List<Book> get books => List.unmodifiable(_books);
  List<Loan> get loans => List.unmodifiable(_loans);
  List<Loan> get activeLoans => _loans.where((l) => l.isActive).toList();
  int get totalFine => _loans.fold(0, (sum, l) => sum + calculateFine(l));

  String titleOf(String bookId) {
    try {
      return _books.firstWhere((b) => b.id == bookId).title;
    } catch (_) {
      return 'Buku Tidak Ditemukan';
    }
  }

  String? borrowBook(String bookId, [String? studentId]) {
    final i = _books.indexWhere((b) => b.id == bookId);
    if (i == -1) return 'Buku tidak ditemukan.';
    if (!_books[i].isAvailable || _loans.any((l) => l.bookId == bookId && l.isActive)) {
      return 'Buku ini sedang dipinjam.';
    }

    final t = _today();
    _loans.add(
      Loan(
        id: 'L${_loans.length + 1}',
        bookId: bookId,
        studentId: studentId ?? currentStudentId,
        borrowDate: t,
        dueDate: t.add(const Duration(days: FinePolicy.loanDays)),
      ),
    );
    _books[i] = _books[i].copyWith(isAvailable: false);
    notifyListeners();
    return null;
  }

  String? returnBook(String loanId) {
    final i = _loans.indexWhere((l) => l.id == loanId && l.isActive);
    if (i == -1) return 'Pinjaman tidak ditemukan.';
    final b = _books.indexWhere((x) => x.id == _loans[i].bookId);

    _loans[i] = _loans[i].copyWith(returnDate: _today());
    if (b != -1) {
      _books[b] = _books[b].copyWith(isAvailable: true);
    }

    notifyListeners();
    return null;
  }

  DisplayStatus getOverdueStatus(Loan loan) {
    final ref = loan.returnDate ?? _today();
    if (!ref.isBefore(_missingDate(loan))) return DisplayStatus.missing;
    if (!loan.isActive) return DisplayStatus.returned;
    return ref.isAfter(loan.dueDate) ? DisplayStatus.overdue : DisplayStatus.borrowed;
  }

  int calculateFine(Loan loan) {
    if (getOverdueStatus(loan) == DisplayStatus.missing) {
      return _books.firstWhere((b) => b.id == loan.bookId).replacementPrice;
    }
    final daysLate = (loan.returnDate ?? _today()).difference(loan.dueDate).inDays;
    return daysLate <= 0 ? 0 : (daysLate ~/ 7) * FinePolicy.finePerWeek;
  }

  DateTime _today() => DateTime.utc(_now().year, _now().month, _now().day);

  DateTime _missingDate(Loan l) => DateTime.utc(
        l.dueDate.year,
        l.dueDate.month + FinePolicy.missingAfterMonths,
        l.dueDate.day,
      );
}