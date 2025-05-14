import 'package:flutter/material.dart';

class SelectFarmPage extends StatelessWidget {
  const SelectFarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dados mockados das fazendas
    final farms = [
      {
        'name': 'Fazenda Esperança',
        'city': 'Esperança do Oeste',
        'state': 'PR',
        'responsible': 'Joana Silva',
        'phone': '(41) 99999-9999',
      },
      {
        'name': 'Fazenda Aurora',
        'city': 'Aurora do Norte',
        'state': 'MT',
        'responsible': 'Carlos Souza',
        'phone': '(65) 98888-8888',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Fazenda'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card 1
            SizedBox(
              width: double.infinity, // Define 100% da largura da tela
              child: FarmCard(
                name: farms[0]['name']!,
                city: farms[0]['city']!,
                state: farms[0]['state']!,
                responsible: farms[0]['responsible']!,
                phone: farms[0]['phone']!,
              ),
            ),
            const SizedBox(height: 16),
            // Card 2
            SizedBox(
              width: double.infinity, // Define 100% da largura da tela
              child: FarmCard(
                name: farms[1]['name']!,
                city: farms[1]['city']!,
                state: farms[1]['state']!,
                responsible: farms[1]['responsible']!,
                phone: farms[1]['phone']!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FarmCard extends StatelessWidget {
  final String name;
  final String city;
  final String state;
  final String responsible;
  final String phone;

  const FarmCard({
    Key? key,
    required this.name,
    required this.city,
    required this.state,
    required this.responsible,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cidade: $city, $state',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Responsável: $responsible',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Telefone: $phone',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}