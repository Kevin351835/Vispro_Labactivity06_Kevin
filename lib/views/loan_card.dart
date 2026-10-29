import 'package:flutter/material.dart';
import '../models/fine_policy.dart';
import '../models/loan.dart';
import 'fine_summary_card.dart'; 

class LoanCard extends StatelessWidget {
  const LoanCard({
    super.key,
    required this.loan,
    required this.title,
    required this.status,
    required this.fine,
    required this.onReturn,
  });

  final Loan loan;
  final String title;
  final DisplayStatus status;
  final int fine;
  final VoidCallback onReturn;

  String _date(DateTime d) => '${d.day}/${d.month}/${d.year}';

  String get _statusLabel => switch (status) {
        DisplayStatus.available => 'Tersedia',
        DisplayStatus.borrowed => 'Dipinjam',
        DisplayStatus.overdue => 'Terlambat',
        DisplayStatus.missing => 'Hilang (Missing)',
        DisplayStatus.returned => 'Dikembalikan',
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Jatuh tempo: ${_date(loan.dueDate)}\n'
          'Status: $_statusLabel | Denda: ${rupiah(fine)}',
        ),
        isThreeLine: true,
        trailing: loan.isActive
            ? FilledButton(
                onPressed: onReturn,
                child: const Text('Return'),
              )
            : null,
      ),
    );
  }
}