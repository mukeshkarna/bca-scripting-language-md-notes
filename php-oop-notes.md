# Object Oriented Programming in PHP

## Introduction to OOP in PHP

Object-Oriented Programming (OOP) is a programming paradigm that uses "objects" to design applications and organize code. PHP has supported OOP features since PHP 4, with significant improvements in PHP 5 and later versions.

## Classes and Objects

### Classes
A class is a blueprint or template that defines the characteristics and behaviors of all objects of a specific kind.

```php
// Class definition
class User {
    // Class code goes here
}
```

### Objects
An object is an instance of a class. When a class is defined, no memory is allocated until an object is instantiated.

```php
// Creating an object (instance) of a class
$user = new User();
```

## Properties and Methods

### Properties (Attributes)
Properties are variables that belong to a class. They define the characteristics of objects.

```php
class User {
    // Properties
    public $username;
    public $email;
    private $password;
}

// Accessing properties
$user = new User();
$user->username = "johnsmith";
$user->email = "john@example.com";
```

### Methods
Methods are functions that belong to a class. They define the behaviors of objects.

```php
class User {
    // Properties
    public $username;
    public $email;
    private $password;
    
    // Method
    public function login() {
        echo "User {$this->username} logged in successfully";
    }
    
    public function setPassword($password) {
        $this->password = password_hash($password, PASSWORD_DEFAULT);
    }
    
    public function verifyPassword($password) {
        return password_verify($password, $this->password);
    }
}

// Using methods
$user = new User();
$user->username = "johnsmith";
$user->setPassword("secret123");
$user->login();
```

## Constructors and Destructors

### Constructors
A constructor is a special method that is automatically called when an object is created. It's used to initialize object properties.

```php
class User {
    public $username;
    public $email;
    private $password;
    
    // Constructor
    public function __construct($username, $email) {
        $this->username = $username;
        $this->email = $email;
        echo "User object created with username: {$this->username}";
    }
    
    // Methods
    public function login() {
        echo "User {$this->username} logged in successfully";
    }
}

// Constructor is called automatically when object is created
$user = new User("johnsmith", "john@example.com");
```

### Destructors
A destructor is a special method that is automatically called when an object is destroyed (when script ends or when object is unset).

```php
class User {
    public $username;
    
    public function __construct($username) {
        $this->username = $username;
        echo "User object created: {$this->username}\n";
    }
    
    public function __destruct() {
        echo "User object destroyed: {$this->username}\n";
    }
}

$user1 = new User("johnsmith");
$user2 = new User("janedoe");

unset($user1); // Explicitly destroy $user1 object, calling its destructor

// $user2's destructor will be called when script ends
```

## Method Overriding

Method overriding occurs when a child class provides a specific implementation of a method that is already defined in its parent class.

```php
class Vehicle {
    public function start() {
        echo "Vehicle started\n";
    }
}

class Car extends Vehicle {
    // Override the start method
    public function start() {
        echo "Car engine started\n";
    }
}

class Bicycle extends Vehicle {
    // Override the start method
    public function start() {
        echo "Start pedaling the bicycle\n";
    }
}

$vehicle = new Vehicle();
$car = new Car();
$bicycle = new Bicycle();

$vehicle->start(); // Output: Vehicle started
$car->start();     // Output: Car engine started
$bicycle->start(); // Output: Start pedaling the bicycle
```

## Encapsulation

Encapsulation is the concept of bundling data (properties) and methods that operate on the data within a single unit (class) and restricting direct access to some of the object's components.

