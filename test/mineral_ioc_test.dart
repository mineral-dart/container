import 'package:mineral_ioc/ioc.dart';
import 'package:mineral_ioc/src/exceptions/service_already_registered.dart';
import 'package:test/test.dart';

class MyService {}

void main() {
  final String namespace = 'Mineral/Services/MyService';

  test('can inject service', () {
    ioc.bind(namespace: namespace, service: MyService);

    expect(ioc.services.keys.first, equals(namespace));
    expect(ioc.services.length, equals(1));
  });

  test('can\'t registered two services with the same namespace', () {
    try {
      ioc.bind(namespace: namespace, service: MyService);
    } on Exception catch(error) {
      expect(error.runtimeType, equals(ServiceAlreadyRegistered));
    }
  });

  test('can get registered services', () {
    expect(ioc.services.length, equals(1));
  });

  test('can remove service', () {
    ioc.remove(namespace);
    expect(ioc.services.length, equals(0));
  });
}
