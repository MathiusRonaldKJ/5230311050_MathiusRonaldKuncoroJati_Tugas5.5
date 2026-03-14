import 'package:flutter/material.dart';
import 'main.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String selectedCategory = 'Semua';
  late List<String> categories;

  // Warna utama
  static const Color blue = Color(0xFF2563EB);
  static const Color bgSoft = Color(0xFFEFF6FF);

  @override
  void initState() {
    super.initState();
    categories = ['Semua', ...cars.map((c) => c.category).toSet()];
  }

  List<Car> get filteredCars => selectedCategory == 'Semua' 
      ? cars 
      : cars.where((c) => c.category == selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgSoft,
      appBar: _appBar(),
      body: Column(children: [_infoHeader(), Expanded(child: _gridCars()), _recomButton()]),
    );
  }

  // APP BAR
  PreferredSizeWidget _appBar() => AppBar(
    title: const Text('Kategori', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    backgroundColor: blue,
    foregroundColor: Colors.white,
    toolbarHeight: 56,
    actions: [
      IconButton(icon: const Icon(Icons.search), onPressed: () => _showSearch(context)),
      IconButton(icon: const Icon(Icons.filter_list), onPressed: () => _showFilter(context)),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: categories.map(_chip).toList()),
        ),
      ),
    ),
  );

  Widget _chip(String cat) {
    final selected = selectedCategory == cat;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(cat, style: TextStyle(fontSize: 12, color: selected ? Colors.white : Colors.black87)),
        selected: selected,
        onSelected: (_) => setState(() => selectedCategory = cat),
        backgroundColor: Colors.grey[100],
        selectedColor: blue,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
      ),
    );
  }

  // HEADER INFO
  Widget _infoHeader() => Container(
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${filteredCars.length} mobil', style: const TextStyle(fontSize: 13)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
          child: Text(
            selectedCategory == 'Semua' ? 'Semua' : selectedCategory,
            style: TextStyle(fontSize: 11, color: blue),
          ),
        ),
      ],
    ),
  );

  // GRID MOBIL
  Widget _gridCars() {
    if (filteredCars.isEmpty) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.directions_car, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text('Tidak ada mobil', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() => selectedCategory = 'Semua'),
            style: ElevatedButton.styleFrom(backgroundColor: blue, shape: StadiumBorder()),
            child: const Text('Lihat Semua'),
          ),
        ]),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredCars.length,
        itemBuilder: (_, i) => _carCard(filteredCars[i]),
      ),
    );
  }

  // CARD MOBIL
  Widget _carCard(Car c) => GestureDetector(
    onTap: () => _showDetail(context, c),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
      ),
      child: Column(children: [_cardImage(c), _cardContent(c)]),
    ),
  );

  Widget _cardImage(Car c) => Expanded(
    flex: 6,
    child: Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: Image.network(
          c.image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey[300],
            child: Icon(_icon(c), size: 30, color: Colors.grey[600]),
          ),
        ),
      ),
      Positioned(
        top: 4, left: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(4)),
          child: Text(c.category, style: const TextStyle(color: Colors.white, fontSize: 8)),
        ),
      ),
      Positioned(
        top: 4, right: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Row(children: [
            const Icon(Icons.star, color: Colors.amber, size: 8),
            const SizedBox(width: 2),
            Text(c.rating.toString(), style: const TextStyle(fontSize: 7)),
          ]),
        ),
      ),
    ]),
  );

  Widget _cardContent(Car c) => Expanded(
    flex: 4,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(c.brand, style: const TextStyle(fontSize: 8, color: Colors.grey)),
          Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
          Row(children: [
            Icon(Icons.people, size: 7, color: Colors.grey[600]),
            const SizedBox(width: 2), Text('${c.seats}', style: TextStyle(fontSize: 6, color: Colors.grey[600])),
            const SizedBox(width: 4),
            Icon(c.transmission == 'Automatic' ? Icons.settings : Icons.settings_applications, size: 7, color: Colors.grey[600]),
            const SizedBox(width: 2),
            Text(c.transmission == 'Automatic' ? 'A' : 'M', style: TextStyle(fontSize: 6, color: Colors.grey[600])),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Rp${c.price}', style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: 9)),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(color: blue.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.arrow_forward, size: 6, color: blue),
            ),
          ]),
        ],
      ),
    ),
  );

  IconData _icon(Car c) {
    if (c.category == 'Bus') return Icons.directions_bus;
    if (c.category == 'Minibus') return Icons.airport_shuttle;
    return Icons.directions_car;
  }

  // TOMBOL REKOMENDASI
  Widget _recomButton() => Padding(
    padding: const EdgeInsets.all(12),
    child: SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () => _showRecom(context),
        style: ElevatedButton.styleFrom(backgroundColor: blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: const Text('Lihat Rekomendasi', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    ),
  );

  // DIALOG
  void _showSearch(BuildContext context) => showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Cari Mobil'),
      content: TextField(decoration: InputDecoration(hintText: 'Nama mobil...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: blue), child: const Text('Cari', style: TextStyle(color: Colors.white))),
      ],
    ),
  );

  void _showFilter(BuildContext context) => showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    builder: (_) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Urutkan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...['Rating', 'Termurah', 'Terbaru'].asMap().entries.map((e) => ListTile(
          title: Text(e.value),
          trailing: Radio(value: e.key, groupValue: 0, onChanged: (_) => Navigator.pop(context)),
          onTap: () => Navigator.pop(context),
        )),
      ]),
    ),
  );

  // DETAIL MOBIL
  void _showDetail(BuildContext context, Car c) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      child: Column(children: [
        Container(margin: const EdgeInsets.only(top: 8), width: 30, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
        Expanded(child: _detailContent(c)),
        _detailBottom(c),
      ]),
    ),
  );

  Widget _detailContent(Car c) => SingleChildScrollView(
    padding: const EdgeInsets.all(12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(c.image, height: 120, width: double.infinity, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(height: 120, color: Colors.grey[300], child: Center(child: Icon(_icon(c), size: 50, color: Colors.grey[600])))),
      ),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(c.brand, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(c.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            const Icon(Icons.star, color: Colors.amber, size: 14),
            const SizedBox(width: 2),
            Text(c.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ]),
        ),
      ]),
      const SizedBox(height: 8),
      _infoRow(Icons.people, '${c.seats} kursi', Icons.settings, c.transmission),
      _infoRow(Icons.local_gas_station, c.fuel, Icons.calendar_today, 'Tahun ${c.year}'),
      const SizedBox(height: 8),
      const Text('Deskripsi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text('Mobil ${c.brand} ${c.name} dengan ${c.seats} kursi. Transmisi ${c.transmission.toLowerCase()}, bahan bakar ${c.fuel}.',
          style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      const SizedBox(height: 12),
      const Text('Fasilitas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Wrap(spacing: 8, runSpacing: 8,
          children: ['AC Dingin', 'Audio', 'USB', 'Bagasi'].map((f) => _chipFacility(f)).toList()),
    ]),
  );

  Widget _infoRow(IconData i1, String t1, IconData i2, String t2) => Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [
      Icon(i1, size: 14, color: Colors.grey[600]), const SizedBox(width: 4), Text(t1, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      const SizedBox(width: 12),
      Icon(i2, size: 14, color: Colors.grey[600]), const SizedBox(width: 4), Text(t2, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
    ]),
  );

  Widget _detailBottom(Car c) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, -2))]),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Harga', style: TextStyle(fontSize: 10, color: Colors.grey)),
        Row(children: [
          Text('Rp${c.price}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: blue)),
          const Text('/hari', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ]),
      ]),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${c.name} disewa!'), backgroundColor: blue, behavior: SnackBarBehavior.floating));
        },
        style: ElevatedButton.styleFrom(backgroundColor: blue, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: const Text('Sewa', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    ]),
  );

  // REKOMENDASI
  void _showRecom(BuildContext context) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    builder: (_) => Container(
      height: 400,
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Rekomendasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ]),
        const SizedBox(height: 8),
        Expanded(child: GridView.custom(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 8, mainAxisSpacing: 8),
          childrenDelegate: SliverChildBuilderDelegate((_, i) {
            final c = cars[i % cars.length];
            return GestureDetector(
              onTap: () { Navigator.pop(context); _showDetail(context, c); },
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 2)]),
                child: Column(children: [
                  Expanded(flex: 3, child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.network(c.image, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: Colors.grey[300], child: Icon(_icon(c), size: 25, color: Colors.grey[600]))),
                  )),
                  Padding(padding: const EdgeInsets.all(4), child: Column(children: [
                    Text(c.name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('Rp${c.price}', style: TextStyle(fontSize: 9, color: blue)),
                  ])),
                ]),
              ),
            );
          }, childCount: 4),
        )),
      ]),
    ),
  );

  Widget _chipFacility(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
    child: Text(label, style: TextStyle(fontSize: 10, color: blue)),
  );
}