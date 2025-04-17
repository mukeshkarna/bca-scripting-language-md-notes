# PHP with MySQL Database

## 1. Introduction to MySQL

### What is MySQL?
MySQL is an open-source relational database management system (RDBMS) that uses Structured Query Language (SQL) for database management. Key features include:

- **Open-source** - Free to use and modify
- **Relational** - Data is organized in related tables
- **Multi-user** - Supports multiple concurrent users
- **Cross-platform** - Works on Windows, Linux, macOS, etc.
- **Client-server architecture** - Separates database server from client applications
- **High performance** - Fast and reliable for most web applications
- **Widely used** - Powers many popular websites and applications

### MySQL vs. Other Database Systems

| Feature | MySQL | PostgreSQL | SQLite | SQL Server |
|---------|-------|------------|--------|------------|
| License | Open-source | Open-source | Public domain | Commercial |
| Best for | Web applications | Complex applications | Embedded systems | Enterprise apps |
| Performance | Very good | Excellent for complex queries | Good for small apps | Excellent |
| Scalability | Good | Excellent | Limited | Excellent |
| Ease of use | Easy | Moderate | Very easy | Moderate |
| PHP integration | Excellent | Good | Good | Good |

### Database Terminology

- **Database**: Collection of organized data
- **Table**: Structured set of data elements (like a spreadsheet)
- **Row/Record**: One set of related data in a table
- **Column/Field**: Category of data in a table
- **Primary Key**: Unique identifier for each record
- **Foreign Key**: Field that links to a primary key in another table
- **Index**: Data structure to improve query performance
- **SQL**: Structured Query Language - commands to interact with the database
- **Query**: Request for data or action on the database
- **CRUD**: Create, Read, Update, Delete - basic database operations

### MySQL Components

- **MySQL Server**: Core database engine
- **MySQL Client**: Command-line interface to interact with the server
- **MySQL Workbench**: GUI tool for database design and management
- **Connectors/APIs**: Libraries for connecting applications to MySQL

### MySQL Architecture

- **Connection Layer**: Manages client connections
- **Query Processing**: Parses and optimizes SQL queries
- **Storage Engines**: Components that handle data storage
  - InnoDB (default): Supports transactions, foreign keys
  - MyISAM: Faster for read-heavy workloads, no transactions
  - Memory: Very fast, but data stored in memory only
  - Archive: Optimized for high-speed inserting and compressed storage

## 2. PHP MySQL Connect to a Database

### Database Connection Methods in PHP

**1. MySQLi Extension (MySQL Improved)**
```php
<?php
// Procedural approach
$conn = mysqli_connect("hostname", "username", "password", "database");

// Object-oriented approach
$conn = new mysqli("hostname", "username", "password", "database");
?>
```

**2. PDO (PHP Data Objects)**
```php
<?php
$conn = new PDO("mysql:host=hostname;dbname=database", "username", "password");
?>
```

### Choosing Between MySQLi and PDO

| Feature | MySQLi | PDO |
|---------|--------|-----|
| Database support | MySQL only | Multiple databases |
| API | Procedural & OO | Object-oriented only |
| Prepared statements | Yes | Yes |
| Error handling | Warning or exception | Exception-based |
| Named parameters | No | Yes |
| Ease of use | Simpler for MySQL-only | More flexible |

### Basic Connection with MySQLi (Procedural)

```php
<?php
// Connection variables
$host = "localhost";
$username = "root";
$password = "password";
$database = "mydb";

// Create connection
$conn = mysqli_connect($host, $username, $password, $database);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

echo "Connected successfully";

// Close connection
mysqli_close($conn);
?>
```

### Basic Connection with MySQLi (Object-Oriented)

```php
<?php
// Connection variables
$host = "localhost";
$username = "root";
$password = "password";
$database = "mydb";

// Create connection
$conn = new mysqli($host, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo "Connected successfully";

// Close connection
$conn->close();
?>
```

### Basic Connection with PDO

```php
<?php
// Connection variables
$host = "localhost";
$username = "root";
$password = "password";
$database = "mydb";

try {
    // Create connection with error mode set to exceptions
    $conn = new PDO("mysql:host=$host;dbname=$database", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "Connected successfully";
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}

// Connection automatically closed when script ends
// or explicitly:
$conn = null;
?>
```

### Connection Configuration Best Practices

1. **Store connection details in a separate file**:
```php
<?php
// config.php
return [
    'db' => [
        'host' => 'localhost',
        'user' => 'root',
        'password' => 'password',
        'name' => 'mydb',
        'charset' => 'utf8mb4'
    ]
];
?>
```

```php
<?php
// connection.php
$config = require 'config.php';
$db = $config['db'];

$conn = mysqli_connect($db['host'], $db['user'], $db['password'], $db['name']);
// or with PDO:
$conn = new PDO(
    "mysql:host={$db['host']};dbname={$db['name']};charset={$db['charset']}",
    $db['user'],
    $db['password'],
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
);
?>
```

2. **Use environment variables** (especially for production):
```php
<?php
$conn = new mysqli(
    getenv('DB_HOST'),
    getenv('DB_USER'),
    getenv('DB_PASSWORD'),
    getenv('DB_NAME')
);
?>
```

3. **Create a reusable connection function or class**:
```php
<?php
function getDbConnection() {
    static $conn = null;
    
    if ($conn === null) {
        $config = require 'config.php';
        $db = $config['db'];
        
        $conn = new mysqli($db['host'], $db['user'], $db['password'], $db['name']);
        
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        
        // Set charset
        $conn->set_charset($db['charset']);
    }
    
    return $conn;
}

// Usage
$conn = getDbConnection();
?>
```

## 3. Closing a Connection

### Manually Closing a Connection

**MySQLi (Procedural)**
```php
<?php
$conn = mysqli_connect("localhost", "root", "password", "mydb");
// Database operations...
mysqli_close($conn);
?>
```

**MySQLi (Object-oriented)**
```php
<?php
$conn = new mysqli("localhost", "root", "password", "mydb");
// Database operations...
$conn->close();
?>
```

**PDO**
```php
<?php
$conn = new PDO("mysql:host=localhost;dbname=mydb", "root", "password");
// Database operations...
$conn = null; // Closes connection
?>
```

### Automatic Connection Closing

PHP automatically closes all database connections when the script finishes execution. However, best practice is to close them explicitly:

1. Frees up resources sooner
2. Makes your code more maintainable
3. More control over when connections are terminated

### Connection Pooling

For high-performance applications, consider connection pooling with tools like:

- **ProxySQL**: Database proxy for MySQL
- **MySQL Persistent Connections**: Using persistent connections in PHP

```php
<?php
// Persistent connection in MySQLi
$conn = mysqli_connect("p:localhost", "username", "password", "database");

// Persistent connection in PDO
$conn = new PDO("mysql:host=localhost;dbname=database", "username", "password", 
    [PDO::ATTR_PERSISTENT => true]
);
?>
```

### Handling Connection Failures

Always implement proper error handling for database connections:

```php
<?php
try {
    $conn = new PDO("mysql:host=$host;dbname=$database", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Database operations...
    
} catch(PDOException $e) {
    // Log error details to server log
    error_log("Database connection failed: " . $e->getMessage());
    
    // Show user-friendly message
    echo "We're sorry, but we could not connect to the database. Please try again later.";
    
    // For debugging in development only:
    // echo "Connection failed: " . $e->getMessage();
    
    // Optional: Send notification to admin
    // mail("admin@example.com", "Database connection failure", $e->getMessage());
}
?>
```

## 4. MySQL Data Types

### Numeric Data Types

| Data Type | Description | Size | Range (Signed) |
|-----------|-------------|------|---------------|
| TINYINT | Very small integer | 1 byte | -128 to 127 |
| SMALLINT | Small integer | 2 bytes | -32,768 to 32,767 |
| MEDIUMINT | Medium-sized integer | 3 bytes | -8,388,608 to 8,388,607 |
| INT | Standard integer | 4 bytes | -2,147,483,648 to 2,147,483,647 |
| BIGINT | Large integer | 8 bytes | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |
| FLOAT | Single-precision floating point | 4 bytes | ±1.175494351E-38 to ±3.402823466E+38 |
| DOUBLE | Double-precision floating point | 8 bytes | ±2.2250738585072014E-308 to ±1.7976931348623157E+308 |
| DECIMAL(M,D) | Fixed-point number | Varies | Depends on M (digits) and D (decimals) |