```php
class BankAccount {
    private $accountNumber;
    private $balance;
    
    public function __construct($accountNumber, $initialBalance) {
        $this->accountNumber = $accountNumber;
        $this->balance = $initialBalance;
    }
    
    public function getAccountNumber() {
        return $this->accountNumber;
    }
    
    public function getBalance() {
        return $this->balance;
    }
    
    public function deposit($amount) {
        if ($amount > 0) {
            $this->balance += $amount;
            return true;
        }
        return false;
    }
    
    public function withdraw($amount) {
        if ($amount > 0 && $amount <= $this->balance) {
            $this->balance -= $amount;
            return true;
        }
        return false;
    }
}

$account = new BankAccount("123456789", 1000);
echo "Account Number: " . $account->getAccountNumber() . "\n";
echo "Initial Balance: $" . $account->getBalance() . "\n";

$account->deposit(500);
echo "Balance after deposit: $" . $account->getBalance() . "\n";

$account->withdraw(200);
echo "Balance after withdrawal: $" . $account->getBalance() . "\n";
```

## Inheritance

Inheritance allows a class to inherit properties and methods from another class. This promotes code reusability.

```php
class Person {
    protected $name;
    protected $age;
    
    public function __construct($name, $age) {
        $this->name = $name;
        $this->age = $age;
    }
    
    public function introduce() {
        echo "My name is {$this->name} and I am {$this->age} years old.\n";
    }
}

class Student extends Person {
    private $studentId;
    
    public function __construct($name, $age, $studentId) {
        parent::__construct($name, $age); // Call parent constructor
        $this->studentId = $studentId;
    }
    
    public function introduce() {
        parent::introduce(); // Call parent method
        echo "I am a student with ID: {$this->studentId}\n";
    }
}

class Teacher extends Person {
    private $subject;
    
    public function __construct($name, $age, $subject) {
        parent::__construct($name, $age);
        $this->subject = $subject;
    }
    
    public function introduce() {
        parent::introduce();
        echo "I teach {$this->subject}\n";
    }
}

$student = new Student("John", 20, "S12345");
$teacher = new Teacher("Jane", 35, "Computer Science");

$student->introduce();
$teacher->introduce();
```

## Polymorphism

Polymorphism allows objects of different classes to be treated as objects of a common superclass. It's often achieved through method overriding and interfaces.

```php
interface Shape {
    public function calculateArea();
}

class Circle implements Shape {
    private $radius;
    
    public function __construct($radius) {
        $this->radius = $radius;
    }
    
    public function calculateArea() {
        return pi() * $this->radius * $this->radius;
    }
}

class Rectangle implements Shape {
    private $width;
    private $height;
    
    public function __construct($width, $height) {
        $this->width = $width;
        $this->height = $height;
    }
    
    public function calculateArea() {
        return $this->width * $this->height;
    }
}

class Triangle implements Shape {
    private $base;
    private $height;
    
    public function __construct($base, $height) {
        $this->base = $base;
        $this->height = $height;
    }
    
    public function calculateArea() {
        return 0.5 * $this->base * $this->height;
    }
}

// Polymorphic function that works with any Shape
function printArea(Shape $shape) {
    echo "Area: " . $shape->calculateArea() . "\n";
}

$circle = new Circle(5);
$rectangle = new Rectangle(4, 6);
$triangle = new Triangle(3, 8);

printArea($circle);     // Area: 78.539816339745
printArea($rectangle);  // Area: 24
printArea($triangle);   // Area: 12
```

## Static Members

Static properties and methods belong to the class, not to objects. They can be accessed without creating an instance of the class.

```php
class MathUtility {
    // Static property
    public static $pi = 3.14159;
    
    // Static method
    public static function square($number) {
        return $number * $number;
    }
    
    public static function cube($number) {
        return $number * $number * $number;
    }
}

// Accessing static property and methods without creating an object
echo "Value of PI: " . MathUtility::$pi . "\n";
echo "Square of 5: " . MathUtility::square(5) . "\n";
echo "Cube of 3: " . MathUtility::cube(3) . "\n";

// Static methods can also be used for utility functions
class DateUtility {
    public static function getCurrentYear() {
        return date('Y');
    }
    
    public static function formatDate($date, $format = 'Y-m-d') {
        return date($format, strtotime($date));
    }
}

echo "Current year: " . DateUtility::getCurrentYear() . "\n";
echo "Formatted date: " . DateUtility::formatDate("2023-04-15", "F j, Y") . "\n";
```

