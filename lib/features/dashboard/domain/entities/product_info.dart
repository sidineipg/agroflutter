class ProductInfo { 
  final String quantity;       // Exemplo: 65 mil
  final String averageConsumption; // Exemplo: 83.0 (litros/hora) 
  final String productName; // Exemplo: "Soja"
  final String percent; // Exemplo: 65%

  final String faturamento; 
  final String tag; 
  final String analise; 

  const ProductInfo({ 
    required this.quantity,
    required this.averageConsumption,
    required this.productName,
    required this.percent,
    required this.faturamento,
    required this.tag,
    required this.analise,
  });

  @override
  String toString() {
    return 'ProductInfo(quantity: $quantity, averageConsumption: $averageConsumption)';
  }
}