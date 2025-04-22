import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakery Staff App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bakery Staff Directory'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SoalSatu(),
              SizedBox(height: 20),
              SoalDua(),
              SizedBox(height: 20),
              SoalTiga(),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================
// SOAL 1: List di dalam Map
// ========================
class SoalSatu extends StatelessWidget {
  const SoalSatu({super.key});

  final Map<String, List<String>> listDalamMap = const {
    'names': ['Arlin', 'Adela', 'Yoga', 'Karina', 'Monic', 'Kaluna'],
    'fields': [
      'Head Pastry Chef',
      'Artisan Bread Specialist',
      'Barista & Beverage Manager',
      'Cake Decorator',
      'Bakery Assistant',
      'Customer Experience Lead',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🧁 Soal 1: List di dalam Map',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Card(
          child: ListTile(
            title: const Text('Staff Names'),
            subtitle: Text(listDalamMap['names']!.join(', ')),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Bakery Roles'),
            subtitle: Text(listDalamMap['fields']!.join(', ')),
          ),
        ),
      ],
    );
  }
}

// ========================
// SOAL 2: List berisi Map
// ========================
class SoalDua extends StatelessWidget {
  const SoalDua({super.key});

  final List<Map<String, String>> mapDalamList = const [
    {"name": "Arlin", "field": "Head Pastry Chef"},
    {"name": "Adela", "field": "Artisan Bread Specialist"},
    {"name": "Yoga", "field": "Barista & Beverage Manager"},
    {"name": "Karina", "field": "Cake Decorator"},
    {"name": "Monic", "field": "Bakery Assistant"},
    {"name": "Kaluna", "field": "Customer Experience Lead"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🧁 Soal 2: List berisi Map',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ...mapDalamList.map((person) {
          final initials = person["name"]!.substring(0, 2).toUpperCase();
          return Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Text(
                  initials,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                person["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(person["field"]!),
            ),
          );
        }).toList(),
      ],
    );
  }
}

// ========================
// SOAL 3: Tambah, Edit, Hapus Nama
// ========================
class SoalTiga extends StatefulWidget {
  const SoalTiga({super.key});

  @override
  State<SoalTiga> createState() => _SoalTigaState();
}

class _SoalTigaState extends State<SoalTiga> {
  List<String> daftarNama = ['Arlin', 'Adela', 'Yoga'];
  final TextEditingController namaController = TextEditingController();

  void tambahNamaDialog() {
    namaController.clear();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Staff Baru'),
            content: TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama staff',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  final namaBaru = namaController.text.trim();
                  if (namaBaru.isNotEmpty) {
                    setState(() => daftarNama.add(namaBaru));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
    );
  }

  void editNamaDialog(int index) {
    namaController.text = daftarNama[index];
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Nama Staff'),
            content: TextField(
              controller: namaController,
              decoration: const InputDecoration(hintText: 'Ubah nama staff'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  final namaBaru = namaController.text.trim();
                  if (namaBaru.isNotEmpty) {
                    setState(() => daftarNama[index] = namaBaru);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  void hapusNama(int index) {
    setState(() => daftarNama.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🧁 Soal 3: Tambah, Edit, dan Hapus Nama Staff',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ...daftarNama.asMap().entries.map((entry) {
          int index = entry.key;
          String nama = entry.value;
          return Card(
            child: ListTile(
              title: Text(nama),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => editNamaDialog(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => hapusNama(index),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: tambahNamaDialog,
          icon: const Icon(Icons.add),
          label: const Text('Tambah Nama'),
        ),
      ],
    );
  }
}