## Exception Handling

Exception handling is a way to handle runtime errors in a structured way, making code more robust.

```php
class DivisionByZeroException extends Exception {
    public function __construct($message = "Division by zero is not allowed", $code = 0) {
        parent::__construct($message, $code);
    }
}

class Calculator {
    public function divide($dividend, $divisor) {
        if ($divisor == 0) {
            throw new DivisionByZeroException();
        }
        return $dividend / $divisor;
    }
}

$calculator = new Calculator();

try {
    echo "10 / 2 = " . $calculator->divide(10, 2) . "\n";
    echo "10 / 0 = " . $calculator->divide(10, 0) . "\n"; // This will throw an exception
} catch (DivisionByZeroException $e) {
    echo "Error: " . $e->getMessage() . "\n";
} catch (Exception $e) {
    echo "General error: " . $e->getMessage() . "\n";
} finally {
    echo "This code will always run, regardless of an exception\n";
}

// More complex example with custom exceptions
class DatabaseException extends Exception {}
class ConnectionException extends DatabaseException {}
class QueryException extends DatabaseException {}

class Database {
    private $connection;
    
    public function connect($host, $username, $password) {
        if ($host == "localhost" && $username == "root") {
            $this->connection = true;
            return true;
        } else {
            throw new ConnectionException("Failed to connect to database");
        }
    }
    
    public function query($sql) {
        if (!$this->connection) {
            throw new ConnectionException("Not connected to database");
        }
        
        if (empty($sql)) {
            throw new QueryException("Empty SQL query");
        }
        
        // Simulate a syntax error in SQL
        if (strpos($sql, "SELECT") === false) {
            throw new QueryException("Invalid SQL query: {$sql}");
        }
        
        return "Query executed successfully";
    }
}

$db = new Database();

try {
    // Try to connect
    $db->connect("localhost", "root");
    
    // Try to execute a query
    echo $db->query("SELECT * FROM users") . "\n";
    
    // This will throw an exception
    echo $db->query("DELETE FROM users") . "\n";
    
} catch (ConnectionException $e) {
    echo "Connection error: " . $e->getMessage() . "\n";
} catch (QueryException $e) {
    echo "Query error: " . $e->getMessage() . "\n";
} catch (DatabaseException $e) {
    echo "Database error: " . $e->getMessage() . "\n";
} catch (Exception $e) {
    echo "General error: " . $e->getMessage() . "\n";
}
```

## Access Modifiers

Access modifiers control the visibility of properties and methods.

| Modifier | Description |
|----------|-------------|
| `public` | Accessible from anywhere |
| `protected` | Accessible within the class and child classes |
| `private` | Accessible only within the class |

```php
class User {
    public $username;      // Accessible from anywhere
    protected $email;      // Accessible within this class and child classes
    private $password;     // Accessible only within this class
    
    public function __construct($username, $email, $password) {
        $this->username = $username;
        $this->email = $email;
        $this->password = $password;
    }
    
    public function getEmail() {
        return $this->email;
    }
    
    protected function getPasswordHash() {
        return password_hash($this->password, PASSWORD_DEFAULT);
    }
    
    private function validatePassword() {
        return strlen($this->password) >= 8;
    }
    
    public function register() {
        if ($this->validatePassword()) {
            echo "User registered with hash: " . $this->getPasswordHash();
            return true;
        } else {
            echo "Password too short";
            return false;
        }
    }
}

class Admin extends User {
    public function __construct($username, $email, $password) {
        parent::__construct($username, $email, $password);
    }
    
    public function displayInfo() {
        echo "Username: {$this->username}\n";
        echo "Email: {$this->email}\n"; // Can access protected property
        // echo "Password: {$this->password}\n"; // Error! Can't access private property
        
        // Can call protected method
        echo "Password hash: " . $this->getPasswordHash() . "\n";
        
        // Can't call private method
        // $this->validatePassword(); // This would cause an error
    }
}

$user = new User("john", "john@example.com", "password123");
echo $user->username . "\n"; // Works (public)
// echo $user->email; // Error (protected)
// echo $user->password; // Error (private)

$admin = new Admin("admin", "admin@example.com", "admin123");
$admin->displayInfo();
```

