import 'package:mineral_ioc/ioc.dart';
import 'package:mineral_ioc/src/exceptions/service_not_exist_exception.dart';

import './exceptions/service_already_registered_exception.dart';

/// The Container package is one of the core components of the Mineral framework, in fact it registers the entire application through its IOC.
class Ioc {
  static late Ioc _instance;
  final Map<Type, MineralService> _services = {};

  static Ioc init () {
    Ioc._instance = Ioc();
    return Ioc._instance;
  }

  Map<Type, MineralService> get services => _services;

  /// Registers a new service within the IOC.
  /// class MyService {}
  /// ```dart
  /// ioc.bind(namespace: 'Mineral/Services/MyService', MyService);
  /// ```
  void bind<T extends MineralService> (T Function(Ioc ioc) service) {
    if (_services.containsKey(service)) {
      throw ServiceAlreadyRegisteredException(T);
    }

    final T instance = service(this);

    _services.putIfAbsent(instance.runtimeType, () => instance);
  }

  /// Deletes a service registered in the
  /// /// ```dart
  /// ioc.remove('Mineral/Services/MyService');
  /// ```
  void remove<T extends MineralService> () {
    _services.remove(T);
  }

  /// Resolve the service instance from its namespace
  /// /// ```dart
  /// final myService = ioc.singleton('Mineral/Services/MyService');
  /// final myService = ioc.singleton<MyService>('Mineral/Services/MyService');
  /// ```
  T use<T extends MineralService> () {
    final service = Ioc._instance._services[T];

    if (service == null) {
      throw ServiceNotExistException(T);
    }
    return service as T;
  }
}
