import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final Map<String, dynamic> evento;
  final VoidCallback onPressed;

  const EventCard({
    super.key,
    required this.evento,
    required this.onPressed,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _registrado = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(
              widget.evento['imagen'],
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
              widget.evento['titulo'],
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
                color: Theme.of(context).primaryColor.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.evento['categoria'],
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
                Text(widget.evento['fecha'], style: TextStyle(color: Theme.of(context).hintColor)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Theme.of(context).hintColor),
                const SizedBox(width: 4),
                Text(widget.evento['hora'], style: TextStyle(color: Theme.of(context).hintColor)),
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
                    widget.evento['lugar'],
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
                Text('Cupo: ${widget.evento['cupo']} lugares', style: TextStyle(color: Theme.of(context).hintColor)),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (!_registrado) {
                    setState(() {
                      _registrado = true;
                    });
                    widget.onPressed();
                  }
                },
                icon: Icon(
                  _registrado ? Icons.how_to_reg : Icons.check_circle_outline,
                ),
                label: Text(_registrado ? 'Registrado' : 'Registrarte'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: _registrado 
                      ? Colors.green 
                      : Theme.of(context).primaryColor,
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
