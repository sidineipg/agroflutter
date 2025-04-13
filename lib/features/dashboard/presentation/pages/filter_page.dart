import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final String selectedMachine;
  final String selectedProduct;
  final Function(String, String) onMachineSelected;
  final Function(String, String) onProductSelected;

  const FilterPage({
    super.key,
    required this.selectedMachine,
    required this.selectedProduct,
    required this.onMachineSelected,
    required this.onProductSelected,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late String _currentMachine;
  late String _currentProduct;

  @override
  void initState() {
    super.initState();
    _currentMachine = widget.selectedMachine;
    _currentProduct = widget.selectedProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Filtros'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // Seção 2: Tipos de Soja
          const Text(
            'Tipos de Produto',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(
              _currentProduct == 'SACOS / 60KG SOJA'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: Colors.green,
            ),
            title: const Text(
              'SACOS / 60KG SOJA',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              setState(() {
                _currentProduct = 'SACOS / 60KG SOJA';
              });
              widget.onProductSelected('SACOS / 60KG SOJA', 'assets/img/soja.png');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              _currentProduct == 'SACOS / 60KG SOJA Tipo 2'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: Colors.green,
            ),
            title: const Text(
              'SACOS / 60KG SOJA Tipo 2',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              setState(() {
                _currentProduct = 'SACOS / 60KG SOJA Tipo 2';
              });
              widget.onProductSelected('SACOS / 60KG SOJA Tipo 2', 'assets/img/sojaT2.png');
              Navigator.pop(context);
            },
          ),



           const Divider(), // Linha divisória entre as seções



           // Seção 1: Máquinas
          const Text(
            'Máquinas',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(
              _currentMachine == 'S790'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: Colors.green,
            ),
            title: const Text(
              'S790 John Deere',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              setState(() {
                _currentMachine = 'S790';
              });
              widget.onMachineSelected('S790', 'assets/img/S790.png');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              _currentMachine == 'MP9995'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: Colors.green,
            ),
            title: const Text(
              'MP9995 Massey Ferguson',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              setState(() {
                _currentMachine = 'MP9995';
              });
              widget.onMachineSelected('MP9995', 'assets/img/MP9995.png');
              Navigator.pop(context);
            },
          ),



        ],
      ),
    );
  }
}