## Type Hinting

Type hinting allows you to specify the expected data type of a function argument or return value.

```php
class Person {
    private $name;
    
    public function __construct(string $name) {
        $this->name = $name;
    }
    
    public function getName(): string {
        return $this->name;
    }
}

class Employee {
    private $position;
    
    public function __construct(string $position) {
        $this->position = $position;
    }
    
    public function getPosition(): string {
        return $this->position;
    }
}

class Company {
    private $employees = [];
    
    public function addEmployee(Person $person, Employee $employee): void {
        $this->employees[$person->getName()] = $employee->getPosition();
    }
    
    public function getEmployees(): array {
        return $this->employees;
    }
}

$person = new Person("John Smith");
$employee = new Employee("Developer");

$company = new Company();
$company->addEmployee($person, $employee);

$employees = $company->getEmployees();
foreach ($employees as $name => $position) {
    echo "{$name}: {$position}\n";
}
```

## Traits

Traits are a mechanism for code reuse in single inheritance languages like PHP. A trait is intended to reduce some limitations of single inheritance by enabling a developer to reuse sets of methods freely in several independent classes.

```php
trait Logger {
    private $logFile = 'application.log';
    
    public function log($message) {
        $timestamp = date('Y-m-d H:i:s');
        $logMessage = "[$timestamp] $message\n";
        file_put_contents($this->logFile, $logMessage, FILE_APPEND);
    }
    
    public function setLogFile($filename) {
        $this->logFile = $filename;
    }
}

trait FileStorage {
    public function saveToFile($data, $filename) {
        return file_put_contents($filename, serialize($data));
    }
    
    public function loadFromFile($filename) {
        return unserialize(file_get_contents($filename));
    }
}

class User {
    use Logger, FileStorage;
    
    private $username;
    private $email;
    
    public function __construct($username, $email) {
        $this->username = $username;
        $this->email = $email;
        $this->log("User created: $username");
    }
    
    public function save() {
        $this->log("Saving user: {$this->username}");
        return $this->saveToFile($this, "users/{$this->username}.dat");
    }
}

class Product {
    use Logger;
    
    private $name;
    private $price;
    
    public function __construct($name, $price) {
        $this->name = $name;
        $this->price = $price;
        $this->setLogFile('products.log'); // Changing log file from the trait
        $this->log("Product created: $name, Price: $price");
    }
}

$user = new User("johnsmith", "john@example.com");
$product = new Product("Laptop", 999.99);
```

## Abstract Classes and Methods

Abstract classes cannot be instantiated. They can contain a mixture of abstract and regular methods. Abstract methods must be implemented by any concrete subclass.

```php
abstract class Vehicle {
    protected $brand;
    
    public function __construct($brand) {
        $this->brand = $brand;
    }
    
    // Regular method
    public function getBrand() {
        return $this->brand;
    }
    
    // Abstract method - must be implemented by subclasses
    abstract public function getType();
    
    // Abstract method with parameters
    abstract public function calculateSpeed($distance, $time);
}

class Car extends Vehicle {
    private $model;
    
    public function __construct($brand, $model) {
        parent::__construct($brand);
        $this->model = $model;
    }
    
    public function getType() {
        return "Car";
    }
    
    public function calculateSpeed($distance, $time) {
        return $distance / $time;
    }
    
    public function getModel() {
        return $this->model;
    }
}

class Motorcycle extends Vehicle {
    public function getType() {
        return "Motorcycle";
    }
    
    public function calculateSpeed($distance, $time) {
        return $distance / $time;
    }
}

// This would cause an error - can't instantiate abstract class
// $vehicle = new Vehicle("Generic");

$car = new Car("Toyota", "Corolla");
echo $car->getBrand() . " " . $car->getModel() . "\n";
echo "Type: " . $car->getType() . "\n";
echo "Speed: " . $car->calculateSpeed(100, 2) . " km/h\n";

$motorcycle = new Motorcycle("Honda");
echo $motorcycle->getBrand() . "\n";
echo "Type: " . $motorcycle->getType() . "\n";
echo "Speed: " . $motorcycle->calculateSpeed(100, 1.5) . " km/h\n";
```

