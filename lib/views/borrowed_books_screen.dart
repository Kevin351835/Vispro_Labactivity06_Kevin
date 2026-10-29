import 'package:flutter/material.dart';
import 'package:university_library/viewmodels/library_view_model.dart';
import 'fine_summary_card.dart';
import 'loan_card.dart';

class BorrowedBooksScreen extends StatelessWidget {
  const BorrowedBooksScreen({super.key, required this.vm});
  final LibraryViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        final loans = vm.loans;

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            FineSummaryCard(totalFine: vm.totalFine),
            const SizedBox(height: 12),
            if (loans.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'Belum ada pinjaman aktif.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ...loans.map((loan) {
                return LoanCard(
                  loan: loan,
                  title: vm.titleOf(loan.bookId),
                  status: vm.getOverdueStatus(loan),
                  fine: vm.calculateFine(loan),
                  onReturn: () {
                    final error = vm.returnBook(loan.id);
                    if (error != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                  },
                );
              }),
          ],
        );
      },
    );
  }
}