### String Data Types

| Data Type | Description | Maximum Size | Usage |
|-----------|-------------|--------------|-------|
| CHAR(M) | Fixed-length string | 255 characters | Fixed length fields like codes |
| VARCHAR(M) | Variable-length string | 65,535 characters | Most text fields |
| TINYTEXT | Very small text | 255 characters | Short texts |
| TEXT | Standard text | 65,535 characters | Standard text fields |
| MEDIUMTEXT | Medium-length text | 16,777,215 characters | Longer texts |
| LONGTEXT | Long text | 4,294,967,295 characters | Very long texts |
| ENUM | Enumeration | 65,535 values | List of possible values |
| SET | Set | 64 members | Multiple values from list |

### Date and Time Data Types

| Data Type | Description | Format | Range |
|-----------|-------------|--------|-------|
| DATE | Date | YYYY-MM-DD | 1000-01-01 to 9999-12-31 |
| TIME | Time | HH:MM:SS | -838:59:59 to 838:59:59 |
| DATETIME | Date and time | YYYY-MM-DD HH:MM:SS | 1000-01-01 00:00:00 to 9999-12-31 23:59:59 |
| TIMESTAMP | Timestamp | YYYY-MM-DD HH:MM:SS | 1970-01-01 00:00:01 to 2038-01-19 03:14:07 |
| YEAR | Year | YYYY | 1901 to 2155 |

### Binary Data Types

| Data Type | Description | Maximum Size | Usage |
|-----------|-------------|--------------|-------|
| BINARY(M) | Fixed-length binary | 255 bytes | Fixed-length binary data |
| VARBINARY(M) | Variable-length binary | 65,535 bytes | Variable-length binary data |
| TINYBLOB | Very small binary object | 255 bytes | Small binary files |
| BLOB | Binary large object | 65,535 bytes | Binary files (images, etc.) |
| MEDIUMBLOB | Medium-sized binary object | 16,777,215 bytes | Larger binary files |
| LONGBLOB | Large binary object | 4,294,967,295 bytes | Very large binary files |

### JSON Data Type (MySQL 5.7+)

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    preferences JSON
);

INSERT INTO users VALUES (1, 'John', '{"theme": "dark", "fontSize": "large"}');
```

### Data Type Best Practices

1. **Use the right data type for the job**:
   - Use INT for IDs and numeric values
   - Use VARCHAR for variable-length text
   - Use DECIMAL for money values (not FLOAT/DOUBLE which can have precision issues)
   - Use ENUM for fields with a fixed set of values

2. **Size matters**:
   - Use the smallest data type that fits your needs
   - Don't use VARCHAR(255) for everything
   - TINYINT is enough for boolean values (0/1)

3. **Consider storage requirements**:
   - Smaller data types improve performance
   - VARCHAR uses only the space required plus 1 or 2 bytes
   - CHAR always uses the full defined width

4. **Indexing considerations**:
   - Indexes on smaller columns are more efficient
   - Avoid indexing on large TEXT or BLOB columns

5. **Character sets and collations**:
   - Default to utf8mb4 for best Unicode support
   - Choose appropriate collation for language-specific sorting

## 5. MySQL Insert

### Basic INSERT Statement

```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

### Inserting Data with PHP (MySQLi - Procedural)

```php
<?php
$conn = mysqli_connect("localhost", "username", "password", "database");

$name = "John Doe";
$email = "john@example.com";
$age = 30;

$sql = "INSERT INTO users (name, email, age) VALUES ('$name', '$email', $age)";

if (mysqli_query($conn, $sql)) {
    echo "New record created successfully";
    // Get the auto-generated ID
    $last_id = mysqli_insert_id($conn);
    echo "New record ID is: " . $last_id;
} else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
}

mysqli_close($conn);
?>
```

### Inserting Data with PHP (MySQLi - Object-oriented)

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$name = "John Doe";
$email = "john@example.com";
$age = 30;

$sql = "INSERT INTO users (name, email, age) VALUES ('$name', '$email', $age)";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
    $last_id = $conn->insert_id;
    echo "New record ID is: " . $last_id;
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
```

### Inserting Data with PHP (PDO)

```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $name = "John Doe";
    $email = "john@example.com";
    $age = 30;

    $sql = "INSERT INTO users (name, email, age) VALUES ('$name', '$email', $age)";
    
    $conn->exec($sql);
    $last_id = $conn->lastInsertId();
    
    echo "New record created successfully. Last inserted ID is: " . $last_id;
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### Using Prepared Statements (Recommended for Security)

**MySQLi (Procedural)**
```php
<?php
$conn = mysqli_connect("localhost", "username", "password", "database");

$name = "John Doe";
$email = "john@example.com";
$age = 30;

// Prepare statement
$stmt = mysqli_prepare($conn, "INSERT INTO users (name, email, age) VALUES (?, ?, ?)");

// Bind parameters
mysqli_stmt_bind_param($stmt, "ssi", $name, $email, $age);
// s = string, i = integer, d = double, b = blob

// Execute statement
mysqli_stmt_execute($stmt);

echo "New record created successfully. Inserted ID: " . mysqli_stmt_insert_id($stmt);

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
```

**MySQLi (Object-oriented)**
```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$name = "John Doe";
$email = "john@example.com";
$age = 30;

// Prepare statement
$stmt = $conn->prepare("INSERT INTO users (name, email, age) VALUES (?, ?, ?)");

// Bind parameters
$stmt->bind_param("ssi", $name, $email, $age);

// Execute statement
$stmt->execute();

echo "New record created successfully. Inserted ID: " . $stmt->insert_id;

$stmt->close();
$conn->close();
?>
```

**PDO with Named Parameters**
```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $name = "John Doe";
    $email = "john@example.com";
    $age = 30;

    // Prepare statement
    $stmt = $conn->prepare("INSERT INTO users (name, email, age) VALUES (:name, :email, :age)");
    
    // Bind parameters
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':age', $age, PDO::PARAM_INT);
    
    // Execute statement
    $stmt->execute();
    
    echo "New record created successfully. Last ID: " . $conn->lastInsertId();
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### Multiple Inserts

**Batch INSERT Statement**
```sql
INSERT INTO users (name, email) VALUES 
('John', 'john@example.com'),
('Jane', 'jane@example.com'),
('Bob', 'bob@example.com');
```

**With PDO**
```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Start transaction for better performance with multiple inserts
    $conn->beginTransaction();
    
    $users = [
        ['name' => 'John', 'email' => 'john@example.com', 'age' => 30],
        ['name' => 'Jane', 'email' => 'jane@example.com', 'age' => 25],
        ['name' => 'Bob', 'email' => 'bob@example.com', 'age' => 45]
    ];
    
    $stmt = $conn->prepare("INSERT INTO users (name, email, age) VALUES (:name, :email, :age)");
    
    foreach ($users as $user) {
        $stmt->bindParam(':name', $user['name']);
        $stmt->bindParam(':email', $user['email']);
        $stmt->bindParam(':age', $user['age']);
        $stmt->execute();
    }
    
    $conn->commit();
    echo "Records created successfully";
} catch(PDOException $e) {
    // Roll back transaction on error
    $conn->rollBack();
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### INSERT IGNORE and ON DUPLICATE KEY UPDATE

**INSERT IGNORE**
```sql
-- Skips rows that would cause duplicate key errors
INSERT IGNORE INTO users (id, name, email) VALUES (1, 'John', 'john@example.com');
```

**ON DUPLICATE KEY UPDATE**
```sql
-- Updates existing row if duplicate key is found
INSERT INTO users (id, name, email, login_count) 
VALUES (1, 'John', 'john@example.com', 1)
ON DUPLICATE KEY UPDATE login_count = login_count + 1;
```

**With PHP**
```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$user_id = 1;
$name = "John";
$email = "john@example.com";
$login_count = 1;

$sql = "INSERT INTO users (id, name, email, login_count) 
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE login_count = login_count + 1";

$stmt = $conn->prepare($sql);
$stmt->bind_param("issi", $user_id, $name, $email, $login_count);
$stmt->execute();

echo "Query executed. Affected rows: " . $stmt->affected_rows;

$stmt->close();
$conn->close();
?>
```

## 6. MySQL Select

### Basic SELECT Statement

```sql
SELECT column1, column2 FROM table_name;

-- Select all columns
SELECT * FROM table_name;

-- Limit the number of results
SELECT * FROM table_name LIMIT 10;

-- Offset and limit (pagination)
SELECT * FROM table_name LIMIT 10 OFFSET 20;  -- Skip 20, take 10
```

### Selecting Data with PHP (MySQLi - Procedural)

```php
<?php
$conn = mysqli_connect("localhost", "username", "password", "database");

$sql = "SELECT id, name, email FROM users";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    // Output data of each row
    while($row = mysqli_fetch_assoc($result)) {
        echo "ID: " . $row["id"] . " - Name: " . $row["name"] . " - Email: " . $row["email"] . "<br>";
    }
} else {
    echo "0 results";
}

mysqli_close($conn);
?>
```

### Selecting Data with PHP (MySQLi - Object-oriented)

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$sql = "SELECT id, name, email FROM users";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        echo "ID: " . $row["id"] . " - Name: " . $row["name"] . " - Email: " . $row["email"] . "<br>";
    }
} else {
    echo "0 results";
}

