import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:starbhakmart/main.dart';
import 'package:starbhakmart/pages/add_page.dart';
import 'package:starbhakmart/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final supabase = SupabaseClient(
    'https://ktrnxlysmukrssjydcyu.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0cm54bHlzbXVrcnNzanlkY3l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzMzM0NTMsImV4cCI6MjA0NzkwOTQ1M30.QtGBEWD2Y86TTGeEJb4g9zQOF9vhm3FLAcyuxD4SkmQ',
  );

  String? selectedValue;
  final List<String> items = ['Makanan', 'Minuman'];
  String? selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedFile = file.name;
      });
    } else {
      setState(() {
        selectedFile = null;
      });
    }
  }

  Future<void> addDataFood() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Prepare the data to be inserted
      final Map<String, dynamic> insertData = {
        'name': _namaController.text,
        'harga': double.parse(_hargaController.text),
        'kategori': selectedValue ?? 'Tidak ada kategori',
        'gambar': selectedFile ?? 'Tidak ada gambar'
      };

      final response = await supabase
        .from('tbl_food')
        .insert(insertData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk berhasil ditambahkan')),
      );

      // Reset form
      _namaController.clear();
      _hargaController.clear();
      setState(() {
        selectedValue = null;
        selectedFile = null;
      });
      
        Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan produk: $e')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // ... (AppBar code remains the same)
      ),
      
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Nama Produk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: 'Masukan nama produk',
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  return null;
                },
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Harga', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Masukan Harga',
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan harga yang valid';
                  }
                  return null;
                },
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Kategori Produk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedValue,
                hint: Text('Pilih produk'),
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilih kategori produk';
                  }
                  return null;
                },
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Masukan Gambar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Choose File'),
              ),
              SizedBox(height: 16),
              Text(
                selectedFile != null ? 'File Terpilih: $selectedFile' : 'Belum ada file yang dipilih',
                style: TextStyle(fontSize: 16),
              ),

              // Submit Button
              SizedBox(height: 20),
              SizedBox(
                width: 500,
                height: 53,
                child: ElevatedButton(
                  onPressed: addDataFood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: birubg,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(
                      color: whitebg,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}