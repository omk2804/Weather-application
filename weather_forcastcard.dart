import 'package:flutter/material.dart';

class WeatherForcastcard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;

  const WeatherForcastcard({
    super.key,
    required this.time,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 125,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                time.toString(),
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Icon(
                icon,
                size: 45,
              ),
              Text(
                value,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfo(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 45,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 22),
            maxLines: 1,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
