import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'date_list_index_state.dart';
import 'date_tile_widget.dart';

class DateListview extends HookWidget {
  const DateListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);
    final _index = useProvider<int>(dateListIndexProvider);

    return GestureDetector(
      onTap: _calendarModel.hideDateListview,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        body: Column(
          children: [
            const Expanded(child: SizedBox()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _calendarModel.calendarDateList.length,
                itemBuilder: (context, index) => DateTileWidget(
                    calendarDate: _calendarModel.calendarDateList[index]),
                initialScrollIndex: _index,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
