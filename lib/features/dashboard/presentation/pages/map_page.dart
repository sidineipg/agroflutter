import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<LatLng> _polygonPoints = []; // Lista de pontos para o polígono
  double _areaInHectares = 0.0; // Área calculada em hectares

  /// Função para calcular a área do polígono em metros quadrados
  double _calculatePolygonArea(List<LatLng> points) {
    if (points.length < 3) return 0.0; // Um polígono precisa de pelo menos 3 pontos

    const double earthRadius = 6378137.0; // Raio da Terra em metros
    double area = 0.0;

    for (int i = 0; i < points.length; i++) {
      final LatLng p1 = points[i];
      final LatLng p2 = points[(i + 1) % points.length]; // Próximo ponto (ou o primeiro, se for o último ponto)

      final double x1 = p1.longitude * pi / 180.0 * earthRadius * cos(p1.latitude * pi / 180.0);
      final double y1 = p1.latitude * pi / 180.0 * earthRadius;
      final double x2 = p2.longitude * pi / 180.0 * earthRadius * cos(p2.latitude * pi / 180.0);
      final double y2 = p2.latitude * pi / 180.0 * earthRadius;

      area += (x1 * y2 - x2 * y1);
    }

    return area.abs() / 2.0; // Retorna a área em metros quadrados
  }

  /// Atualiza a área em hectares
  void _updateArea() {
    final double areaInSquareMeters = _calculatePolygonArea(_polygonPoints);
    setState(() {
      _areaInHectares = areaInSquareMeters / 10_000.0; // Converte m² para hectares
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapeamento e Cálculo de Área',style: TextStyle(fontSize: 16, color: Colors.grey),),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(-13.79231, -56.12374), // Centro inicial do mapa
              initialZoom: 15.0, // Nível de zoom inicial
              onTap: (tapPosition, point) {
                // Adiciona o ponto clicado à lista de pontos
                setState(() {
                  _polygonPoints.add(point);
                });
                _updateArea(); // Atualiza a área sempre que um ponto é adicionado
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // Fonte do mapa
                subdomains: ['a', 'b', 'c'],
              ),
              // Camada do polígono
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: _polygonPoints,
                    color: Colors.green.withAlpha((0.3 * 255).toInt()), // Cor do preenchimento
                    borderColor: Colors.green, // Cor da borda
                    borderStrokeWidth: 3.0, // Largura da borda
                  ),
                ],
              ),
              // Camada de marcadores
              MarkerLayer(
                markers: _polygonPoints
                    .map(
                      (point) => Marker(
                        point: point,
                        width: 80,
                        height: 80,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((0.8 * 255).toInt()),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Toque no mapa para marcar os pontos da área de colheita.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
          // Exibição da área em hectares
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.1 * 255).toInt()),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                'Área: ${_areaInHectares.toStringAsFixed(2)} hectares',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Limpa todos os pontos ao clicar no botão
          setState(() {
            _polygonPoints.clear();
            _areaInHectares = 0.0; // Reseta a área
          });
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),
    );
  }
}