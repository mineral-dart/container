class ServiceNotExistException implements Exception {
  final Type _service;

  ServiceNotExistException(this._service);

  @override
  String toString () {
    return 'The service $_service doesn\'t exist on the IOC.';
  }
}
