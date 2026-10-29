import 'package:flutter/material.dart';

String rupiah(int v) => 'Rp${v.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]}.',
    )}';

class FineSummaryCard extends StatelessWidget {
  const FineSummaryCard({super.key, required this.totalFine});
  final int totalFine; 

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        leading: const Icon(Icons.payments),
        title: const Text('Total denda'),
        trailing: Text(rupiah(totalFine),
            style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}