$conn->close();
?>
```

### Selecting Data with PHP (PDO)

```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $stmt = $conn->query("SELECT id, name, email FROM users");
    
    // Fetch as associative array
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "ID: " . $row["id"] . " - Name: " . $row["name"] . " - Email: " . $row["email"] . "<br>";
    }
    
    // No results check
    if ($stmt->rowCount() === 0) {
        echo "0 results";
    }
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### Different Fetch Methods

**MySQLi**
```php
<?php
$result = $conn->query("SELECT id, name, email FROM users");

// Fetch as associative array
$row = $result->fetch_assoc();
// Example: $row["name"]

// Fetch as numeric array
$row = $result->fetch_row();
// Example: $row[1] (for name)

// Fetch as both
$row = $result->fetch_array();
// Example: $row["name"] or $row[1]

// Fetch as object
$row = $result->fetch_object();
// Example: $row->name

// Fetch all results at once
$rows = $result->fetch_all(MYSQLI_ASSOC);
foreach ($rows as $row) {
    echo $row["name"] . "<br>";
}
?>
```

**PDO**
```php
<?php
$stmt = $conn->query("SELECT id, name, email FROM users");

// Fetch as associative array
$row = $stmt->fetch(PDO::FETCH_ASSOC);
// Example: $row["name"]

// Fetch as numeric array
$row = $stmt->fetch(PDO::FETCH_NUM);
// Example: $row[1] (for name)

// Fetch as both
$row = $stmt->fetch(PDO::FETCH_BOTH);
// Example: $row["name"] or $row[1]

// Fetch as object
$row = $stmt->fetch(PDO::FETCH_OBJ);
// Example: $row->name

// Fetch all results at once
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
foreach ($rows as $row) {
    echo $row["name"] . "<br>";
}

// Fetch into a custom class
class User {
    public $id;
    public $name;
    public $email;
    
    public function getDisplayName() {
        return "#" . $this->id . ": " . $this->name;
    }
}

$stmt = $conn->query("SELECT id, name, email FROM users");
$users = $stmt->fetchAll(PDO::FETCH_CLASS, 'User');

foreach ($users as $user) {
    echo $user->getDisplayName() . " - " . $user->email . "<br>";
}
?>
```

### Using Prepared Statements for SELECT Queries

**MySQLi (Object-oriented)**
```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$user_id = 1;

$stmt = $conn->prepare("SELECT id, name, email FROM users WHERE id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();

// Bind result variables
$stmt->bind_result($id, $name, $email);

// Fetch results
while ($stmt->fetch()) {
    echo "ID: " . $id . " - Name: " . $name . " - Email: " . $email . "<br>";
}

$stmt->close();
$conn->close();
?>
```

**PDO**
```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $user_id = 1;
    
    $stmt = $conn->prepare("SELECT id, name, email FROM users WHERE id = :id");
    $stmt->bindParam(':id', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    
    // Fetch results
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($user) {
        echo "ID: " . $user["id"] . " - Name: " . $user["name"] . " - Email: " . $user["email"];
    } else {
        echo "User not found";
    }
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### Displaying Results in HTML

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");
$result = $conn->query("SELECT id, name, email, created_at FROM users ORDER BY created_at DESC");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Users List</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        th { padding-top: 12px; padding-bottom: 12px; text-align: left; background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <h1>Users List</h1>
    
    <?php if ($result->num_rows > 0): ?>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row["id"]) ?></td>
                        <td><?= htmlspecialchars($row["name"]) ?></td>
                        <td><?= htmlspecialchars($row["email"]) ?></td>
                        <td><?= htmlspecialchars($row["created_at"]) ?></td>
                        <td>
                            <a href="edit.php?id=<?= $row["id"] ?>">Edit</a> | 
                            <a href="delete.php?id=<?= $row["id"] ?>" onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>No users found</p>
    <?php endif; ?>
    
    <p><a href="add.php">Add New User</a></p>
</body>
</html>
```

## 7. MySQL Where Clause

### Basic WHERE Clause

```sql
SELECT * FROM users WHERE age > 21;

SELECT * FROM products WHERE category = 'Electronics';
```

### Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| = | Equal | `WHERE id = 5` |
| > | Greater than | `WHERE price > 100` |
| < | Less than | `WHERE price < 50` |
| >= | Greater than or equal | `WHERE age >= 18` |
| <= | Less than or equal | `WHERE weight <= 70` |
| != or <> | Not equal | `WHERE status != 'inactive'` |
| BETWEEN | Between a range | `WHERE price BETWEEN 10 AND 50` |
| LIKE | Pattern matching | `WHERE name LIKE 'A%'` |
| IN | Match any value in a list | `WHERE country IN ('USA', 'Canada')` |
| IS NULL | Null value check | `WHERE phone IS NULL` |
| IS NOT NULL | Not null check | `WHERE email IS NOT NULL` |

### Logical Operators

- **AND**: Both conditions must be true
  ```sql
  SELECT * FROM users WHERE age >= 18 AND country = 'USA';
  ```

- **OR**: Either condition can be true
  ```sql
  SELECT * FROM products WHERE category = 'Electronics' OR category = 'Computers';
  ```

- **NOT**: Negates a condition
  ```sql
  SELECT * FROM users WHERE NOT country = 'USA';
  ```

- **Combining operators with parentheses**
  ```sql
  SELECT * FROM products 
  WHERE (category = 'Electronics' OR category = 'Computers') 
  AND price < 1000;
  ```

### Using WHERE Clause with PHP

**MySQLi**
```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$min_age = 18;
$country = "USA";

$sql = "SELECT id, name, email FROM users WHERE age >= ? AND country = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("is", $min_age, $country); // i = integer, s = string
$stmt->execute();
$result = $stmt->get_result();

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . " - " . $row['email'] . "<br>";
}

$stmt->close();
$conn->close();
?>
```

**PDO**
```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $min_age = 18;
    $country = "USA";
    
    $stmt = $conn->prepare("SELECT id, name, email FROM users WHERE age >= :age AND country = :country");
    $stmt->bindParam(':age', $min_age, PDO::PARAM_INT);
    $stmt->bindParam(':country', $country);
    $stmt->execute();
    
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo $row['name'] . " - " . $row['email'] . "<br>";
    }
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### LIKE Operator for Pattern Matching

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$search = "%searchterm%"; // % is a wildcard

$stmt = $conn->prepare("SELECT * FROM products WHERE name LIKE ?");
$stmt->bind_param("s", $search);
$stmt->execute();
$result = $stmt->get_result();

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . " - $" . $row['price'] . "<br>";
}

$stmt->close();
$conn->close();
?>
```

### Common LIKE Patterns

