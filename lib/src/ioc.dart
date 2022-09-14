import 'package:mineral_ioc/src/exceptions/service_already_registered.dart';

/// The Container package is one of the core components of the Mineral framework, in fact it registers the entire application through its IOC.
class Ioc {
  static late Ioc _instance;
  final Map<String, dynamic> _services = {};

  static Ioc init () {
    Ioc._instance = Ioc();
    return Ioc._instance;
  }

  Map<String, dynamic> get services => _services;

  /// Registers a new service within the IOC.
  /// class MyService {}
  /// ioc.bind(namespace: 'Mineral/Services/MyService', MyService);
  void bind<T> ({ required String namespace, required T service }) {
    if (_services.containsKey(namespace)) {
      throw ServiceAlreadyRegistered();
    }

    _services.putIfAbsent(namespace, () => service);
  }

  /// Deletes a service registered in the
  /// ioc.remove('Mineral/Services/MyService');
  void remove (String namespace) {
    _services.remove(namespace);
  }

  /// Resolve the service instance from its namespace
  /// final myService = ioc.singleton('Mineral/Services/MyService');
  /// final myService = ioc.singleton<MyService>('Mineral/Services/MyService');
  T singleton<T extends dynamic> (String namespace) {
    return Ioc._instance._services[namespace] as T;
  }
}
