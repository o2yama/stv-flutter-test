import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/common/app_theme.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/calendar/calendar_widgets/calendar_header.dart';
import 'calendar_widgets/monthly_calendar.dart';

class Calendar extends HookWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.backGroundColor,
      appBar: AppBar(title: const Text('カレンダー')),
      body: SingleChildScrollView(
        child: Column(children: [
          const CalendarHeader(),
          SizedBox(
            height: 500,
            child: _calendarModel.calendarWeekList.isEmpty
                ? Container()
                : PageView.builder(
                    onPageChanged: (pageNumber) async {
                      if (_calendarModel.currentPage < pageNumber) {
                        _calendarModel.moveNextMonth();
                      } else {
                        _calendarModel.movePreviousMonth();
                      }
                    },
                    controller: _calendarModel.pageController,
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    itemBuilder: (context, index) {
                      return MonthlyCalendar(
                        calendarWeekList: _calendarModel.calendarWeekList,
                      );
                    },
                  ),
          ),
        ]),
      ),
    );
  }
}