## Interfaces

An interface is a contract that specifies what methods a class must implement. Interfaces can't contain properties or method implementations.

```php
interface DatabaseInterface {
    public function connect($host, $username, $password, $database);
    public function query($sql);
    public function fetch();
    public function close();
}

class MySQLDatabase implements DatabaseInterface {
    private $connection;
    private $result;
    
    public function connect($host, $username, $password, $database) {
        // MySQL specific connection code
        $this->connection = new mysqli($host, $username, $password, $database);
        return $this->connection->connect_errno === 0;
    }
    
    public function query($sql) {
        $this->result = $this->connection->query($sql);
        return $this->result !== false;
    }
    
    public function fetch() {
        return $this->result->fetch_assoc();
    }
    
    public function close() {
        $this->connection->close();
    }
}

class PostgreSQLDatabase implements DatabaseInterface {
    private $connection;
    private $result;
    
    public function connect($host, $username, $password, $database) {
        // PostgreSQL specific connection code
        $this->connection = pg_connect("host=$host dbname=$database user=$username password=$password");
        return $this->connection !== false;
    }
    
    public function query($sql) {
        $this->result = pg_query($this->connection, $sql);
        return $this->result !== false;
    }
    
    public function fetch() {
        return pg_fetch_assoc($this->result);
    }
    
    public function close() {
        pg_close($this->connection);
    }
}

// Function that works with any database that implements the interface
function getUserData(DatabaseInterface $db, $userId) {
    $db->query("SELECT * FROM users WHERE id = $userId");
    return $db->fetch();
}

// Usage
$mysql = new MySQLDatabase();
$mysql->connect("localhost", "root", "password", "test_db");
$user = getUserData($mysql, 1);
var_dump($user);
$mysql->close();

$postgres = new PostgreSQLDatabase();
$postgres->connect("localhost", "postgres", "password", "test_db");
$user = getUserData($postgres, 1);
var_dump($user);
$postgres->close();
```

## Namespaces

Namespaces help to organize and group related classes, functions, and constants to avoid naming conflicts.

```php
// File: Utility/Math.php
namespace Utility;

class Math {
    public static function add($a, $b) {
        return $a + $b;
    }
    
    public static function subtract($a, $b) {
        return $a - $b;
    }
}

// File: Geometry/Math.php
namespace Geometry;

class Math {
    public static function calculateCircleArea($radius) {
        return pi() * $radius * $radius;
    }
    
    public static function calculateRectangleArea($width, $height) {
        return $width * $height;
    }
}

// Using namespaced classes
require_once 'Utility/Math.php';
require_once 'Geometry/Math.php';

// Fully qualified names
echo \Utility\Math::add(5, 3) . "\n";
echo \Geometry\Math::calculateCircleArea(5) . "\n";

// Using namespace
use Utility\Math as UtilityMath;
use Geometry\Math as GeometryMath;

echo UtilityMath::subtract(10, 4) . "\n";
echo GeometryMath::calculateRectangleArea(5, 10) . "\n";
```

## Magic Methods

PHP provides special methods that start with double underscore (`__`). These are called magic methods and are triggered automatically in specific situations.

