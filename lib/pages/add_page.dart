import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/create_page.dart';
import 'package:starbhakmart/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final supabase = SupabaseClient(
    'https://ktrnxlysmukrssjydcyu.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0cm54bHlzbXVrcnNzanlkY3l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzMzM0NTMsImV4cCI6MjA0NzkwOTQ1M30.QtGBEWD2Y86TTGeEJb4g9zQOF9vhm3FLAcyuxD4SkmQ',
  );

  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
  try {
    final response = await supabase
        .from('tbl_food') // Replace 'tbl_food' with your table name
        .select('name, harga, kategori, gambar');

    if (response == null) {
      throw Exception('Failed to fetch data');
    }

   setState(() {
      products = response.map((product) {
        return {
          ...product,
          'gambar': product['gambar'] != null
              ? supabase.storage.from('your_bucket_name').getPublicUrl(product['gambar'])
              : null,
        };
      }).toList();
      isLoading = false;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal mengambil data: $e')),
    );
  }
}

  Future<void> deleteProduct(int id) async {
  try {
    final response = await supabase
        .from('tbl_food') // Replace 'tbl_food' with your table name
        .delete()
        .eq('id', id);

    if (response == null) {
      throw Exception('Failed to delete data');
    }

    setState(() {
      products.removeWhere((product) => product['id'] == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produk berhasil dihapus')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal menghapus produk: $e')),
    );
  }
}

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.black, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePage()),
                ).then((_) {
                  // Refresh data setelah kembali dari CreatePage
                  fetchProducts();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: birubg,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add Data'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: const [
                Expanded(child: Center(child: Text('Gambar'))),
                Expanded(child: Center(child: Text('Nama Produk'))),
                Expanded(child: Center(child: Text('Harga'))),
                Expanded(child: Center(child: Text('Kategori'))),
                Expanded(child: Center(child: Text('Aksi'))),
              ],
            ),
          ),
          const Divider(),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Gambar Produk
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: item['gambar'] != null &&
                                      item['gambar'].isNotEmpty
                                  ? Image.network(
                                      item['gambar'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.image_not_supported,
                                      size: 80, color: Colors.grey),
                            ),
                            // Nama Produk
                            Expanded(
                              child: Center(
                                child: Text(item['name'] ?? 'Tidak ada nama'),
                              ),
                            ),
                            // Harga Produk
                            Expanded(
                              child: Center(
                                child: Text(
                                    'Rp ${item['harga'].toString()}' ?? ''),
                              ),
                            ),
                            // Kategori Produk
                            Expanded(
                              child: Center(
                                child: Text(
                                    item['kategori'] ?? 'Tidak ada kategori'),
                              ),
                            ),
                            // Tombol Hapus
                            Expanded(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.pink,
                                ),
                                onPressed: () {
                                  deleteProduct(item['id']);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}