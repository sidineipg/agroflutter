import 'package:flutter/material.dart';

import 'package:agroflutter/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0; // Página atual

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Fundo com imagem
            Positioned.fill(
              child: Image.asset(
                'assets/img/farm_background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Sobreposição para contraste
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            // Conteúdo principal
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo e texto no topo
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/logo.png',
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Diretamente da terra',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Registre tudo direto do trabalho\ntudo na palma da mão.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Slider no rodapé
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160, // Altura do slider aumentada
                        child: PageView(
                          controller: _pageController,
                          children: [
                            // Primeira página
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Ação ao clicar no botão
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 30, 88, 136),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    minimumSize:
                                        const Size(double.infinity, 40),
                                  ),
                                  child: const Text(
                                    'Quero criar uma conta',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextButton(
                                  onPressed: () {
                                    _pageController.animateToPage(1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                  child: const Text(
                                    'Já tem uma conta no app.',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            // Segunda página
                            Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Login',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () {
                                    //abrir dashboard_page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DashboardPage(),  
                                      ),
                                    );
                                    
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 30, 88, 136),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    minimumSize:
                                        const Size(double.infinity, 40),
                                  ),
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Indicador do slider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  _currentPage == 0 ? Colors.blue : Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  _currentPage == 1 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}