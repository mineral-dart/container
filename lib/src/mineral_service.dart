import 'package:mineral_ioc/ioc.dart';

abstract class MineralService {
  Ioc container = ioc;

  MineralService({ bool inject = false }) {
    if (inject) {
      ioc.bind((ioc) => this);
    }
  }
}
