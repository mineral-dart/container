import 'package:mineral_ioc/ioc.dart';
import 'package:mineral_ioc/src/exceptions/service_already_registered_exception.dart';
import 'package:mineral_ioc/src/exceptions/service_not_exist_exception.dart';
import 'package:test/test.dart';

class MyService extends MineralService {}

void main() {
  final instance = MyService();

  test('can inject service', () {
    ioc.bind((_) => instance);

    expect(ioc.services.keys.first, equals(MyService));
    expect(ioc.services.length, equals(1));
  });

  test('can\'t registered two services with the same namespace', () {
    try {
      ioc.bind((_) => MyService());
    } on Exception catch(error) {
      expect(error.runtimeType, equals(ServiceAlreadyRegisteredException));
    }
  });
  
  test('can get one registered service', () {
    expect(ioc.use<MyService>(), equals(instance));
  });

  test('can get registered services', () {
    expect(ioc.services.length, equals(1));
  });

  test('can remove service', () {
    ioc.remove<MyService>();
    expect(ioc.services.length, equals(0));
  });

  test('cannot get unregistered service', () {
    try {
      ioc.use<MyService>();
    } on Exception catch(error) {
      expect(error.runtimeType, equals(ServiceNotExistException));
    }
  });
}