- **'A%'**: Starts with 'A'
- **'%A'**: Ends with 'A'
- **'%word%'**: Contains 'word'
- **'_a%'**: Second character is 'a'
- **'a_%'**: Starts with 'a' and has at least 2 characters
- **'a__%'**: Starts with 'a' and has at least 3 characters

### IN Operator for Multiple Values

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$categories = array('Electronics', 'Computers', 'Accessories');
$placeholders = str_repeat('?,', count($categories) - 1) . '?';

$stmt = $conn->prepare("SELECT * FROM products WHERE category IN ($placeholders)");
$stmt->bind_param(str_repeat('s', count($categories)), ...$categories);
$stmt->execute();
$result = $stmt->get_result();

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . " - " . $row['category'] . "<br>";
}

$stmt->close();
$conn->close();
?>
```

### Working with NULL Values

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Find users with no phone number
$sql = "SELECT * FROM users WHERE phone IS NULL";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . " - No phone number provided<br>";
}

// Find users with a phone number
$sql = "SELECT * FROM users WHERE phone IS NOT NULL";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . " - " . $row['phone'] . "<br>";
}

$conn->close();
?>
```

## 8. MySQL Delete

### Basic DELETE Statement

```sql
DELETE FROM table_name WHERE condition;

-- Example
DELETE FROM users WHERE id = 5;
```

### Deleting Data with PHP (MySQLi)

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$user_id = 5;

$sql = "DELETE FROM users WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();

echo "Record deleted successfully. Affected rows: " . $stmt->affected_rows;

$stmt->close();
$conn->close();
?>
```

### Deleting Data with PHP (PDO)

```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $user_id = 5;
    
    $sql = "DELETE FROM users WHERE id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':id', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    
    echo "Record deleted successfully. Affected rows: " . $stmt->rowCount();
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### Deleting Multiple Records

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Delete inactive users
$sql = "DELETE FROM users WHERE last_login < ? AND status = 'inactive'";
$cutoff_date = date('Y-m-d', strtotime('-1 year')); // 1 year ago

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $cutoff_date);
$stmt->execute();

echo "Deleted " . $stmt->affected_rows . " inactive users";

$stmt->close();
$conn->close();
?>
```

### Implementing a Delete User Feature

```php
<?php
// delete.php
session_start();

// Check if admin is logged in
if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: login.php");
    exit;
}

// Validate and sanitize input
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    $_SESSION['error'] = "Invalid user ID";
    header("Location: users.php");
    exit;
}

$user_id = (int)$_GET['id'];

// Connect to database
$conn = new mysqli("localhost", "username", "password", "database");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Don't allow deleting your own account
if ($user_id === $_SESSION['user_id']) {
    $_SESSION['error'] = "You cannot delete your own account";
    header("Location: users.php");
    exit;
}

// Prepare and execute the delete statement
$stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();

// Check if the user was found and deleted
if ($stmt->affected_rows > 0) {
    $_SESSION['success'] = "User deleted successfully";
} else {
    $_SESSION['error'] = "User not found";
}

$stmt->close();
$conn->close();

// Redirect back to user list
header("Location: users.php");
exit;
?>
```

```html
<!-- users.php - Delete button in user list -->
<a href="delete.php?id=<?= $row['id'] ?>" class="delete-btn" 
   onclick="return confirm('Are you sure you want to delete this user?')">
   Delete
</a>
```

### Soft Delete (Marking as Deleted)

Instead of actually deleting records, it's often better to mark them as deleted:

```sql
-- Add a 'deleted' column to the table
ALTER TABLE users ADD COLUMN deleted BOOLEAN DEFAULT 0;
```

```php
<?php
// Soft delete implementation
$conn = new mysqli("localhost", "username", "password", "database");

$user_id = 5;

// Mark as deleted instead of actually deleting
$sql = "UPDATE users SET deleted = 1, deleted_at = NOW() WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();

echo "User marked as deleted";

// Then when retrieving users, exclude deleted ones
$sql = "SELECT * FROM users WHERE deleted = 0";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . "<br>";
}

$stmt->close();
$conn->close();
?>
```

### DELETE with JOIN

```sql
-- Delete orders of inactive customers
DELETE orders FROM orders
JOIN customers ON orders.customer_id = customers.id
WHERE customers.status = 'inactive';
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$status = "inactive";

$sql = "DELETE orders FROM orders
        JOIN customers ON orders.customer_id = customers.id
        WHERE customers.status = ?";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $status);
$stmt->execute();

echo "Deleted " . $stmt->affected_rows . " orders from inactive customers";

$stmt->close();
$conn->close();
?>
```

### Safety Measures for DELETE Operations

1. **Always use a WHERE clause with DELETE**
   ```php
   // Dangerous (deletes all records)
   $conn->query("DELETE FROM users");
   
   // Safe (deletes specific record)
   $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
   $stmt->bind_param("i", $user_id);
   $stmt->execute();
   ```

2. **Use transactions for multiple deletes**
   ```php
   <?php
   $conn = new mysqli("localhost", "username", "password", "database");
   
   // Start transaction
   $conn->begin_transaction();
   
   try {
       // Delete user
       $stmt1 = $conn->prepare("DELETE FROM users WHERE id = ?");
       $stmt1->bind_param("i", $user_id);
       $stmt1->execute();
       
       // Delete user's posts
       $stmt2 = $conn->prepare("DELETE FROM posts WHERE user_id = ?");
       $stmt2->bind_param("i", $user_id);
       $stmt2->execute();
       
       // If both operations succeed, commit
       $conn->commit();
       echo "User and posts deleted successfully";
   } catch (Exception $e) {
       // If an error occurs, roll back
       $conn->rollback();
       echo "Error: " . $e->getMessage();
   }
   
   $conn->close();
   ?>
   ```

3. **Implement confirmation for delete operations**
   ```html
   <form method="post" onsubmit="return confirm('Are you sure? This cannot be undone!')">
       <input type="hidden" name="id" value="<?= $user_id ?>">
       <button type="submit" name="delete">Delete User</button>
   </form>
   ```

## 9. MySQL Update

### Basic UPDATE Statement

```sql
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;

-- Example
UPDATE users SET status = 'active', last_login = NOW() WHERE id = 5;
```

### Updating Data with PHP (MySQLi)

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$user_id = 5;
$status = "active";
$email = "newemail@example.com";

$sql = "UPDATE users SET status = ?, email = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssi", $status, $email, $user_id);
$stmt->execute();

echo "Record updated successfully. Affected rows: " . $stmt->affected_rows;

$stmt->close();
$conn->close();
?>
```

### Updating Data with PHP (PDO)

```php
<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=database", "username", "password");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $user_id = 5;
    $status = "active";
    $email = "newemail@example.com";
    
    $sql = "UPDATE users SET status = :status, email = :email WHERE id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':status', $status);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':id', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    
    echo "Record updated successfully. Affected rows: " . $stmt->rowCount();
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
```

### Implementing an Edit User Form

```php
<?php
// edit_user.php
session_start();

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

$conn = new mysqli("localhost", "username", "password", "database");

$user_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$error = '';
$success = '';
$user = null;

// Get user data for the form
if ($user_id > 0) {
    $stmt = $conn->prepare("SELECT id, name, email, status FROM users WHERE id = ?");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
    } else {
        $error = "User not found";
    }
    
    $stmt->close();
}

// Process form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_user'])) {
    $user_id = (int)$_POST['user_id'];
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $status = $_POST['status'];
    
    // Validate input
    if (empty($name)) {
        $error = "Name is required";
    } elseif (empty($email)) {
        $error = "Email is required";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Invalid email format";
    } else {
        // Update user
        $stmt = $conn->prepare("UPDATE users SET name = ?, email = ?, status = ? WHERE id = ?");
        $stmt->bind_param("sssi", $name, $email, $status, $user_id);
        $stmt->execute();
        
        if ($stmt->affected_rows > 0) {
            $success = "User updated successfully";
            // Refresh user data
            $user['name'] = $name;
            $user['email'] = $email;
            $user['status'] = $status;
        } else {
            $error = "No changes made or user not found";
        }
        
        $stmt->close();
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        form div { margin-bottom: 15px; }
    </style>
</head>
<body>
    <h1>Edit User</h1>
    
    <?php if ($error): ?>
        <p class="error"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>
    
    <?php if ($success): ?>
        <p class="success"><?= htmlspecialchars($success) ?></p>
    <?php endif; ?>
    
    <?php if ($user): ?>
        <form method="post">
            <input type="hidden" name="user_id" value="<?= $user['id'] ?>">
            
            <div>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<?= htmlspecialchars($user['name']) ?>" required>
            </div>
            
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<?= htmlspecialchars($user['email']) ?>" required>
            </div>
            
            <div>
                <label for="status">Status:</label>
                <select id="status" name="status">
                    <option value="active" <?= $user['status'] === 'active' ? 'selected' : '' ?>>Active</option>
                    <option value="inactive" <?= $user['status'] === 'inactive' ? 'selected' : '' ?>>Inactive</option>
                </select>
            </div>
            
            <div>
                <button type="submit" name="update_user">Update User</button>
                <a href="users.php">Cancel</a>
            </div>
        </form>
    <?php else: ?>
        <p>No user selected or user not found.</p>
        <p><a href="users.php">Back to Users List</a></p>
    <?php endif; ?>
</body>
</html>
```

