class Book {
  final String id;
  final String title;
  final String author;
  final int replacementPrice;
  final bool isAvailable;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.replacementPrice,
    this.isAvailable = true,
  });

  Book copyWith({bool? isAvailable}) => Book(
        id: id,
        title: title,
        author: author,
        replacementPrice: replacementPrice,
        isAvailable: isAvailable ?? this.isAvailable,
      );
}