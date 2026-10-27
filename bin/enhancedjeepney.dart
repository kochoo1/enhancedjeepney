abstract class FareService {
  double calculateFare(int passengers);
}

// Mixin for maintenance records
mixin MaintenanceLog {
  void checkMaintenance() {
    print('Maintenance check completed.');
  }
}

// Base class from Week 9
class Jeepney {
  String route;
  int capacity;
  int _passengers;

  Jeepney(this.route, this.capacity, this._passengers);

  int get passengers => _passengers;

  void boardPassengers(int count) {
    if (count > 0 && _passengers + count <= capacity) {
      _passengers += count;
      print('$count passenger(s) boarded the $route jeepney.');
    } else {
      print(
        'Cannot board passengers. Capacity limit reached or invalid count.',
      );
    }
  }

  void displayInfo() {
    print('Route: $route');
    print('Capacity: $capacity');
    print('Current Passengers: $_passengers');
    print('Available Seats: ${capacity - _passengers}');
    print('---------------------------');
  }
}

// Derived class 1
class TraditionalJeepney extends Jeepney
    with MaintenanceLog
    implements FareService {
  TraditionalJeepney(String route, int capacity, int passengers)
    : super(route, capacity, passengers);

  @override
  void displayInfo() {
    print('=== TRADITIONAL JEEPNEY ===');
    super.displayInfo();
  }

  @override
  double calculateFare(int passengers) {
    return passengers * 13.0;
  }
}

// Derived class 2
class ModernJeepney extends Jeepney implements FareService {
  ModernJeepney(String route, int capacity, int passengers)
    : super(route, capacity, passengers);

  @override
  void displayInfo() {
    print('=== MODERN JEEPNEY ===');
    super.displayInfo();
  }

  @override
  double calculateFare(int passengers) {
    return passengers * 14.0;
  }
}

// Separate class using the same mixin
class MaintenanceStation with MaintenanceLog {
  String stationName;

  MaintenanceStation(this.stationName);

  void displayStation() {
    print('Maintenance Station: $stationName');
  }
}

void main() {
  TraditionalJeepney jeepney1 = TraditionalJeepney('Cubao - Divisoria', 20, 10);

  ModernJeepney jeepney2 = ModernJeepney('Quiapo - Baclaran', 15, 5);

  // Polymorphism using a list of base-class objects
  List<Jeepney> jeepneys = [jeepney1, jeepney2];

  print('=== JEEPNEY MANAGEMENT SYSTEM ===');

  for (Jeepney jeepney in jeepneys) {
    jeepney.displayInfo();
  }

  // Boarding passengers
  jeepney1.boardPassengers(5);
  jeepney2.boardPassengers(8);

  print('\n=== UPDATED JEEPNEY INFORMATION ===');

  for (Jeepney jeepney in jeepneys) {
    jeepney.displayInfo();
  }

  // Encapsulation through getter
  print('Passengers in first jeepney: ${jeepney1.passengers}');

  // Abstract interface implementation
  print('\n=== FARE CALCULATION ===');
  print(
    'Traditional Jeepney Fare: PHP ${jeepney1.calculateFare(jeepney1.passengers)}',
  );
  print(
    'Modern Jeepney Fare: PHP ${jeepney2.calculateFare(jeepney2.passengers)}',
  );

  // Mixin demonstration
  print('\n=== MAINTENANCE CHECK ===');
  jeepney1.checkMaintenance();

  MaintenanceStation station = MaintenanceStation('Quezon City Station');

  station.displayStation();
  station.checkMaintenance();
}