### Updating Multiple Records

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Update prices in a category with a percentage increase
$category = "Electronics";
$percentage = 5; // 5% increase

$sql = "UPDATE products 
        SET price = price * (1 + ?/100) 
        WHERE category = ?";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("ds", $percentage, $category);
$stmt->execute();

echo "Updated " . $stmt->affected_rows . " products with a {$percentage}% price increase";

$stmt->close();
$conn->close();
?>
```

### UPDATE with JOIN

```sql
-- Update customer orders with a discount
UPDATE orders o
JOIN customers c ON o.customer_id = c.id
SET o.total = o.total * 0.9
WHERE c.membership_level = 'premium';
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$discount = 0.9; // 10% discount
$membership = "premium";

$sql = "UPDATE orders o
        JOIN customers c ON o.customer_id = c.id
        SET o.total = o.total * ?
        WHERE c.membership_level = ?";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("ds", $discount, $membership);
$stmt->execute();

echo "Applied 10% discount to " . $stmt->affected_rows . " premium customer orders";

$stmt->close();
$conn->close();
?>
```

### Conditional Updates

```sql
-- Increase price only if current price is below threshold
UPDATE products 
SET price = CASE
    WHEN price < 10 THEN price * 1.1  -- 10% increase for low-priced items
    WHEN price < 50 THEN price * 1.05 -- 5% increase for mid-priced items
    ELSE price                       -- No change for high-priced items
END
WHERE category = 'Electronics';
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$category = "Electronics";

$sql = "UPDATE products 
        SET price = CASE
            WHEN price < 10 THEN price * 1.1
            WHEN price < 50 THEN price * 1.05
            ELSE price
        END
        WHERE category = ?";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $category);
$stmt->execute();

echo "Updated prices for " . $stmt->affected_rows . " products";

$stmt->close();
$conn->close();
?>
```

### Safety Measures for UPDATE Operations

1. **Always use a WHERE clause with UPDATE**
   ```php
   // Dangerous (updates all records)
   $conn->query("UPDATE users SET status = 'inactive'");
   
   // Safe (updates specific records)
   $stmt = $conn->prepare("UPDATE users SET status = 'inactive' WHERE last_login < ?");
   $cutoff_date = date('Y-m-d', strtotime('-1 year'));
   $stmt->bind_param("s", $cutoff_date);
   $stmt->execute();
   ```

2. **Use transactions for complex updates**
   ```php
   <?php
   $conn = new mysqli("localhost", "username", "password", "database");
   
   // Start transaction
   $conn->begin_transaction();
   
   try {
       // Update order status
       $stmt1 = $conn->prepare("UPDATE orders SET status = 'shipped' WHERE id = ?");
       $stmt1->bind_param("i", $order_id);
       $stmt1->execute();
       
       // Update inventory
       $stmt2 = $conn->prepare("UPDATE products SET stock = stock - ? WHERE id = ?");
       $stmt2->bind_param("ii", $quantity, $product_id);
       $stmt2->execute();
       
       // If both operations succeed, commit
       $conn->commit();
       echo "Order processed successfully";
   } catch (Exception $e) {
       // If an error occurs, roll back
       $conn->rollback();
       echo "Error: " . $e->getMessage();
   }
   
   $conn->close();
   ?>
   ```

3. **Validate input data before update**
   ```php
   <?php
   // Get data from form
   $user_id = (int)$_POST['user_id'];
   $email = trim($_POST['email']);
   
   // Validate email
   if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
       die("Invalid email format");
   }
   
   // Update only if ID is valid
   if ($user_id <= 0) {
       die("Invalid user ID");
   }
   
   // Proceed with update
   $stmt = $conn->prepare("UPDATE users SET email = ? WHERE id = ?");
   $stmt->bind_param("si", $email, $user_id);
   $stmt->execute();
   ?>
   ```

## 10. MySQL Aggregate Functions

### Common Aggregate Functions

| Function | Description | Example |
|----------|-------------|---------|
| COUNT() | Counts rows | `COUNT(*)` or `COUNT(column)` |
| SUM() | Sum of values | `SUM(price)` |
| AVG() | Average of values | `AVG(rating)` |
| MIN() | Minimum value | `MIN(price)` |
| MAX() | Maximum value | `MAX(price)` |
| GROUP_CONCAT() | Concatenates values | `GROUP_CONCAT(name SEPARATOR ', ')` |

### Basic Aggregate Query Examples

```sql
-- Count all users
SELECT COUNT(*) FROM users;

-- Count users with email (not NULL)
SELECT COUNT(email) FROM users;

-- Calculate total sales
SELECT SUM(amount) FROM orders;

-- Calculate average order value
SELECT AVG(amount) FROM orders;

-- Find most expensive product
SELECT MAX(price) FROM products;

-- Find cheapest product
SELECT MIN(price) FROM products;
```

### Using Aggregate Functions with PHP

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Get summary statistics for orders
$sql = "SELECT 
            COUNT(*) AS total_orders,
            SUM(amount) AS total_sales,
            AVG(amount) AS average_order,
            MIN(amount) AS smallest_order,
            MAX(amount) AS largest_order
        FROM orders
        WHERE order_date >= ?";

$start_date = date('Y-m-d', strtotime('-30 days')); // Last 30 days
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $start_date);
$stmt->execute();
$result = $stmt->get_result();
$stats = $result->fetch_assoc();

echo "<h2>Order Statistics (Last 30 Days)</h2>";
echo "<p>Total Orders: " . $stats['total_orders'] . "</p>";
echo "<p>Total Sales: $" . number_format($stats['total_sales'], 2) . "</p>";
echo "<p>Average Order: $" . number_format($stats['average_order'], 2) . "</p>";
echo "<p>Smallest Order: $" . number_format($stats['smallest_order'], 2) . "</p>";
echo "<p>Largest Order: $" . number_format($stats['largest_order'], 2) . "</p>";

$stmt->close();
$conn->close();
?>
```

### COUNT with DISTINCT

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Count unique customers who placed orders
$sql = "SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM orders";
$result = $conn->query($sql);
$row = $result->fetch_assoc();

echo "Number of unique customers: " . $row['unique_customers'];

$conn->close();
?>
```

### GROUP BY with Aggregate Functions

```sql
-- Sales by category
SELECT 
    category,
    COUNT(*) AS products,
    AVG(price) AS avg_price,
    SUM(stock) AS total_stock
FROM products
GROUP BY category;
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Get product statistics by category
$sql = "SELECT 
            category,
            COUNT(*) AS products,
            ROUND(AVG(price), 2) AS avg_price,
            SUM(stock) AS total_stock
        FROM products
        GROUP BY category
        ORDER BY products DESC";
        
$result = $conn->query($sql);
?>

<table border="1">
    <thead>
        <tr>
            <th>Category</th>
            <th>Products</th>
            <th>Average Price</th>
            <th>Total Stock</th>
        </tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= htmlspecialchars($row['category']) ?></td>
                <td><?= $row['products'] ?></td>
                <td>$<?= $row['avg_price'] ?></td>
                <td><?= $row['total_stock'] ?></td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

