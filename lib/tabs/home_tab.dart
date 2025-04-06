import 'package:flutter/material.dart';
import 'dart:math';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Map<String, dynamic>> allStockData = [
    {'symbol': 'RELIANCE', 'price': 2740.50, 'change': 15.30},
    {'symbol': 'TCS', 'price': 3625.20, 'change': -10.25},
    {'symbol': 'INFY', 'price': 1472.85, 'change': 6.90},
    {'symbol': 'HDFCBANK', 'price': 1518.10, 'change': -8.70},
    {'symbol': 'ICICIBANK', 'price': 1023.35, 'change': 2.45},
    {'symbol': 'SBIN', 'price': 590.00, 'change': 3.10},
    {'symbol': 'WIPRO', 'price': 410.75, 'change': -4.20},
  ];

  List<Map<String, dynamic>> filteredStockData = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStockData = List.from(allStockData);
  }

  void refreshStockData() {
    final random = Random();
    setState(() {
      allStockData = allStockData.map((stock) {
        double newChange = (random.nextDouble() * 20 - 10);
        double newPrice = stock['price'] + newChange;
        return {
          'symbol': stock['symbol'],
          'price': double.parse(newPrice.toStringAsFixed(2)),
          'change': double.parse(newChange.toStringAsFixed(2)),
        };
      }).toList();

      filterSearchResults(_searchController.text);
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStockData = List.from(allStockData);
      } else {
        filteredStockData = allStockData
            .where((stock) =>
                stock['symbol'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A₹thaगुरू Home'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Stocks',
            onPressed: refreshStockData,
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: filterSearchResults,
              decoration: InputDecoration(
                hintText: 'Search for a stock (e.g. TCS, RELIANCE)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),

          // 📈 Stock list
          Expanded(
            child: ListView.builder(
              itemCount: filteredStockData.length,
              itemBuilder: (context, index) {
                final stock = filteredStockData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(
                      stock['change'] >= 0
                          ? Icons.trending_up
                          : Icons.trending_down,
                      color: stock['change'] >= 0 ? Colors.green : Colors.red,
                    ),
                    title: Text(stock['symbol'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('₹ ${stock['price']}'),
                    trailing: Text(
                      '${stock['change'] >= 0 ? '+' : ''}${stock['change']}',
                      style: TextStyle(
                        color:
                            stock['change'] >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
