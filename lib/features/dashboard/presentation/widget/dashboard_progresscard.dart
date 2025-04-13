import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String product;
  final String percent;

  const ProgressCard({
    Key? key,
    required this.product,
    required this.percent, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timelapse, size: 18, color: Colors.orange),
                      SizedBox(width: 16),
                      Text(
                        'Andamento',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'A plantação de $product colhida até a data de hoje',
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              width: 96,
              height: 96,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 2, // Aumenta o tamanho do CircularProgressIndicator
                    child: CircularProgressIndicator(
                      value: int.parse(percent) / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}