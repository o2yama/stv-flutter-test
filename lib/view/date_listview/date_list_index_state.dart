import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';

final dateListIndexProvider = StateNotifierProvider<DateListIndexState, int>(
    (ref) => DateListIndexState());

class DateListIndexState extends StateNotifier<int> {
  DateListIndexState() : super(0);

  void setIndex(
      List<CalendarDate> calendarDateList, CalendarDate calendarDate) {
    calendarDateList.asMap().forEach((index, value) {
      if (calendarDate == value) {
        state = index;
      }
    });
  }
}
