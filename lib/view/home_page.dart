import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/calendar/calendar.dart';

import 'date_listview/date_listview.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = useProvider(calendarModelProvider);

    return Stack(children: [
      const Calendar(),
      _model.isDateSlideShow ? const DateListview() : const SizedBox(),
    ]);
  }
}