```php
class Product {
    private $data = [];
    
    // Called when creating an object
    public function __construct($name, $price) {
        $this->data['name'] = $name;
        $this->data['price'] = $price;
        $this->data['created_at'] = date('Y-m-d H:i:s');
    }
    
    // Called when object is treated as a string
    public function __toString() {
        return $this->data['name'] . ": $" . $this->data['price'];
    }
    
    // Called when accessing non-existing properties
    public function __get($name) {
        if (array_key_exists($name, $this->data)) {
            return $this->data[$name];
        }
        return null;
    }
    
    // Called when setting non-existing properties
    public function __set($name, $value) {
        $this->data[$name] = $value;
    }
    
    // Called when checking if property isset() or empty()
    public function __isset($name) {
        return isset($this->data[$name]);
    }
    
    // Called when unsetting a property
    public function __unset($name) {
        unset($this->data[$name]);
    }
    
    // Called when invoking object as a function
    public function __invoke($quantity = 1) {
        return $this->data['price'] * $quantity;
    }
    
    // Called when object is serialized
    public function __sleep() {
        // Return only the properties we want to serialize
        return ['name', 'price'];
    }
    
    // Called when object is unserialized
    public function __wakeup() {
        $this->data['created_at'] = date('Y-m-d H:i:s');
        $this->data['restored'] = true;
    }
    
    // Called when cloning an object
    public function __clone() {
        $this->data['created_at'] = date('Y-m-d H:i:s');
        $this->data['name'] = "Copy of " . $this->data['name'];
    }
    
    // Returns data for var_dump()
    public function __debugInfo() {
        return [
            'name' => $this->data['name'],
            'price' => $this->data['price'],
            'created' => $this->data['created_at']
        ];
    }
}

$product = new Product("Laptop", 999.99);

// __toString()
echo $product . "\n";

// __get()
echo "Name: " . $product->name . "\n";
echo "Created at: " . $product->created_at . "\n";

// __set()
$product->color = "Silver";
echo "Color: " . $product->color . "\n";

// __isset()
echo "Has color? " . (isset($product->color) ? "Yes" : "No") . "\n";
echo "Has weight? " . (isset($product->weight) ? "Yes" : "No") . "\n";

// __unset()
unset($product->color);
echo "Has color after unset? " . (isset($product->color) ? "Yes" : "No") . "\n";

// __invoke()
echo "Price for 3 items: $" . $product(3) . "\n";

// __sleep() and __wakeup()
$serialized = serialize($product);
echo "Serialized: " . $serialized . "\n";
$newProduct = unserialize($serialized);
echo "Unserialized: " . $newProduct . "\n";
echo "Restored flag: " . ($newProduct->restored ? "Yes" : "No") . "\n";

// __clone()
$clonedProduct = clone $product;
echo "Original: " . $product . "\n";
echo "Clone: " . $clonedProduct . "\n";

// __debugInfo()
var_dump($product);
```

## Final Classes and Methods

Final classes cannot be extended, and final methods cannot be overridden in child classes.

```php
final class Config {
    private static $instance;
    private $settings = [];
    
    private function __construct() {
        // Private constructor to prevent direct creation
        $this->settings = [
            'db_host' => 'localhost',
            'db_user' => 'root',
            'db_pass' => 'password'
        ];
    }
    
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    public function get($key) {
        return isset($this->settings[$key]) ? $this->settings[$key] : null;
    }
    
    public function set($key, $value) {
        $this->settings[$key] = $value;
    }
}

class Person {
    protected $name;
    
    public function __construct($name) {
        $this->name = $name;
    }
    
    public function getName() {
        return $this->name;
    }
    
    final public function getType() {
        return "Person";
    }
}

class Employee extends Person {
    private $position;
    
    public function __construct($name, $position) {
        parent::__construct($name);
        $this->position = $position;
    }
    
    public function getPosition() {
        return $this->position;
    }
    
    // This would cause an error - can't override final method
    // public function getType() {
    //     return "Employee";
    // }
}

// This would cause an error - can't extend final class
// class ExtendedConfig extends Config {
// }

$config = Config::getInstance();
echo "DB Host: " . $config->get('db_host') . "\n";

$person = new Person("John");
$employee = new Employee("Jane", "Developer");

echo $person->getName() . " is a " . $person->getType() . "\n";
echo $employee->getName() . " is a " . $employee->getType() . " working as " . $employee->getPosition() . "\n";
```
