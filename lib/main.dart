// ============================================================================
// 1. IMPORT PACKAGE & MAIN FUNCTION
// Part ini buat ngimpor pustaka UI Flutter dan jalanin aplikasi pertama kali
// ============================================================================
import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

// ============================================================================
// 2. MAIN APP WIDGET (ROOT CONFIGURATION)
// Mengatur tema global aplikasi, warna utama (merah/kuning), dan layar awal
// ============================================================================
class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ichiraku Ramen Bar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB71C1C), // Warna dasar merah
          primary: const Color(0xFFB71C1C),
          secondary: const Color(0xFFFFB300), // Warna aksen kuning
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      ),
      home: const RestaurantDetailPage(),
    );
  }
}

// ============================================================================
// 3. PAGE UTAMA (STATEFUL WIDGET)
// Mengelola halaman detail restoran & status kategori menu yang dipilih
// ============================================================================
class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  // Variabel untuk nyimpan index kategori mana yang lagi dipilih user
  int selectedCategory = 0;
  final List<String> categories = ['Semua', 'Ramen', 'Sushi', 'Gyoza', 'Minuman'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CustomScrollView dipakai supaya header banner bisa melipat halus saat di-scroll
      body: CustomScrollView(
        slivers: [
          
          // ------------------------------------------------------------------
          // A. HEADER BANNER (SliverAppBar)
          // Menampilkan gambar ramen, tombol bookmark/share, dan label Halal
          // ------------------------------------------------------------------
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true, // Biar pas di-scroll ke atas, appbar tetap nempel sedikit
            backgroundColor: const Color(0xFFB71C1C),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gambar Banner Unsplash (Ramen)
                  Image.network(
                    'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF212121),
                        child: const Center(
                          child: Icon(Icons.ramen_dining, size: 60, color: Colors.amber),
                        ),
                      );
                    },
                  ),
                  // Lapisan Gelap (Gradient Overlay) biar teks/icon di atas gambar tetap kelihatan jelas
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Badge Label Halal Certified
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'HALAL CERTIFIED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ------------------------------------------------------------------
          // B. KONTEN UTAMA HALAMAN
          // Menampilkan info resto, deskripsi, chip kategori, & daftar menu
          // ------------------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // B1. Judul Restoran & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ichiraku Ramen Bar 🍜',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Autentik Japanese Noodles & Izakaya',
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      // Kotak Rating Kuning
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFFB300)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
                            SizedBox(width: 4),
                            Text(
                              '4.9',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // B2. Kartu Info (Estimasi Waktu, Jarak, & Status Buka)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoItem(icon: Icons.timer_outlined, label: 'Estimasi', value: '15-20 mnt'),
                        ContainerDivider(),
                        InfoItem(icon: Icons.location_on_outlined, label: 'Jarak', value: '1.8 km'),
                        ContainerDivider(),
                        InfoItem(icon: Icons.storefront_outlined, label: 'Status', value: 'Buka Sekarang'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // B3. Teks Tentang Restoran
                  const Text(
                    'Tentang Restoran',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Menyajikan ramen kuah tonkotsu racikan spesial dengan mi buatan sendiri yang kenyal, potongan daging charsiu lembut, dan telur ajitama matang sempurna.',
                    style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 20),

                  // B4. Pilihan Kategori Menu (Bisa Di-scroll Kesamping)
                  const Text(
                    'Pilihan Menu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedCategory == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index; // Ganti kategori aktif saat di-klik
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFB71C1C) : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // B5. Daftar Item Makanan
                  const FoodItemCard(
                    name: 'Spicy Tonkotsu Ramen',
                    desc: 'Kuah pedas gurih, chashu empuk, ajitama, nori, & daun bawang.',
                    price: 'Rp 58.000',
                    imageUrl: 'https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=300&q=80',
                  ),
                  const FoodItemCard(
                    name: 'Shoyu Chicken Ramen',
                    desc: 'Kuah kecap Jepang kaldu ayam jernih dengan topping chicken katsu.',
                    price: 'Rp 48.000',
                    imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?auto=format&fit=crop&w=300&q=80',
                  ),
                  const FoodItemCard(
                    name: 'Gyoza Panggang (5pcs)',
                    desc: 'Dumpling isi daging ayam dan sayuran segar dipanggang renyah.',
                    price: 'Rp 32.000',
                    imageUrl: 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?auto=format&fit=crop&w=300&q=80',
                  ),
                  const SizedBox(height: 100), // Spasi bawah biar ga ketutupan BottomNavBar
                ],
              ),
            ),
          ),
        ],
      ),

      // ----------------------------------------------------------------------
      // C. BOTTOM NAVIGATION BAR (Bar Bawah Pesanan)
      // Menampilkan Total harga dan Tombol 'Pesan Sekarang'
      // ----------------------------------------------------------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Pesanan', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(
                    'Rp 58.000',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFB71C1C)),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Pesan Sekarang',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 4. WIDGET KOMPONEN KECIL (REUSABLE WIDGETS)
// Kumpulan widget kecil buatan sendiri biar kode di atas tetep rapi & ringkas
// ============================================================================

// Component InfoItem: Dipakai buat nampilin icon + estimasi/jarak/status di bawah judul
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoItem({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFB71C1C), size: 20),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}

// Component ContainerDivider: Garis pembatas abu-abu tegak lurus
class ContainerDivider extends StatelessWidget {
  const ContainerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}

// Component FoodItemCard: Kartu daftar makanan (Gambar, Nama, Deskripsi, Harga, Tombol Plus)
class FoodItemCard extends StatelessWidget {
  final String name;
  final String desc;
  final String price;
  final String imageUrl;

  const FoodItemCard({
    super.key,
    required this.name,
    required this.desc,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Gambar Makanan
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.ramen_dining, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Teks Info Makanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB71C1C),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Tombol Tambah (+)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle, color: Color(0xFFB71C1C), size: 28),
          ),
        ],
      ),
    );
  }
}