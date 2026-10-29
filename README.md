1. What is the difference between the Model, View, and ViewModel in this application?
Konsep MVVM: Model menyimpan data dan aturan (seperti Book dan FinePolicy). 
View adalah antarmuka UI yang dilihat pengguna. 
ViewModel menjadi jembatan pengelola logika yang menghubungkan keduanya.

2. Why should the fine calculation not be placed inside LoanCard.build()?
Hindari hitungan di build(): Fungsi build() dirender berulang kali oleh Flutter. 
Menaruh perhitungan denda di sana akan membuat aplikasi lambat dan kodenya sulit diuji secara terpisah.

3. What should happen if a student attempts to borrow a book that already has an active loan?
Buku yang sedang dipinjam: Sistem akan memblokir aksi tersebut dan memunculkan error. 
Satu buku fisik tidak bisa berstatus dipinjam oleh dua orang bersamaan.

4. Why is it better to calculate the fine in one place rather than repeating the formula in multiple widgets?
Hitungan denda terpusat: Ini menerapkan prinsip Don't Repeat Yourself (DRY). 
Jika aturan denda berubah (misal naik jadi Rp10.000),
cukup mengubahnya di satu file (FinePolicy) tanpa takut ada layar yang tidak sinkron.

5. What is the difference between a book being Overdue and being Missing?
Overdue vs Missing: Overdue adalah keterlambatan normal di bawah 6 bulan (dikenakan denda mingguan). Jika sudah lewat 180 hari, 
statusnya berubah jadi Missing (dianggap hilang permanen) dan denda langsung berubah menjadi harga pengganti buku tersebut.