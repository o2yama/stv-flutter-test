import 'package:stv_test_app/service/db.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';

class ScheduleArguments {
  ScheduleArguments({required this.calendarDate, this.schedule});

  final CalendarDate calendarDate;
  final Schedule? schedule;
}
