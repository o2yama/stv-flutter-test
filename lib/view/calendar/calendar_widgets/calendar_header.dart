import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stv_test_app/common/app_theme.dart';
import 'package:stv_test_app/model/calendar_data_model/day_of_week.dart';
import 'package:stv_test_app/model/calendar_data_model/term.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';

class CalendarHeader extends HookWidget {
  const CalendarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);

    return SizedBox(
      height: 80,
      child: Column(children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(width: 1, color: Colors.grey[300]!),
                    ),
                  ),
                  onPressed: _calendarModel.moveCurrentDate,
                  child: const Text(
                    '今日',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              PopupMenuButton<DateTime>(
                initialValue: _calendarModel.targetMonth,
                itemBuilder: (context) => Term()
                    .values()
                    .map(
                      (date) => PopupMenuItem<DateTime>(
                        child: InkWell(
                          onTap: () {
                            _calendarModel.selectMonth(date);
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: Text(
                              DateFormat('yyyy年MM月').format(date),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                child: Row(children: [
                  Text(
                    DateFormat('yyyy年MM月 ').format(_calendarModel.targetMonth),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ]),
              ),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          color: AppTheme.backGroundColor,
          child: Row(
            children: day0fWeekLabel
                .map((date) => SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Center(
                        child: Text(
                          date,
                          style: TextStyle(
                            color: date == '日'
                                ? Colors.red
                                : date == '土'
                                    ? Colors.blue
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}
