

  import 'package:intl/intl.dart';

String getNumberFormat(double number) {

    final value = new NumberFormat("#,##0.00", "en_US");

    return value.format(number).toString();

  }