import 'package:flutter/material.dart';

import '../data/event_data.dart';
import '../widgets/category_chip.dart';
import '../widgets/event_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String categoriaSeleccionada = 'Todos';

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Actualmente se muestran TODOS los eventos.
    //
    // El alumno debe modificar esta parte para que:
    //
    // - Si categoriaSeleccionada == 'Todos':
    //     se muestren todos los eventos.
    //
    // - Si se selecciona otra categoría:
    //     solamente aparezcan los eventos de esa categoría.
    //
    // Pista:
    // List.where(...).toList();

    final eventosMostrados = categoriaSeleccionada == 'Todos'
        ? eventos
        : eventos
            .where((evento) => evento['categoria'] == categoriaSeleccionada)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Eventos'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eventos Universitarios',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Descubre actividades académicas, culturales y deportivas.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categorias.length,
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];

                    return CategoryChip(
                      texto: categoria,
                      seleccionado: categoriaSeleccionada == categoria,
                      onTap: () {
                        setState(() {
                          categoriaSeleccionada = categoria;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Eventos encontrados: ${eventosMostrados.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Base responsiva
                    final columnas = constraints.maxWidth >= 1200
                        ? 5
                        : constraints.maxWidth >= 900
                            ? 4
                            : constraints.maxWidth >= 600
                                ? 3
                                : 1;
                    
                    // Modificar childAspectRatio dependiendo del ancho para evitar overflow
                    final isMobile = constraints.maxWidth < 600;

                    return GridView.builder(
                      itemCount: eventosMostrados.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnas,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: isMobile ? 0.62 : 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final evento = eventosMostrados[index];

                        return EventCard(
                          evento: evento,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Te has registrado al evento: ${evento['titulo']}'),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