### HAVING Clause (Filtering Group Results)

```sql
-- Find categories with average price over $50
SELECT 
    category,
    COUNT(*) AS products,
    AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING avg_price > 50
ORDER BY avg_price DESC;
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$min_avg_price = 50;

// Find categories with average price above threshold
$sql = "SELECT 
            category,
            COUNT(*) AS products,
            ROUND(AVG(price), 2) AS avg_price
        FROM products
        GROUP BY category
        HAVING avg_price > ?
        ORDER BY avg_price DESC";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("d", $min_avg_price);
$stmt->execute();
$result = $stmt->get_result();

echo "<h2>Premium Categories (Avg. price > $" . $min_avg_price . ")</h2>";
echo "<ul>";
while ($row = $result->fetch_assoc()) {
    echo "<li>" . htmlspecialchars($row['category']) . 
         " - " . $row['products'] . " products" .
         " - Avg. price: $" . $row['avg_price'] . "</li>";
}
echo "</ul>";

$stmt->close();
$conn->close();
?>
```

### GROUP_CONCAT for List Aggregation

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Get authors and their books
$sql = "SELECT 
            a.name AS author,
            COUNT(b.id) AS book_count,
            GROUP_CONCAT(b.title SEPARATOR ', ') AS books
        FROM authors a
        LEFT JOIN books b ON a.id = b.author_id
        GROUP BY a.id
        ORDER BY book_count DESC";
        
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    echo "<h3>" . htmlspecialchars($row['author']) . " (" . $row['book_count'] . " books)</h3>";
    
    if ($row['books']) {
        echo "<p>Books: " . htmlspecialchars($row['books']) . "</p>";
    } else {
        echo "<p>No books found</p>";
    }
}

$conn->close();
?>
```

### Creating a Dashboard with Aggregate Functions

```php
<?php
// dashboard.php
session_start();

