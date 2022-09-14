class ServiceAlreadyRegistered implements Exception {
  @override
  String toString () {
    return 'The service already exists within the IOC.';
  }
}
