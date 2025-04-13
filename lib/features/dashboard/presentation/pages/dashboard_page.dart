import 'package:flutter/material.dart';
import '../widget/dashboard_card.dart'; 
import '../widget/dashboard_progresscard.dart';
import 'filter_page.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../domain/entities/product_info.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardRepository _repository;
  ProductInfo? _productInfo;
  bool _isLoading = true;
  String? _errorMessage;

    //produto inicial mockado
  String machineName = 'MP9995';
  String machineImage = 'assets/img/MP9995.png';

  String productDetail = 'SACOS / 60KG SOJA';
  String productImage = 'assets/img/soja.png';

  @override
  void initState() {
    super.initState();
    _repository = DashboardRepository('https://spg.kinghost.net/agromock/api');
    _fetchData();
  }

  Future<void> _fetchData() async {
    try { 
      final data = await _repository.fetchDashboardData(machineName);
      setState(() {
        _productInfo = data;
        _isLoading = false;
      }); 
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      }); 
    }
  }




  void _openFilterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => FilterPage(
              selectedMachine: machineName,
              selectedProduct: productDetail,
              onMachineSelected: (String name, String image) {
                setState(() {
                  machineName = name;
                  machineImage = image;
                });
              },
              onProductSelected: (String name, String image) {
                setState(() {
                  productDetail = name;
                  productImage = image;
                });
              },
            ),
      ),

    );

    setState(() {
      _isLoading = true;  
    });
    _fetchData();  


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(child: Text('Erro: $_errorMessage'))
              : _buildDashboardContent(),
    );
  }

  Widget _buildDashboardContent() {
    if (_productInfo == null) return const Text('Nenhum dado disponível.');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Define bordas arredondadas
                  child: Image.asset(
                    'assets/img/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Bem vinda, ',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        'Joana',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Esperança do Oeste, ${DateTime.now().day}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: const [
                  Text(
                    '26°C',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.cloud, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _openFilterPage, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Filtro'),
                        ),

                        const Spacer(),
                        
                        ElevatedButton(
                          onPressed: () async {
                                    setState(() {
                                      _isLoading = true;  
                                    });
                                    await _fetchData();  
      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: 
                          Icon(Icons.refresh, size: 18, color: Colors.white),
                        ),
                      ],
                    ),



                    const SizedBox(height: 8),
                    DashboardCard(
                      title: 'Comercial',
                      subtitle: productDetail,
                      value: _productInfo?.quantity ?? '0',
                      description: 'Disponíveis para comercializar',
                      icon: Icons.shopping_cart,
                      iconColor: Colors.lightBlue,
                      imagePath: productImage,
                    ),
                    const SizedBox(height: 8),
                    DashboardCard(
                      title: 'Máquinas',
                      subtitle: 'Consumo médio',
                      value: machineName,
                      description: _productInfo?.averageConsumption ?? '0',
                      icon: Icons.agriculture,
                      iconColor: Colors.brown,
                      imagePath: machineImage,
                    ),
                    const SizedBox(height: 8),
                    DashboardCard(
                      title: 'Financeiro',
                      subtitle: _productInfo?.tag ?? '0',
                      value: _productInfo?.faturamento ?? '0',
                      description:
                          _productInfo?.analise ?? '0',
                          // 'A fazenda faturou mais em comparação ao mesmo período do ano passado',
                      icon: _productInfo?.tag == 'ALTA' 
                            ? Icons.trending_up 
                            : Icons.trending_down,
                      iconColor: _productInfo?.tag == 'ALTA' 
                            ? Colors.green
                            : Colors.red, 
                      imagePath: '',
                    ),
                    const SizedBox(height: 8),
                    ProgressCard(
                      product: _productInfo?.productName ?? '0',
                      percent: _productInfo?.percent ?? '0',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '@2025 - Demo desenvolvida pela SPG',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
