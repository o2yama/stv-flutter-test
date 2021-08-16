import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stv_test_app/model/calendar_data_model/day_of_week.dart';
import 'package:stv_test_app/routing/app_routes.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/schedule_page/schedule_arguments.dart';
import 'package:stv_test_app/view/schedule_page/schedule_model.dart';

class DateTileWidget extends HookWidget {
  const DateTileWidget({required this.calendarDate, Key? key})
      : super(key: key);
  final CalendarDate calendarDate;

  @override
  Widget build(BuildContext context) {
    final _scheduleModel = useProvider(scheduleModelProvider);
    final _calendarModel = useProvider(calendarModelProvider);
    final date =
        DateTime(calendarDate.year, calendarDate.month, calendarDate.day);

    Widget _header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${DateFormat('yyyy/MM/dd').format(date)} '
            ' (${day0fWeekLabel[date.weekday - 1]})',
            style: const TextStyle(fontSize: 18),
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            onPressed: () {
              _calendarModel.hideDateListview();
              final selectedDate = DateTime(
                calendarDate.year,
                calendarDate.month,
                calendarDate.day,
              );
              _scheduleModel
                ..startEditing()
                ..start = selectedDate
                ..end = selectedDate
                ..clearText();
              Navigator.pushNamed(
                context,
                AppRoutes.scheduleDetail,
                arguments: ScheduleArguments(calendarDate: calendarDate),
              );
            },
            icon: const Icon(Icons.add, color: Colors.blue),
          ),
        ],
      );
    }

    Widget _scheduleCard(int index) {
      final schedule = calendarDate.schedules[index];
      return ListTile(
        onTap: () {
          _calendarModel.hideDateListview();
          _scheduleModel
            ..setSchedule(schedule)
            ..startEditing();
          Navigator.pushNamed(
            context,
            AppRoutes.scheduleDetail,
            arguments: ScheduleArguments(
                calendarDate: calendarDate,
                schedule: calendarDate.schedules[index]),
          );
        },
        title: Row(
          children: [
            SizedBox(
              width: 40,
              child: schedule.isAllDay
                  ? const Center(
                      child: Text(
                        '終日',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  : Column(children: [
                      Text(
                        DateFormat('hh:mm').format(schedule.start!),
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        DateFormat('hh:mm').format(schedule.end!),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ]),
            ),
            const SizedBox(width: 8),
            Container(width: 3, height: 50, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                schedule.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    Widget _scheduleListView() {
      return Expanded(
        child: calendarDate.schedules.isEmpty
            ? const Center(
                child: Text(
                  '予定がありません。',
                  style: TextStyle(fontSize: 12),
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => _scheduleCard(index),
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Colors.grey),
                itemCount: calendarDate.schedules.length,
              ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _header(),
              const Divider(color: Colors.grey, height: 1),
              _scheduleListView(),
            ],
          ),
        ),
      ),
    );
  }
}
