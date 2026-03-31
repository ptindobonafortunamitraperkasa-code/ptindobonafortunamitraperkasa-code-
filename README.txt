INDOBONA FORTUNA MEMBER ONLINE
==============================

Paket ini dibuat agar aplikasi bisa dipakai di HP dan laptop dengan data yang sama.
Hosting: Netlify
Database online: Supabase

ISI FILE
--------
- index.html
- schema.sql
- netlify.toml
- README.txt

LANGKAH PALING SINGKAT
---------------------
1. Buat project baru di Supabase
2. Buka SQL Editor
3. Jalankan isi file schema.sql
4. Ambil:
   - Project URL
   - anon public key
5. Upload folder ini ke Netlify
6. Buka link Netlify
7. Saat aplikasi terbuka, tempel:
   - Supabase URL
   - Supabase anon key
8. Login default:
   - admin / admin123
   - kasir1 / kasir123

CATATAN PENTING
---------------
- Paket ini sudah online-ready dan multi-perangkat
- Data akan sama di semua HP/laptop selama memakai database Supabase yang sama
- Login admin/kasir pada paket ini masih model sederhana berbasis tabel staff_users
- Untuk keamanan tingkat lanjut, tahap berikutnya bisa dipindah ke Supabase Auth

FITUR YANG SUDAH ADA
--------------------
- daftar member
- pencarian nama / nomor HP / kode
- kartu member digital + QR
- poin otomatis dari belanja
- riwayat transaksi
- voucher / redeem poin
- level member
- export CSV
- multi cabang
- admin dan kasir terpisah

BATASAN SAAT INI
----------------
- scan QR kamera langsung belum diaktifkan
- password user masih sederhana di tabel staff_users
- belum ada upload logo custom
- belum ada domain khusus

SARAN LANJUTAN
--------------
Tahap berikutnya yang paling bagus:
- ganti login ke Supabase Auth
- tambah scan kamera QR
- tambah backup / restore
- tambah domain custom


UPDATE BARU
-----------
- Admin sekarang bisa menambah dan menghapus cabang langsung dari menu Pengaturan.

- Update terbaru: menu scanner sekarang sudah mendukung scan QR lewat kamera perangkat.

- Update terbaru: hint login default di halaman depan sudah disembunyikan.
- Admin sekarang bisa menambah, mengubah, dan menghapus user login dari menu Pengaturan.

- Perbaikan terbaru: QR member sekarang memakai QR code asli yang bisa dibaca scanner kamera.

- Update terbaru: export member dan export transaksi sekarang bisa dipilih per cabang/toko atau semua data sekaligus.


- Update terbaru:
  - kartu member digital diubah ke desain premium seperti contoh
  - bagian bawah kartu menampilkan cabang member secara otomatis
  - ada tombol Buka Kartu Premium
  - ada tombol Kirim via Gmail (membuka compose Gmail otomatis)


- Update terbaru:
  - kartu premium sekarang bisa diunduh sebagai PNG
  - kartu premium sekarang bisa diunduh sebagai PDF

- Update tema terbaru: Tema 1 Profesional Biru Modern diterapkan ke seluruh aplikasi.

- Update terbaru: sidebar kiri profesional dan dashboard corporate telah diperbaiki agar aman dipakai.

- Update terbaru: logo sidebar diperbaiki dan dashboard sekarang memakai grafik real dari data aplikasi.


- Update terbaru:
  - role super_admin / admin / kasir
  - hak akses tiap user bisa diatur sendiri
  - super admin mengelola semua akses
  - menu tampil mengikuti hak akses user
  - super admin tidak bisa dihapus

- Update terbaru: nama aplikasi diubah menjadi Fortuna Helmet dan logo sidebar/kartu diperbaiki.

- Perbaikan terbaru: logo sidebar dan kartu sekarang ditanam langsung sebagai gambar embedded, bukan placeholder.

- Update terbaru: logo ditempatkan di kiri atas sidebar, tepat di atas area menu/dashboard.

- Update terbaru: member sekarang bisa diedit dan dihapus langsung dari menu Member.

- Update terbaru: tombol Edit/Hapus Member dipastikan tampil dan ditambah fitur Edit Cabang.

- Perbaikan terbaru: tombol Edit Cabang dan Edit Member dibikin lebih stabil dan bisa diklik.

- Perbaikan terbaru: centang hak akses user sekarang tersimpan permanen ke Supabase.

- Update terbaru: QR member sekarang membuka kartu digital member langsung di browser/HP luar aplikasi.


- Update fitur terbaru:
  - level member bisa diatur sendiri dari Pengaturan (JSON tiers)
  - kode member bisa diatur sendiri: prefix, separator, digit, dan nomor urut berikutnya
  - poin transaksi otomatis mengikuti setting nominal/poin
  - tambah referral member saat daftar member baru
  - QR member jika discan di HP luar aplikasi akan membuka kartu member digital
  - dashboard sekarang bisa difilter berdasarkan cabang


- Perbaikan lanjutan:
  - pengaturan level member dibuat lebih mudah (field Bronze/Silver/Gold/Platinum)
  - pengaturan kode member IFMP0001 lebih jelas dan otomatis lanjut urutan
  - transaksi sekarang punya field referral member dan tampil di riwayat
  - nominal transaksi dan voucher diberi tampilan Rp
  - filter dashboard benar-benar memengaruhi ringkasan, grafik, dan transaksi terbaru
  - QR publik sekarang membawa konfigurasi database agar kartu bisa dibuka dari HP luar aplikasi

- Final fix: pengaturan kode/level memakai upsert + tombol simpan eksplisit.

- Tambahan: tombol preset kode IFMP/ASH dan laporan referral member.
