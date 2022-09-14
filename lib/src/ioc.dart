class Ioc {
  static late Ioc _instance;
  final Map<String, dynamic> _services = {};

  static Ioc init () {
    Ioc._instance = Ioc();
    return Ioc._instance;
  }

  Map<String, dynamic> get services => _services;

  void bind<T> ({ required String namespace, required T service }) {
    _services.putIfAbsent(namespace, () => service);
  }

  void remove (String namespace) {
    _services.remove(namespace);
  }

  T singleton<T extends dynamic> (String namespace) {
    return Ioc._instance._services[namespace] as T;
  }
}
