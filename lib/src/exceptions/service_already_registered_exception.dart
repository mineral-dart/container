class ServiceAlreadyRegisteredException implements Exception {
  final Type _service;

  ServiceAlreadyRegisteredException(this._service);

  @override
  String toString () {
    return 'The service $_service is already exists within the IOC.';
  }
}
