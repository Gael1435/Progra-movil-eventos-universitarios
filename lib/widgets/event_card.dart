import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> evento;
  final VoidCallback onPressed;

  const EventCard({
    super.key,
    required this.evento,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              evento['imagen'],
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.image_not_supported, size: 48),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              evento['titulo'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(26), // 0.1 * 255 = ~26
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                evento['categoria'],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Theme.of(context).hintColor),
                const SizedBox(width: 4),
                Text(evento['fecha'], style: TextStyle(color: Theme.of(context).hintColor)),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // TODO 1:
          // Agregar al diseño la hora, el lugar y el cupo del evento.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Theme.of(context).hintColor),
                const SizedBox(width: 4),
                Text(evento['hora'], style: TextStyle(color: Theme.of(context).hintColor)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Theme.of(context).hintColor),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    evento['lugar'],
                    style: TextStyle(color: Theme.of(context).hintColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.people, size: 16, color: Theme.of(context).hintColor),
                const SizedBox(width: 4),
                Text('Cupo: ${evento['cupo']} lugares', style: TextStyle(color: Theme.of(context).hintColor)),
              ],
            ),
          ),

          const Spacer(),

          // TODO 2:
          // Agregar un botón que permita registrarse o marcar
          // el evento como "Me interesa".
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Me interesa'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
