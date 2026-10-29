enum DisplayStatus { available, borrowed, overdue, missing, returned }

class FinePolicy {
  static const int loanDays = 7;
  static const int finePerWeek = 5000;
  static const int missingAfterMonths = 6;
}