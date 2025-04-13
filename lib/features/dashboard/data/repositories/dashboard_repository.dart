import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/product_info.dart';

class DashboardRepository {
  final String baseUrl;

  DashboardRepository(this.baseUrl);

  // Método para buscar os dados da API
  Future<ProductInfo> fetchDashboardData(String pTipo) async {
    final url = Uri.parse('$baseUrl/dashboard.php?tipo=$pTipo'); // Endpoint da API
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductInfo(
          quantity: data['quantity'] ?? '0',
          averageConsumption: data['averageConsumption'] ?? '0',
          productName: data['productName'] ?? '',
          percent: data['percent'] ?? '0',
          faturamento: data['faturamento'] ?? 'R\$ 0',
          tag: data['tag'] ?? '-',
          analise: data['analise'] ?? '-',
        );
      } else {
        throw Exception(
          'Erro ao buscar dados do Dashboard. Código: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }
}
