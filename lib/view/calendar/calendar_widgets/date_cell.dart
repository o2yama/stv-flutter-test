import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/service/db.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';
import 'package:stv_test_app/model/calendar_data_model/day_of_week.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/date_listview/date_list_index_state.dart';

class DateCell extends HookWidget {
  DateCell({required this.calendarDate, required this.allSchedules}) {
    calendarDate.schedules.clear();
    //渡ってきた全ての予定から、この日の予定のみを取得
    for (final schedule in allSchedules) {
      final _calendarDay =
          DateTime(calendarDate.year, calendarDate.month, calendarDate.day);
      final scheduleDay =
          DateTime(schedule.day.year, schedule.day.month, schedule.day.day);
      if (scheduleDay == _calendarDay) {
        calendarDate.schedules.add(schedule);
      }
    }
  }

  final List<Schedule> allSchedules;
  final CalendarDate calendarDate;

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);
    final _indexController = useProvider(dateListIndexProvider.notifier);

    Color dateColor() {
      if (!calendarDate.isEnabled) {
        return Colors.grey[300]!;
      } else if (calendarDate.dayOfWeek == DayOfWeek.saturday) {
        return Colors.blue;
      } else if (calendarDate.dayOfWeek == DayOfWeek.sunday) {
        return Colors.red;
      } else {
        return Colors.black;
      }
    }

    return Expanded(
      child: InkWell(
        onTap: () async {
          _indexController.setIndex(
              _calendarModel.calendarDateList, calendarDate);
          _calendarModel.showDateListview();
        },
        child: SizedBox(
          height: 70,
          child: Ink(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _calendarModel.isToday(calendarDate)
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          _calendarModel.isToday(calendarDate)
                              ? const CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                )
                              : Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                calendarDate.day.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            calendarDate.day.toString(),
                            style: TextStyle(color: dateColor(), fontSize: 12),
                          ),
                        ],
                      ),
                calendarDate.schedules.isNotEmpty
                    ? const Icon(
                        Icons.circle,
                        color: Colors.black,
                        size: 12,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