// Check if admin is logged in
if (!isset($_SESSION['user_id']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: login.php");
    exit;
}

$conn = new mysqli("localhost", "username", "password", "database");

// Get timeframe from query parameter
$timeframe = isset($_GET['timeframe']) ? $_GET['timeframe'] : '30days';

switch ($timeframe) {
    case '7days':
        $start_date = date('Y-m-d', strtotime('-7 days'));
        $title = "Last 7 Days";
        break;
    case '30days':
        $start_date = date('Y-m-d', strtotime('-30 days'));
        $title = "Last 30 Days";
        break;
    case '90days':
        $start_date = date('Y-m-d', strtotime('-90 days'));
        $title = "Last 90 Days";
        break;
    case 'year':
        $start_date = date('Y-m-d', strtotime('-1 year'));
        $title = "Last Year";
        break;
    default:
        $start_date = date('Y-m-d', strtotime('-30 days'));
        $title = "Last 30 Days";
}

// Order statistics
$stmt = $conn->prepare("
    SELECT 
        COUNT(*) AS total_orders,
        SUM(total_amount) AS total_sales,
        AVG(total_amount) AS average_order,
        COUNT(DISTINCT customer_id) AS unique_customers
    FROM orders
    WHERE order_date >= ?
");
$stmt->bind_param("s", $start_date);
$stmt->execute();
$result = $stmt->get_result();
$order_stats = $result->fetch_assoc();
$stmt->close();

// Product statistics
$stmt = $conn->prepare("
    SELECT 
        category,
        COUNT(*) AS product_count,
        ROUND(AVG(price), 2) AS avg_price,
        SUM(stock) AS total_stock
    FROM products
    GROUP BY category
    ORDER BY product_count DESC
");
$stmt->execute();
$product_stats = $stmt->get_result();
$stmt->close();

// Top selling products
$stmt = $conn->prepare("
    SELECT 
        p.id,
        p.name,
        p.price,
        SUM(oi.quantity) AS total_sold
    FROM products p
    JOIN order_items oi ON p.id = oi.product_id
    JOIN orders o ON oi.order_id = o.id
    WHERE o.order_date >= ?
    GROUP BY p.id
    ORDER BY total_sold DESC
    LIMIT 5
");
$stmt->bind_param("s", $start_date);
$stmt->execute();
$top_products = $stmt->get_result();
$stmt->close();

// Sales by day for chart
$stmt = $conn->prepare("
    SELECT 
        DATE(order_date) AS date,
        COUNT(*) AS orders,
        SUM(total_amount) AS sales
    FROM orders
    WHERE order_date >= ?
    GROUP BY DATE(order_date)
    ORDER BY date
");
$stmt->bind_param("s", $start_date);
$stmt->execute();
$daily_sales = $stmt->get_result();
$dates = [];
$sales_data = [];
while ($row = $daily_sales->fetch_assoc()) {
    $dates[] = $row['date'];
    $sales_data[] = $row['sales'];
}
$stmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .dashboard { display: flex; flex-wrap: wrap; }
        .card { background-color: #f9f9f9; border-radius: 5px; padding: 15px; margin: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .stats-card { width: calc(25% - 30px); }
        .chart-card { width: calc(100% - 30px); }
        .table-card { width: calc(50% - 30px); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .tabs { margin-bottom: 20px; }
        .tab { display: inline-block; padding: 10px 15px; cursor: pointer; text-decoration: none; color: #333; }
        .tab.active { background-color: #f0f0f0; font-weight: bold; }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>Admin Dashboard</h1>
    
    <div class="tabs">
        <a href="?timeframe=7days" class="tab <?= $timeframe == '7days' ? 'active' : '' ?>">7 Days</a>
        <a href="?timeframe=30days" class="tab <?= $timeframe == '30days' ? 'active' : '' ?>">30 Days</a>
        <a href="?timeframe=90days" class="tab <?= $timeframe == '90days' ? 'active' : '' ?>">90 Days</a>
        <a href="?timeframe=year" class="tab <?= $timeframe == 'year' ? 'active' : '' ?>">1 Year</a>
    </div>
    
    <h2>Sales Overview - <?= $title ?></h2>
    
    <div class="dashboard">
        <div class="card stats-card">
            <h3>Total Orders</h3>
            <p style="font-size: 24px;"><?= number_format($order_stats['total_orders']) ?></p>
        </div>
        
        <div class="card stats-card">
            <h3>Total Sales</h3>
            <p style="font-size: 24px;">$<?= number_format($order_stats['total_sales'], 2) ?></p>
        </div>
        
        <div class="card stats-card">
            <h3>Average Order</h3>
            <p style="font-size: 24px;">$<?= number_format($order_stats['average_order'], 2) ?></p>
        </div>
        
        <div class="card stats-card">
            <h3>Unique Customers</h3>
            <p style="font-size: 24px;"><?= number_format($order_stats['unique_customers']) ?></p>
        </div>
        
        <div class="card chart-card">
            <h3>Daily Sales</h3>
            <canvas id="salesChart"></canvas>
        </div>
        
        <div class="card table-card">
            <h3>Top Selling Products</h3>
            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Units Sold</th>
                        <th>Total Revenue</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($product = $top_products->fetch_assoc()): ?>
                        <tr>
                            <td><?= htmlspecialchars($product['name']) ?></td>
                            <td>$<?= number_format($product['price'], 2) ?></td>
                            <td><?= number_format($product['total_sold']) ?></td>
                            <td>$<?= number_format($product['price'] * $product['total_sold'], 2) ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        
        <div class="card table-card">
            <h3>Inventory by Category</h3>
            <table>
                <thead>
                    <tr>
                        <th>Category</th>
                        <th>Products</th>
                        <th>Avg. Price</th>
                        <th>Total Stock</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($category = $product_stats->fetch_assoc()): ?>
                        <tr>
                            <td><?= htmlspecialchars($category['category']) ?></td>
                            <td><?= number_format($category['product_count']) ?></td>
                            <td>$<?= number_format($category['avg_price'], 2) ?></td>
                            <td><?= number_format($category['total_stock']) ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        // Sales chart
        const ctx = document.getElementById('salesChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: <?= json_encode($dates) ?>,
                datasets: [{
                    label: 'Daily Sales',
                    data: <?= json_encode($sales_data) ?>,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return '$' + value.toFixed(2);
                            }
                        }
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Daily Sales'
                    }
                }
            }
        });
    </script>
</body>
</html>
```

## 11. MySQL Order By and Group By Clause

### ORDER BY Clause

The ORDER BY clause sorts the result set based on one or more columns:

```sql
-- Basic ordering
SELECT * FROM products ORDER BY price ASC;  -- Ascending (default)
SELECT * FROM products ORDER BY price DESC; -- Descending

-- Multiple columns
SELECT * FROM users ORDER BY last_name ASC, first_name ASC;

-- Using column position
SELECT id, name, price FROM products ORDER BY 3 DESC; -- Order by 3rd column (price)
```

### Using ORDER BY with PHP

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Get sort parameters from URL
$sort_column = isset($_GET['sort']) ? $_GET['sort'] : 'name';
$sort_order = isset($_GET['order']) ? $_GET['order'] : 'asc';

// Validate sort column (whitelist approach)
$allowed_columns = ['name', 'price', 'category', 'stock'];
if (!in_array($sort_column, $allowed_columns)) {
    $sort_column = 'name'; // Default if invalid
}

// Validate sort order
$sort_order = strtolower($sort_order) === 'desc' ? 'DESC' : 'ASC';

// Query with dynamic sorting
$sql = "SELECT * FROM products ORDER BY $sort_column $sort_order";
$result = $conn->query($sql);
?>

<table border="1">
    <thead>
        <tr>
            <th><a href="?sort=name&order=<?= $sort_column === 'name' && $sort_order === 'ASC' ? 'desc' : 'asc' ?>">Name</a></th>
            <th><a href="?sort=price&order=<?= $sort_column === 'price' && $sort_order === 'ASC' ? 'desc' : 'asc' ?>">Price</a></th>
            <th><a href="?sort=category&order=<?= $sort_column === 'category' && $sort_order === 'ASC' ? 'desc' : 'asc' ?>">Category</a></th>
            <th><a href="?sort=stock&order=<?= $sort_column === 'stock' && $sort_order === 'ASC' ? 'desc' : 'asc' ?>">Stock</a></th>
        </tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= htmlspecialchars($row['name']) ?></td>
                <td>$<?= number_format($row['price'], 2) ?></td>
                <td><?= htmlspecialchars($row['category']) ?></td>
                <td><?= $row['stock'] ?></td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

### GROUP BY Clause

The GROUP BY clause groups rows with the same values in specified columns into summary rows:

```sql
-- Group by a single column
SELECT category, COUNT(*) as count FROM products GROUP BY category;

-- Group by multiple columns
SELECT category, brand, COUNT(*) as count 
FROM products 
GROUP BY category, brand;
```

### Combining GROUP BY with ORDER BY

```sql
-- Group by category and order by product count
SELECT category, COUNT(*) as count 
FROM products 
GROUP BY category 
ORDER BY count DESC;
```

### Using GROUP BY with PHP

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Order statistics by month
$sql = "SELECT 
            YEAR(order_date) as year,
            MONTH(order_date) as month,
            COUNT(*) as order_count,
            SUM(total_amount) as total_sales,
            AVG(total_amount) as average_order
        FROM orders
        WHERE order_date >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
        GROUP BY YEAR(order_date), MONTH(order_date)
        ORDER BY YEAR(order_date) DESC, MONTH(order_date) DESC";
        
$result = $conn->query($sql);
?>

<h2>Monthly Sales Report</h2>
<table border="1">
    <thead>
        <tr>
            <th>Month</th>
            <th>Orders</th>
            <th>Total Sales</th>
            <th>Average Order</th>
        </tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= date("F Y", mktime(0, 0, 0, $row['month'], 1, $row['year'])) ?></td>
                <td><?= number_format($row['order_count']) ?></td>
                <td>$<?= number_format($row['total_sales'], 2) ?></td>
                <td>$<?= number_format($row['average_order'], 2) ?></td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

### GROUP_CONCAT with GROUP BY

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Products per category with example products
$sql = "SELECT 
            category,
            COUNT(*) as product_count,
            GROUP_CONCAT(name SEPARATOR ', ') as product_examples
        FROM products
        GROUP BY category
        ORDER BY product_count DESC";
        
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    echo "<h3>" . htmlspecialchars($row['category']) . " (" . $row['product_count'] . " products)</h3>";
    
    // Limit displayed examples if too many
    $examples = $row['product_examples'];
    if (strlen($examples) > 100) {
        $examples = substr($examples, 0, 100) . '...';
    }
    
    echo "<p>Examples: " . htmlspecialchars($examples) . "</p>";
}

$conn->close();
?>
```

### HAVING Clause with GROUP BY

The HAVING clause is used with GROUP BY to filter groups based on aggregate values:

```sql
-- Find categories with more than 10 products
SELECT category, COUNT(*) as count 
FROM products 
GROUP BY category 
HAVING count > 10;

-- Find categories with more than $10,000 in sales
SELECT 
    p.category,
    SUM(oi.quantity * p.price) as total_sales
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.category
HAVING total_sales > 10000
ORDER BY total_sales DESC;
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

$min_sales = 10000;

// Find top-selling categories
$sql = "SELECT 
            p.category,
            SUM(oi.quantity * p.price) as total_sales,
            COUNT(DISTINCT o.id) as order_count
        FROM products p
        JOIN order_items oi ON p.id = oi.product_id
        JOIN orders o ON oi.order_id = o.id
        GROUP BY p.category
        HAVING total_sales > ?
        ORDER BY total_sales DESC";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("d", $min_sales);
$stmt->execute();
$result = $stmt->get_result();

echo "<h2>Categories with Over $" . number_format($min_sales) . " in Sales</h2>";
echo "<table border='1'>";
echo "<tr><th>Category</th><th>Total Sales</th><th>Number of Orders</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>" . htmlspecialchars($row['category']) . "</td>";
    echo "<td>$" . number_format($row['total_sales'], 2) . "</td>";
    echo "<td>" . number_format($row['order_count']) . "</td>";
    echo "</tr>";
}

echo "</table>";

$stmt->close();
$conn->close();
?>
```

### WITH ROLLUP Modifier (MySQL 5.7+)

The ROLLUP modifier adds subtotals and grand totals to GROUP BY results:

```sql
-- Sales summary with subtotals
SELECT 
    IFNULL(category, 'All Categories') as category,
    SUM(price * stock) as inventory_value
FROM products
GROUP BY category WITH ROLLUP;
```

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Inventory report with subtotals
$sql = "SELECT 
            IFNULL(category, 'Total') as category,
            IFNULL(brand, 'All Brands') as brand,
            SUM(stock) as total_stock,
            SUM(price * stock) as inventory_value
        FROM products
        GROUP BY category, brand WITH ROLLUP";
        
$result = $conn->query($sql);
?>

<h2>Inventory Value Report</h2>
<table border="1">
    <thead>
        <tr>
            <th>Category</th>
            <th>Brand</th>
            <th>Stock</th>
            <th>Value</th>
        </tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr <?= $row['brand'] === 'All Brands' || $row['category'] === 'Total' ? 'style="font-weight: bold; background-color: #f0f0f0;"' : '' ?>>
                <td><?= htmlspecialchars($row['category']) ?></td>
                <td><?= htmlspecialchars($row['brand']) ?></td>
                <td><?= number_format($row['total_stock']) ?></td>
                <td>$<?= number_format($row['inventory_value'], 2) ?></td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

## 12. MySQL Subqueries

### Basic Subquery Examples

```sql
-- Find products that cost more than average price
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Find users who have placed orders
SELECT *
FROM users
WHERE id IN (SELECT DISTINCT customer_id FROM orders);
```

### Types of Subqueries

1. **Scalar Subquery** - Returns a single value
   ```sql
   SELECT name, price, 
          (SELECT AVG(price) FROM products) as average_price
   FROM products;
   ```

2. **Row Subquery** - Returns a single row
   ```sql
   SELECT *
   FROM orders
   WHERE (customer_id, total_amount) = 
         (SELECT customer_id, MAX(total_amount) 
          FROM orders 
          GROUP BY customer_id
          ORDER BY MAX(total_amount) DESC
          LIMIT 1);
   ```

3. **Column Subquery** - Returns a single column
   ```sql
   SELECT *
   FROM products
   WHERE id IN (SELECT product_id FROM featured_products);
   ```

4. **Table Subquery** - Returns multiple rows and columns
   ```sql
   SELECT customer_id, COUNT(*) as order_count
   FROM orders
   GROUP BY customer_id
   HAVING COUNT(*) > (
       SELECT AVG(order_count) 
       FROM (
           SELECT customer_id, COUNT(*) as order_count 
           FROM orders 
           GROUP BY customer_id
       ) as customer_orders
   );
   ```

### Using Subqueries with PHP

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Find products priced above average
$sql = "SELECT id, name, price, 
               (SELECT AVG(price) FROM products) as average_price
        FROM products
        WHERE price > (SELECT AVG(price) FROM products)
        ORDER BY price DESC";
        
$result = $conn->query($sql);
?>

<h2>Premium Products (Above Average Price)</h2>
<table border="1">
    <thead>
        <tr>
            <th>Name</th>
            <th>Price</th>
            <th>Compared to Average</th>
        </tr>
    </thead>
    <tbody>
        <?php 
        $average = 0;
        if ($row = $result->fetch_assoc()) {
            $average = $row['average_price'];
            $result->data_seek(0); // Reset result pointer
        }
        
        while ($row = $result->fetch_assoc()): 
            $percent_above = ($row['price'] - $average) / $average * 100;
        ?>
            <tr>
                <td><?= htmlspecialchars($row['name']) ?></td>
                <td>$<?= number_format($row['price'], 2) ?></td>
                <td><?= number_format($percent_above, 1) ?>% above average</td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

### Finding Top Customers with Subqueries

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Find top 10 customers by total spend
$sql = "SELECT 
            u.id,
            u.name,
            u.email,
            (SELECT COUNT(*) FROM orders WHERE customer_id = u.id) as order_count,
            (SELECT SUM(total_amount) FROM orders WHERE customer_id = u.id) as total_spent,
            (SELECT MAX(order_date) FROM orders WHERE customer_id = u.id) as last_order_date
        FROM users u
        WHERE u.id IN (SELECT DISTINCT customer_id FROM orders)
        HAVING total_spent > 0
        ORDER BY total_spent DESC
        LIMIT 10";
        
$result = $conn->query($sql);
?>

<h2>Top 10 Customers</h2>
<table border="1">
    <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Orders</th>
            <th>Total Spent</th>
            <th>Last Order</th>
        </tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= htmlspecialchars($row['name']) ?></td>
                <td><?= htmlspecialchars($row['email']) ?></td>
                <td><?= number_format($row['order_count']) ?></td>
                <td>$<?= number_format($row['total_spent'], 2) ?></td>
                <td><?= $row['last_order_date'] ?></td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

### EXISTS and NOT EXISTS Operators

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Find products that have never been ordered
$sql = "SELECT p.id, p.name, p.price, p.stock
        FROM products p
        WHERE NOT EXISTS (
            SELECT 1 FROM order_items oi WHERE oi.product_id = p.id
        )
        ORDER BY p.name";
        
$result = $conn->query($sql);
?>

<h2>Products With No Sales</h2>
<?php if ($result->num_rows > 0): ?>
    <table border="1">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($row['name']) ?></td>
                    <td>$<?= number_format($row['price'], 2) ?></td>
                    <td><?= $row['stock'] ?></td>
                    <td>
                        <a href="edit_product.php?id=<?= $row['id'] ?>">Edit</a> |
                        <a href="promote_product.php?id=<?= $row['id'] ?>">Promote</a>
                    </td>
                </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
<?php else: ?>
    <p>All products have been sold at least once.</p>
<?php endif; ?>

<?php $conn->close(); ?>
```

### Correlated Subqueries

A correlated subquery refers to columns from the outer query:

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Find customers who spent more than their average order
$sql = "SELECT o.id, o.order_date, o.total_amount, u.name AS customer_name
        FROM orders o
        JOIN users u ON o.customer_id = u.id
        WHERE o.total_amount > (
            SELECT AVG(total_amount)
            FROM orders
            WHERE customer_id = o.customer_id
        )
        ORDER BY o.order_date DESC
        LIMIT 20";
        
$result = $conn->query($sql);
?>

<h2>Above-Average Orders</h2>
<table border="1">
    <thead>
        <tr>
            <th>Order ID</th>
            <th>Date</th>
            <th>Customer</th>
            <th>Amount</th>
        </tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['order_date'] ?></td>
                <td><?= htmlspecialchars($row['customer_name']) ?></td>
                <td>$<?= number_format($row['total_amount'], 2) ?></td>
            </tr>
        <?php endwhile; ?>
    </tbody>
</table>

<?php $conn->close(); ?>
```

## 13. MySQL Joins

### Types of Joins

- **INNER JOIN**: Returns records with matching values in both tables
- **LEFT JOIN**: Returns all records from the left table and matched records from the right
- **RIGHT JOIN**: Returns all records from the right table and matched records from the left
- **FULL JOIN** (not directly supported in MySQL): Emulated with UNION of LEFT and RIGHT JOINs

### Basic JOIN Examples

```sql
-- INNER JOIN
SELECT 
    orders.id, 
    orders.order_date, 
    users.name AS customer_name
FROM orders
INNER JOIN users ON orders.customer_id = users.id;

-- LEFT JOIN
SELECT 
    users.name, 
    COUNT(orders.id) AS order_count
FROM users
LEFT JOIN orders ON users.id = orders.customer_id
GROUP BY users.id;

-- Multiple JOINs
SELECT 
    o.id AS order_id,
    u.name AS customer_name,
    p.name AS product_name,
    oi.quantity,
    oi.quantity * p.price AS subtotal
FROM orders o
JOIN users u ON o.customer_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
ORDER BY o.id;
```

### Using Joins with PHP

```php
<?php
$conn = new mysqli("localhost", "username", "password", "database");

// Get order details with customer information
$order_id = 123; // Example order ID

$sql = "SELECT 
            o.id AS order_id,
            o.order_date,
            o.total_amount,
            u.name AS customer_name,
            u.email AS customer_email,
            u.address
        FROM orders o
        JOIN users u ON o.customer_id = u.id
        WHERE o.id = ?";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $order_id);
$stmt->execute();
$order = $stmt->get_result()->fetch_assoc();
$stmt->close();

// Get order items with product details
$sql = "SELECT 
            oi.quantity,
            p.id AS product_id,
            p.name AS product_name,
            p.price,
            oi.quantity * p.price AS subtotal
        FROM order_items oi
        JOIN products p ON oi.product_id = p.id
        WHERE oi.order_id = ?
        ORDER BY p.name";
        
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $order_id);
$stmt->execute();
$items = $stmt->get_result();
$stmt->close();
?>

<h2>Order #<?= $order['order_id'] ?></h2>
<p><strong>Date:</strong> <?= $order['order_date'] ?></p>
<p><strong>Customer:</strong> <?= htmlspecialchars($order['customer_name']) ?></p>
<p><strong>Email:</strong> <?= htmlspecialchars($order['customer_email']) ?></p>
<p><strong>Address:</strong> <?= nl2br(htmlspecialchars($order['address'])) ?></p>

<h3>Items</h3>
<table border="1">
    <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        <?php 
        $total = 0;
        while ($item = $items->fetch_assoc()): 
            $total += $item['subtotal'];
        ?>
            <tr>
                <td><?= htmlspecialchars($item['product_name']) ?></td>
                <td>$<?= number_format($item['price'], 2) ?></td>
                <td><?= $item['quantity'] ?></td>
                <td>$<?= number_format($item['subtotal'], 2) ?></td>
            </tr>
        <?php endwhile; ?>
            <tr>
                <td colspan="3" style="text-align: right;"><strong>Total:</strong></td>
                <td><strong>$<?= number_format($total, 2) ?></strong></td>
            </tr>
    </tbody>
</table>

<?php $conn->close(); ?>
```