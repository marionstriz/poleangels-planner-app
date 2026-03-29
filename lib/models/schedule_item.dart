class ScheduleItem {
  final String id;
  final String className;
  final String day;
  final String time;
  final String duration;
  final String instructor;
  final String level;

  const ScheduleItem({
    required this.id,
    required this.className,
    required this.day,
    required this.time,
    required this.duration,
    required this.instructor,
    required this.level,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      id: json['id'] as String,
      className: json['className'] as String,
      day: json['day'] as String,
      time: json['time'] as String,
      duration: json['duration'] as String,
      instructor: json['instructor'] as String,
      level: json['level'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'className': className,
        'day': day,
        'time': time,
        'duration': duration,
        'instructor': instructor,
        'level': level,
      };
}
