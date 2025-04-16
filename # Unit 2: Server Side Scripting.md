# Unit 2: Server Side Scripting with Database Connectivity - PHP

## 1. Introduction to Server Side Scripting

### What is Server Side Scripting?
Server-side scripting is a web development technique where scripts run on the web server before the content is sent to the user's browser. Key characteristics include:

- Code executes on the web server, not the client's browser
- Generates dynamic HTML content based on user requests
- Can interact with databases, files, and other server resources
- Not visible to end users (source code cannot be viewed)
- Used for data processing, authentication, and personalization

### Why Server Side Scripting?
- **Security**: Sensitive operations happen on trusted servers
- **Database Access**: Can safely connect to databases
- **Reduced Client Load**: Processing happens on powerful servers
- **Browser Compatibility**: Sends only standard HTML/CSS/JS to browsers
- **Session Management**: Can maintain state between user requests
- **File System Access**: Can read/write files on the server
- **Data Processing**: Can process form data, upload files, etc.

### Common Server Side Scripting Languages
- **PHP**: Most popular, specifically designed for web development
- **Node.js**: JavaScript on the server
- **Python**: Used with frameworks like Django, Flask
- **Ruby**: Used with frameworks like Ruby on Rails
- **Java**: Used with technologies like JSP, Servlets
- **C#**: Used with ASP.NET

### Client Side vs. Server Side Scripting

| Aspect | Client Side (JavaScript) | Server Side (PHP) |
|--------|--------------------------|-------------------|
| Execution | Browser | Web Server |
| Visibility | Code visible to users | Code hidden from users |
| Loading | Reduces server load | Increases server load |
| Databases | Limited access (needs API) | Direct access |
| Security | Less secure for sensitive operations | More secure for sensitive operations |
| Environment | Varies by browser | Consistent (controlled by developer) |
| Interactivity | Immediate response | Requires page reload (unless using AJAX) |

## 2. PHP Introduction

### What is PHP?
PHP (PHP: Hypertext Preprocessor) is an open-source server-side scripting language designed specifically for web development. Originally created by Rasmus Lerdorf in 1994, it has evolved into one of the most widely used languages for web development.

### Key Features of PHP
- **Free and Open Source**: Large community and extensive documentation
- **Cross-Platform**: Runs on various operating systems (Windows, Linux, macOS)
- **Database Integration**: Easy connectivity with most databases
- **Built for the Web**: Designed specifically for web applications
- **Easy to Learn**: Familiar syntax for those with C, Java, or JavaScript experience
- **Embedded in HTML**: Can be mixed directly with HTML
- **Large Ecosystem**: Many frameworks (Laravel, Symfony, CodeIgniter, etc.)
- **Wide Hosting Support**: Supported by virtually all web hosting providers

### PHP Versions
- PHP 7+ introduced significant performance improvements and type declarations
- PHP 8+ (current version) added features like union types, named arguments, attributes, JIT compilation
- Always use the latest stable version when possible for security and features

### PHP Architecture
1. **Client** sends a request to the web server
2. **Web Server** recognizes PHP file (by .php extension)
3. **PHP Engine** processes the PHP code
4. PHP may interact with **Database** or **File System**
5. PHP generates **HTML Output**
6. **Web Server** sends HTML to client
7. **Client Browser** renders the HTML

### Setting Up PHP Environment
- **Option 1**: Install web server (Apache/Nginx), PHP, and MySQL/MariaDB individually
- **Option 2**: Use all-in-one packages:
  - XAMPP (Cross-platform)
  - WAMP (Windows)
  - MAMP (macOS)
  - LAMP (Linux)

### Your First PHP Script
```php
<!DOCTYPE html>
<html>
<head>
    <title>My First PHP Page</title>
</head>
<body>
    <h1>Welcome to PHP</h1>
    
    <?php
        // This is a PHP code block
        echo "Hello, World!";
        
        // Variables and simple operations
        $name = "Student";
        $year = 2025;
        
        echo "<p>Hello, $name! Welcome to $year.</p>";
        
        // Conditional output
        $hour = date('H');
        if ($hour < 12) {
            echo "<p>Good morning!</p>";
        } else if ($hour < 18) {
            echo "<p>Good afternoon!</p>";
        } else {
            echo "<p>Good evening!</p>";
        }
    ?>
    
    <p>This is regular HTML again.</p>
</body>
</html>
```

## 3. Basic PHP Syntax

### PHP Tags
PHP code must be enclosed within special tags:

```php
<?php
    // PHP code goes here
?>
```

Short echo tag (shorthand for outputting content):
```php
<?= "Hello, World!" ?>
<!-- Equivalent to <?php echo "Hello, World!"; ?> -->
```

### Statements and Semicolons
Every PHP statement must end with a semicolon:

```php
<?php
    echo "First statement";
    echo "Second statement";
    $variable = "Assignment is also a statement";
?>
```

Forgetting semicolons is a common error for beginners.

### PHP and HTML Integration

**Method 1: PHP blocks within HTML**
```php
<!DOCTYPE html>
<html>
<body>
    <h1>My Website</h1>
    <p>Todays date: <?php echo date('Y-m-d'); ?></p>
    
    <?php if ($user_logged_in): ?>
        <p>Welcome back, <?= $username ?>!</p>
    <?php else: ?>
        <p>Please log in</p>
    <?php endif; ?>
</body>
</html>
```

**Method 2: HTML within PHP (not recommended for large chunks)**
```php
<?php
    echo "<h1>Generated Heading</h1>";
    echo "<p>This paragraph is generated by PHP.</p>";
    
    if ($condition) {
        echo "<p>Conditional content</p>";
    }
?>
```

### Whitespace and Line Breaks
PHP ignores extra whitespace and line breaks:

```php
<?php
    echo "Hello";
    
    
    echo "World";  // Works the same as if there were no empty lines
    
    // Line breaks within strings need to be managed
    echo "Line 1
    Line 2";  // This will output with the line break
?>
```

### PHP Case Sensitivity

**Case-sensitive**:
- Variables: `$name` vs `$Name` (different variables)
- Constants: `PI` vs `pi` (different constants)
- Array keys: `array['key']` vs `array['Key']` (different keys)
- Function/method names defined by you: `myFunction()` vs `MyFunction()`
- Class names: `class MyClass` vs `class myclass`

**Case-insensitive**:
- PHP keywords: `echo` vs `ECHO` vs `Echo` (all work)
- Built-in function names: `strlen()` vs `STRLEN()`
- Built-in class names: `PDO` vs `pdo`

Best practice is to follow consistent conventions:
- camelCase for variables and functions
- PascalCase for classes
- UPPER_CASE for constants

## 4. Comments in PHP

### Single-line Comments
```php
<?php
    // This is a single-line comment
    
    echo "Hello"; // Comments can appear after code
    
    # This is also a single-line comment (less common)
?>
```

### Multi-line Comments
```php
<?php
    /* This is a multi-line comment
       Everything between the opening and closing
       markers is ignored by PHP
    */
    
    echo "Hello";
    
    /*
     * Some developers use this style
     * with asterisks at the beginning
     * of each line for readability
     */
?>
```

### DocBlock Comments
Used for documentation, especially with tools like PHPDoc:

```php
<?php
    /**
     * Calculates the sum of two numbers
     *
     * @param int $a First number
     * @param int $b Second number
     * @return int Sum of the numbers
     */
    function add($a, $b) {
        return $a + $b;
    }
?>
```

### Comment Best Practices
- Use comments to explain "why" not "what"
- Keep comments up-to-date with code changes
- Don't comment obvious things
- Use comments for temporarily disabling code during debugging
- Document function parameters, return values, and exceptions

## 5. Variables in PHP

### Variable Basics
Variables in PHP:
- Start with a dollar sign ($)
- Followed by a letter or underscore
- Can contain letters, numbers, and underscores
- Are case-sensitive
- Don't need to be declared before use
- Don't have explicit types (dynamically typed)

```php
<?php
    $name = "John";
    $age = 25;
    $is_student = true;
    $price = 19.99;
    
    // Variable names are case-sensitive
    $Name = "Different variable";  // Different from $name
    
    // Valid variable names
    $user_id = 42;
    $userId = 42;    // Camel case (recommended)
    $_private = "Hidden";
    $x123 = "Numbered";
    
    // Invalid variable names
    // $123x = "Starts with number";  // Would cause error
    // $my-var = "Has hyphen";        // Would cause error
    // $my var = "Has space";         // Would cause error
?>
```

### Dynamic Variable Names (Variable Variables)
```php
<?php
    $foo = "bar";
    $$foo = "baz";  // Creates a variable named $bar with value "baz"
    
    echo $foo;      // Outputs: bar
    echo $$foo;     // Outputs: baz
    echo $bar;      // Outputs: baz
?>
```

### Variable Assignment and References
```php
<?php
    // Regular assignment (copies the value)
    $a = 10;
    $b = $a;
    $b = 20;  // Doesn't affect $a
    echo $a;  // Outputs: 10
    
    // Reference assignment (creates an alias)
    $x = 10;
    $y = &$x;  // $y references $x
    $y = 20;   // Also changes $x
    echo $x;   // Outputs: 20
?>
```

### Variable Scope

**Local Scope**: Variables defined inside a function
```php
<?php
    function test() {
        $local = "I'm local";
        echo $local;  // Accessible
    }
    
    test();
    // echo $local;  // Error - not accessible outside function
?>
```

**Global Scope**: Variables defined outside functions
```php
<?php
    $global_var = "I'm global";
    
    function test() {
        // echo $global_var;  // Error - not accessible inside function
        
        global $global_var;  // Declare access to global variable
        echo $global_var;    // Now accessible
    }
    
    test();
?>
```

**Static Variables**: Retain value between function calls
```php
<?php
    function counter() {
        static $count = 0;  // Initialized only once
        $count++;
        echo $count;
    }
    
    counter();  // Outputs: 1
    counter();  // Outputs: 2
    counter();  // Outputs: 3
?>
```

**Superglobal Variables**: Built-in variables that are always accessible
```php
<?php
    // Examples of superglobals:
    echo $_SERVER['HTTP_USER_AGENT'];  // Browser info
    echo $_GET['id'];                  // URL parameter
    echo $_POST['username'];           // Form submission data
    echo $_SESSION['user_id'];         // Session data
    // More on these later
?>
```

### Variable Types
PHP is loosely typed, but variables do have types:

```php
<?php
    // Scalar types
    $string = "Hello";          // String
    $integer = 42;              // Integer
    $float = 3.14;              // Floating-point number
    $boolean = true;            // Boolean (true/false)
    
    // Compound types
    $array = [1, 2, 3];         // Array
    $object = new stdClass();   // Object
    
    // Special types
    $null = null;               // Null (no value)
    $resource = fopen('file.txt', 'r');  // Resource (handle to external resource)
    
    // Check type
    echo gettype($string);      // "string"
    var_dump($integer);         // int(42)
    
    // Type checking
    echo is_string($string);    // 1 (true)
    echo is_int($float);        // (nothing, false)
?>
```

### Type Juggling (Automatic Type Conversion)
PHP automatically converts types as needed:

```php
<?php
    $sum = "10" + 20;      // 30 (integer)
    $concat = "10" . 20;   // "1020" (string)
    
    // Type casting
    $str = "42";
    $num = (int)$str;      // Explicit conversion to integer
    
    $bool = (bool)"";      // false (empty string converts to false)
    $bool2 = (bool)"0";    // false
    $bool3 = (bool)"1";    // true
    
    // When used in conditions
    if ("0") {             // false (string "0" is considered false)
        echo "This won't print";
    }
    
    if ("00") {            // true (string "00" is NOT "0", so it's true)
        echo "This will print";
    }
?>
```

### Constants
Unlike variables, constants don't use the $ prefix and can't be changed after definition:

```php
<?php
    // Define a constant
    define("PI", 3.14159);
    define("DB_HOST", "localhost");
    
    // Using constants
    echo PI;      // 3.14159
    
    // Alternative syntax (PHP 5.3+)
    const APP_NAME = "My Application";
    const APP_VERSION = 1.0;
    
    // Predefined constants
    echo PHP_VERSION;  // Current PHP version
    echo __FILE__;     // Current file path
    echo __LINE__;     // Current line number
?>
```

## 6. PHP Operators

### Arithmetic Operators
```php
<?php
    $a = 10;
    $b = 3;
    
    echo $a + $b;  // Addition: 13
    echo $a - $b;  // Subtraction: 7
    echo $a * $b;  // Multiplication: 30
    echo $a / $b;  // Division: 3.3333...
    echo $a % $b;  // Modulus (remainder): 1
    echo $a ** $b; // Exponentiation (10^3): 1000
?>
```

### Assignment Operators
```php
<?php
    $a = 10;       // Basic assignment
    
    $a += 5;       // Same as: $a = $a + 5;  (result: 15)
    $a -= 3;       // Same as: $a = $a - 3;  (result: 12)
    $a *= 2;       // Same as: $a = $a * 2;  (result: 24)
    $a /= 4;       // Same as: $a = $a / 4;  (result: 6)
    $a %= 4;       // Same as: $a = $a % 4;  (result: 2)
    
    $str = "Hello";
    $str .= " World"; // Concatenation assignment (result: "Hello World")
?>
```

### Comparison Operators
```php
<?php
    $a = 10;
    $b = "10";
    $c = 20;
    
    // Regular comparison (value only)
    var_dump($a == $b);   // bool(true)
    var_dump($a != $c);   // bool(true)
    var_dump($a <> $c);   // bool(true) (alternative for !=)
    
    // Strict comparison (value and type)
    var_dump($a === $b);  // bool(false) (different types)
    var_dump($a !== $b);  // bool(true)
    
    // Relational
    var_dump($a < $c);    // bool(true)
    var_dump($a > $c);    // bool(false)
    var_dump($a <= $c);   // bool(true)
    var_dump($a >= $c);   // bool(false)
    
    // Spaceship operator (PHP 7+) - returns -1, 0, or 1
    var_dump($a <=> $c);  // int(-1) (a is less than c)
    var_dump($c <=> $a);  // int(1) (c is greater than a)
    var_dump($a <=> $a);  // int(0) (equal)
?>
```

### Increment/Decrement Operators
```php
<?php
    $a = 5;
    
    // Post-increment
    echo $a++;    // Outputs 5, then increments to 6
    echo $a;      // Outputs 6
    
    // Pre-increment
    $a = 5;
    echo ++$a;    // Increments to 6, then outputs 6
    
    // Post-decrement
    $a = 5;
    echo $a--;    // Outputs 5, then decrements to 4
    
    // Pre-decrement
    $a = 5;
    echo --$a;    // Decrements to 4, then outputs 4
?>
```

### Logical Operators
```php
<?php
    $a = true;
    $b = false;
    
    // AND
    var_dump($a && $b);  // bool(false)
    var_dump($a and $b); // bool(false) (alternative syntax)
    
    // OR
    var_dump($a || $b);  // bool(true)
    var_dump($a or $b);  // bool(true) (alternative syntax)
    
    // XOR (exclusive OR - true if one is true, but not both)
    var_dump($a xor $b); // bool(true)
    
    // NOT
    var_dump(!$a);       // bool(false)
    
    // Operator precedence is important
    // && has higher precedence than and
    $c = false || true;              // $c is true
    $d = false or true;              // $d is false (assignment has higher precedence)
    $e = (false or true);            // $e is true
?>
```

### String Operators
```php
<?php
    $a = "Hello";
    $b = "World";
    
    // Concatenation
    echo $a . " " . $b;  // "Hello World"
    
    // Concatenation assignment
    $a .= " " . $b;
    echo $a;             // "Hello World"
?>
```

### Array Operators
```php
<?php
    $a = ["apple" => "red", "banana" => "yellow"];
    $b = ["banana" => "yellow", "orange" => "orange"];
    
    // Union - combines arrays, uses keys from first array for duplicates
    $c = $a + $b;
    print_r($c);  // ["apple" => "red", "banana" => "yellow", "orange" => "orange"]
    
    // Equality - same key/value pairs
    var_dump($a == $b);  // bool(false)
    
    // Identity - same key/value pairs in same order and of same types
    var_dump($a === $b); // bool(false)
    
    // Inequality
    var_dump($a != $b);  // bool(true)
    var_dump($a <> $b);  // bool(true)
    
    // Non-identity
    var_dump($a !== $b); // bool(true)
?>
```

### Conditional (Ternary) Operator
```php
<?php
    $age = 20;
    
    // Long form
    $status = ($age >= 18) ? "adult" : "minor";
    echo $status;  // "adult"
    
    // Short form (Elvis operator) - returns first operand if it exists and is not NULL, otherwise second operand
    $name = $user_name ?? "Guest";
    
    // Nested ternary (use with caution - can be hard to read)
    $result = ($a > 0) ? "positive" : (($a < 0) ? "negative" : "zero");
?>
```

### Type Operators
```php
<?php
    class MyClass {}
    $obj = new MyClass();
    
    // instanceof - checks if object is of a certain class
    var_dump($obj instanceof MyClass);  // bool(true)
?>
```

### Operator Precedence
Operators are evaluated in a specific order. When in doubt, use parentheses to ensure operations happen in the intended order.

```php
<?php
    // Without parentheses - multiplication happens first
    echo 5 + 3 * 2;      // 11
    
    // With parentheses - addition happens first
    echo (5 + 3) * 2;    // 16
    
    // Complex example
    $result = 10 + 5 * 3 - 2 / 2;  // 10 + 15 - 1 = 24
?>
```

## 7. Control Structures

### If, Else, Elseif Statements

**Basic if statement**
```php
<?php
    $age = 25;
    
    if ($age >= 18) {
        echo "You are an adult.";
    }
?>
```

**If-else statement**
```php
<?php
    $age = 15;
    
    if ($age >= 18) {
        echo "You are an adult.";
    } else {
        echo "You are a minor.";
    }
?>
```

**If-elseif-else statement**
```php
<?php
    $score = 85;
    
    if ($score >= 90) {
        echo "Grade: A";
    } elseif ($score >= 80) {
        echo "Grade: B";
    } elseif ($score >= 70) {
        echo "Grade: C";
    } elseif ($score >= 60) {
        echo "Grade: D";
    } else {
        echo "Grade: F";
    }
?>
```

**Alternative syntax (useful in templates)**
```php
<?php if ($condition): ?>
    <p>This will show if condition is true</p>
<?php else: ?>
    <p>This will show if condition is false</p>
<?php endif; ?>
```

### Switch Statement

```php
<?php
    $day = "Monday";
    
    switch ($day) {
        case "Monday":
            echo "Start of work week";
            break;
        
        case "Wednesday":
            echo "Mid-week";
            break;
        
        case "Friday":
            echo "End of work week";
            break;
        
        case "Saturday":
        case "Sunday":
            echo "Weekend";
            break;
        
        default:
            echo "Regular day";
            break;
    }
?>
```

Notes about switch:
- The `break` statement is important - without it, execution continues to the next case
- Multiple cases can share the same code block
- `default` is executed when no cases match
- Switch uses `==` comparison, not `===`

### Loops

**While Loop**
```php
<?php
    $i = 1;
    
    while ($i <= 5) {
        echo "$i ";
        $i++;
    }
    // Outputs: 1 2 3 4 5
?>
```

**Do-While Loop** - always executes at least once
```php
<?php
    $i = 1;
    
    do {
        echo "$i ";
        $i++;
    } while ($i <= 5);
    // Outputs: 1 2 3 4 5
    
    // Even with a false condition, it executes once
    $j = 10;
    do {
        echo "This will print once";
        $j++;
    } while ($j < 10);
?>
```

**For Loop**
```php
<?php
    for ($i = 1; $i <= 5; $i++) {
        echo "$i ";
    }
    // Outputs: 1 2 3 4 5
    
    // Multiple expressions in each part
    for ($i = 1, $j = 10; $i <= 5; $i++, $j--) {
        echo "$i-$j ";
    }
    // Outputs: 1-10 2-9 3-8 4-7 5-6
    
    // Parts can be empty
    $i = 1;
    for (; $i <= 5; $i++) {
        echo "$i ";
    }
    // Outputs: 1 2 3 4 5
?>
```

**Foreach Loop** - specifically for arrays
```php
<?php
    $colors = ["red", "green", "blue"];
    
    // Simple iteration
    foreach ($colors as $color) {
        echo "$color ";
    }
    // Outputs: red green blue
    
    // With key and value
    $ages = ["John" => 35, "Mary" => 28, "Bob" => 42];
    
    foreach ($ages as $name => $age) {
        echo "$name is $age years old. ";
    }
    // Outputs: John is 35 years old. Mary is 28 years old. Bob is 42 years old.
    
    // By reference - modify the array during iteration
    $numbers = [1, 2, 3, 4, 5];
    
    foreach ($numbers as &$number) {
        $number *= 2;
    }
    unset($number); // Important: break the reference
    
    print_r($numbers);
    // Outputs: Array ( [0] => 2 [1] => 4 [2] => 6 [3] => 8 [4] => 10 )
?>
```

**Alternative syntax for loops**
```php
<?php foreach ($items as $item): ?>
    <li><?= $item ?></li>
<?php endforeach; ?>

<?php for ($i = 0; $i < 5; $i++): ?>
    <p>Item <?= $i ?></p>
<?php endfor; ?>

<?php while ($condition): ?>
    <p>Content</p>
<?php endwhile; ?>
```

### Break and Continue

**Break** - exits the loop completely
```php
<?php
    for ($i = 1; $i <= 10; $i++) {
        if ($i == 5) {
            break;
        }
        echo "$i ";
    }
    // Outputs: 1 2 3 4
?>
```

**Continue** - skips the current iteration
```php
<?php
    for ($i = 1; $i <= 10; $i++) {
        if ($i % 2 == 0) {
            continue; // Skip even numbers
        }
        echo "$i ";
    }
    // Outputs: 1 3 5 7 9
?>
```

**Nested loops and break/continue levels**
```php
<?php
    for ($i = 1; $i <= 3; $i++) {
        for ($j = 1; $j <= 3; $j++) {
            if ($i * $j == 6) {
                break 2; // Break out of both loops
            }
            echo "($i,$j) ";
        }
        echo "| ";
    }
    // Outputs: (1,1) (1,2) (1,3) | (2,1) (2,2) 
?>
```

### Match Expression (PHP 8+)
More concise than switch, with stricter comparison and always returns a value:

```php
<?php
    $status_code = 404;
    
    $message = match ($status_code) {
        200, 201 => "Success",
        400 => "Bad request",
        404 => "Not found",
        500 => "Server error",
        default => "Unknown status code",
    };
    
    echo $message; // "Not found"
?>
```

## 8. Arrays in PHP

### Array Basics

Arrays in PHP are ordered maps that associate keys with values:

```php
<?php
    // Creating arrays
    
    // Indexed array with numeric keys (starting at 0)
    $fruits = ["apple", "banana", "cherry"];
    
    // Associative array with string keys
    $person = [
        "name" => "John",
        "age" => 30,
        "city" => "New York"
    ];
    
    // Mixed array (both numeric and string keys)
    $mixed = [
        "name" => "Product",
        0 => 42,
        "features" => ["feature1", "feature2"]
    ];
    
    // Alternative syntax (older style)
    $fruits = array("apple", "banana", "cherry");
    $person = array("name" => "John", "age" => 30);
    
    // Accessing array elements
    echo $fruits[0];       // "apple"
    echo $person["name"];  // "John"
    
    // Modifying array elements
    $fruits[1] = "orange"; // Replace "banana" with "orange"
    $person["age"] = 31;   // Update age to 31
    
    // Adding elements
    $fruits[] = "mango";             // Add to end of indexed array
    $person["country"] = "USA";      // Add new key-value pair
    
    // Checking if a key exists
    if (isset($person["age"])) {
        echo "Age is set";
    }
    
    // Removing elements
    unset($fruits[1]);    // Remove the element at index 1
    unset($person["age"]); // Remove the "age" element
?>
```

### Array Functions

```php
<?php
    $numbers = [4, 2, 8, 6, 0];
    $fruits = ["apple", "banana", "cherry"];
    
    // Count elements
    echo count($numbers);  // 5
    
    // Check if value exists
    var_dump(in_array("banana", $fruits));  // bool(true)
    
    // Find key for a value
    echo array_search("banana", $fruits);  // 1
    
    // Check if key exists
    var_dump(array_key_exists("name", $person));  // bool(true)
    
    // Add elements
    array_push($fruits, "orange", "mango");  // Add to end
    array_unshift($fruits, "kiwi");          // Add to beginning
    
    // Remove elements
    $last = array_pop($fruits);   // Remove and return last element
    $first = array_shift($fruits); // Remove and return first element
    
    // Sorting
    sort($numbers);        // Sort values in ascending order
    rsort($numbers);       // Sort values in descending order
    asort($person);        // Sort associative array by values
    ksort($person);        // Sort associative array by keys
    arsort($person);       // Sort associative array by values (descending)
    krsort($person);       // Sort associative array by keys (descending)
    usort($fruits, function($a, $b) {  // Custom sort
        return strlen($a) - strlen($b); // Sort by string length
    });
    
    // Merging arrays
    $combined = array_merge($fruits, $numbers);
    
    // Filtering arrays
    $filtered = array_filter($numbers, function($value) {
        return $value > 4;  // Keep only values greater than 4
    });
    print_r($filtered); // [2 => 8, 3 => 6]
    
    // Mapping arrays (transform each value)
    $doubled = array_map(function($value) {
        return $value * 2;
    }, $numbers);
    print_r($doubled); // [0 => 8, 1 => 4, 2 => 16, 3 => 12, 4 => 0]
    
    // Reducing arrays (combine elements into single value)
    $sum = array_reduce($numbers, function($carry, $value) {
        return $carry + $value;
    }, 0); // 0 is the initial value
    echo $sum; // 20
    
    // Keys and values as separate arrays
    $keys = array_keys($person);
    $values = array_values($person);
    
    // Combine separate arrays into key-value pairs
    $days = ["Mon", "Tue", "Wed"];
    $status = ["Working", "Meeting", "Working"];
    $schedule = array_combine($days, $status);
    print_r($schedule); // ["Mon" => "Working", "Tue" => "Meeting", "Wed" => "Working"]
    
    // Slice array (extract portion)
    $slice = array_slice($fruits, 1, 2); // Start at index 1, get 2 elements
    
    // Splice array (remove/replace portion)
    array_splice($fruits, 1, 2, ["grape", "melon"]); // Replace 2 elements from index 1
    
    // Check intersection and difference
    $set1 = [1, 2, 3, 4, 5];
    $set2 = [3, 4, 5, 6, 7];
    $common = array_intersect($set1, $set2); // [3, 4, 5]
    $diff = array_diff($set1, $set2); // [1, 2]
    
    // Chunk array into groups
    $groups = array_chunk($numbers, 2); // Split into groups of 2
    
    // Flip keys and values
    $flipped = array_flip($schedule); // Values become keys and vice versa
    
    // Fill array with values
    $filled = array_fill(0, 5, "default"); // 5 elements with value "default"
    
    // Count value frequencies
    $data = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4];
    $counts = array_count_values($data); // [1 => 1, 2 => 2, 3 => 3, 4 => 4]
    
    // Shuffle array (randomize order)
    shuffle($numbers);
    
    // Generate range of values
    $range = range(1, 10); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    $letters = range('a', 'e'); // ['a', 'b', 'c', 'd', 'e']
?>
```

### Multidimensional Arrays

Arrays can contain other arrays, creating hierarchical data structures:

```php
<?php
    // Two-dimensional array
    $matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ];
    
    // Accessing elements
    echo $matrix[1][2]; // 6 (row 1, column 2)
    
    // Associative multidimensional array
    $users = [
        "john" => [
            "name" => "John Doe",
            "email" => "john@example.com",
            "roles" => ["editor", "admin"]
        ],
        "jane" => [
            "name" => "Jane Smith",
            "email" => "jane@example.com",
            "roles" => ["subscriber"]
        ]
    ];
    
    // Accessing nested elements
    echo $users["john"]["email"]; // john@example.com
    echo $users["jane"]["roles"][0]; // subscriber
    
    // Looping through multidimensional arrays
    foreach ($users as $username => $userdata) {
        echo "User: $username\n";
        echo "Name: " . $userdata["name"] . "\n";
        echo "Roles: " . implode(", ", $userdata["roles"]) . "\n";
    }
    
    // Adding to multidimensional arrays
    $users["mary"] = [
        "name" => "Mary Johnson",
        "email" => "mary@example.com",
        "roles" => ["editor"]
    ];
    
    // Modifying multidimensional arrays
    $users["john"]["roles"][] = "author";
?>
```

### Destructuring Arrays (PHP 7.1+)
```php
<?php
    // Basic list destructuring
    $array = [1, 2, 3];
    [$a, $b, $c] = $array;
    echo $a; // 1
    echo $b; // 2
    echo $c; // 3
    
    // Skip elements
    [, $second, ] = $array;
    echo $second; // 2
    
    // Destructure with keys
    $person = ["name" => "John", "age" => 30];
    ["name" => $name, "age" => $age] = $person;
    echo $name; // "John"
    echo $age;  // 30
    
    // Nested destructuring
    $data = [1, 2, [3, 4]];
    [$x, $y, [$z, $w]] = $data;
    echo $z; // 3
?>
```

### Array Spreading (PHP 7.4+)
```php
<?php
    $array1 = [1, 2, 3];
    $array2 = [4, 5, 6];
    
    // Combining arrays using spread operator
    $combined = [...$array1, ...$array2]; // [1, 2, 3, 4, 5, 6]
    
    // Adding elements with spread
    $newArray = [0, ...$array1, 4]; // [0, 1, 2, 3, 4]
    
    // Spreading in function calls
    function add($a, $b, $c) {
        return $a + $b + $c;
    }
    
    $numbers = [1, 2, 3];
    echo add(...$numbers); // 6
?>
```

## 9. For Each Loop

The foreach loop is specifically designed for iterating over arrays in PHP:

### Basic Foreach Structure
```php
<?php
    // Simple indexed array
    $colors = ["red", "green", "blue"];
    
    foreach ($colors as $color) {
        echo $color . " ";
    }
    // Outputs: red green blue
?>
```

### With Key and Value
```php
<?php
    // Associative array
    $ages = [
        "John" => 25,
        "Mary" => 30,
        "Bob" => 22
    ];
    
    foreach ($ages as $name => $age) {
        echo "$name is $age years old. ";
    }
    // Outputs: John is 25 years old. Mary is 30 years old. Bob is 22 years old.
?>
```

### Modifying Elements by Reference
```php
<?php
    $numbers = [1, 2, 3, 4, 5];
    
    // Without reference - doesn't modify the original array
    foreach ($numbers as $number) {
        $number *= 2; // Only modifies the copy
    }
    print_r($numbers); // Still [1, 2, 3, 4, 5]
    
    // With reference - modifies the original array
    foreach ($numbers as &$number) {
        $number *= 2;
    }
    // Important: Unset the reference when done to prevent accidental modifications later
    unset($number);
    
    print_r($numbers); // Now [2, 4, 6, 8, 10]
?>
```

### Iterating Over Multidimensional Arrays
```php
<?php
    $students = [
        ["name" => "Alice", "grades" => [85, 92, 78]],
        ["name" => "Bob", "grades" => [90, 87, 93]],
        ["name" => "Charlie", "grades" => [82, 88, 85]]
    ];
    
    foreach ($students as $student) {
        echo "Name: " . $student["name"] . "\n";
        echo "Grades: ";
        
        // Nested foreach for the grades array
        foreach ($student["grades"] as $grade) {
            echo $grade . " ";
        }
        
        // Calculate average
        $average = array_sum($student["grades"]) / count($student["grades"]);
        echo "\nAverage: " . round($average, 2) . "\n\n";
    }
?>
```

### Breaking or Continuing a Foreach Loop
```php
<?php
    $data = [5, 10, 15, 0, 20];
    
    foreach ($data as $key => $value) {
        // Skip if value is zero
        if ($value === 0) {
            echo "Skipping zero at position $key\n";
            continue;
        }
        
        // Break if value is greater than 15
        if ($value > 15) {
            echo "Stopping at value $value\n";
            break;
        }
        
        echo "Processing value: $value\n";
    }
?>
```

### Alternative Syntax (Useful in Templates)
```php
<?php $items = ["apple", "banana", "cherry"]; ?>

<ul>
    <?php foreach ($items as $item): ?>
        <li><?= $item ?></li>
    <?php endforeach; ?>
</ul>
```

### Foreach with List() for Nested Arrays
```php
<?php
    $records = [
        [1, "John", "Developer"],
        [2, "Mary", "Designer"],
        [3, "Bob", "Manager"]
    ];
    
    foreach ($records as list($id, $name, $role)) {
        echo "ID: $id, Name: $name, Role: $role\n";
    }
    
    // Since PHP 7.1:
    foreach ($records as [$id, $name, $role]) {
        echo "ID: $id, Name: $name, Role: $role\n";
    }
?>
```

### Best Practices for Foreach
1. Always unset reference variables after foreach with references
2. Consider using array functions like `array_map` for transformations
3. For large arrays, be aware of memory usage
4. Be cautious when modifying the array while iterating through it

## 10. Functions in PHP

### Defining and Calling Functions
```php
<?php
    // Basic function definition
    function sayHello() {
        echo "Hello, World!";
    }
    
    // Calling the function
    sayHello(); // Outputs: Hello, World!
    
    // Function with parameters
    function greet($name) {
        echo "Hello, $name!";
    }
    
    greet("John"); // Outputs: Hello, John!
    
    // Function with return value
    function add($a, $b) {
        return $a + $b;
    }
    
    $sum = add(5, 3);
    echo $sum; // Outputs: 8
    
    // Function can return multiple values using an array
    function getPersonInfo() {
        return ["John", 30, "New York"];
    }
    
    list($name, $age, $city) = getPersonInfo();
    // Or with PHP 7.1+:
    [$name, $age, $city] = getPersonInfo();
?>
```

### Default Parameter Values
```php
<?php
    function greet($name = "Guest") {
        echo "Hello, $name!";
    }
    
    greet(); // Outputs: Hello, Guest!
    greet("John"); // Outputs: Hello, John!
    
    // Multiple parameters with defaults
    function createProfile($name, $age = 30, $city = "Unknown") {
        return "Name: $name, Age: $age, City: $city";
    }
    
    echo createProfile("John"); // Outputs: Name: John, Age: 30, City: Unknown
    echo createProfile("Mary", 25); // Outputs: Name: Mary, Age: 25, City: Unknown
    echo createProfile("Bob", 40, "New York"); // Outputs: Name: Bob, Age: 40, City: New York
?>
```

### Named Arguments (PHP 8+)
```php
<?php
    function createUser($name, $email, $role = "member", $active = true) {
        return "User $name ($email) created as $role. Status: " . 
               ($active ? "active" : "inactive");
    }
    
    // Traditional call (positional arguments)
    echo createUser("John", "john@example.com", "admin", true);
    
    // With named arguments (order doesn't matter)
    echo createUser(
        email: "jane@example.com",
        name: "Jane",
        active: false
    );
    
    // Mix positional and named arguments
    echo createUser("Bob", role: "editor", email: "bob@example.com");
?>
```

### Variable Scope in Functions
```php
<?php
    $globalVar = "I'm global";
    
    function testScope() {
        // Local variables
        $localVar = "I'm local";
        
        // Access global variable
        global $globalVar;
        echo $globalVar; // Works
        
        // Alternative way to access globals
        echo $GLOBALS['globalVar']; // Also works
    }
    
    testScope();
    echo $localVar; // Error - not accessible outside function
?>
```

### Variable Functions
```php
<?php
    function sayHello() {
        echo "Hello!";
    }
    
    function sayGoodbye() {
        echo "Goodbye!";
    }
    
    // Call a function by its name stored in a variable
    $functionName = "sayHello";
    $functionName(); // Outputs: Hello!
    
    // Useful for dynamic function calls
    $action = isset($_GET['action']) ? $_GET['action'] : 'default';
    $validFunctions = ['sayHello', 'sayGoodbye'];
    
    if (in_array($action, $validFunctions) && function_exists($action)) {
        $action();
    }
?>
```

### Anonymous Functions (Closures)
```php
<?php
    // Basic anonymous function
    $greet = function($name) {
        return "Hello, $name!";
    };
    
    echo $greet("John"); // Outputs: Hello, John!
    
    // Anonymous function as a callback
    $numbers = [1, 2, 3, 4, 5];
    
    $doubled = array_map(function($n) {
        return $n * 2;
    }, $numbers);
    
    print_r($doubled); // [2, 4, 6, 8, 10]
    
    // Closures (anonymous functions that can "capture" variables)
    $message = "Hello";
    
    $greeting = function($name) use ($message) {
        return "$message, $name!";
    };
    
    echo $greeting("John"); // Outputs: Hello, John!
    
    // Using by reference to modify the outer variable
    $counter = 0;
    
    $increment = function() use (&$counter) {
        $counter++;
    };
    
    $increment();
    $increment();
    echo $counter; // Outputs: 2
?>
```

### Arrow Functions (PHP 7.4+)
```php
<?php
    // Traditional anonymous function
    $double = function($x) {
        return $x * 2;
    };
    
    // Arrow function equivalent (shorter syntax)
    $double = fn($x) => $x * 2;
    
    // Arrow functions automatically capture variables from parent scope
    $factor = 3;
    $multiply = fn($x) => $x * $factor;
    
    echo $multiply(4); // Outputs: 12
    
    // Nested arrow functions
    $add_and_multiply = fn($x, $y) => fn($z) => ($x + $y) * $z;
    echo $add_and_multiply(2, 3)(4); // Outputs: 20 ((2+3)*4)
?>
```

### Type Declarations
```php
<?php
    // Parameter type declarations
    function add(int $a, int $b) {
        return $a + $b;
    }
    
    echo add(5, 3); // Outputs: 8
    // echo add("5", "3"); // Works in PHP 5-7 due to type juggling, may error in PHP 8+
    
    // Return type declarations
    function subtract(int $a, int $b): int {
        return $a - $b;
    }
    
    // Strict typing (opt-in)
    declare(strict_types=1); // Must be the first statement in the file
    
    function multiply(int $a, int $b): int {
        return $a * $b;
    }
    
    echo multiply(5, 3); // Outputs: 15
    // echo multiply("5", "3"); // Fatal error in strict mode
    
    // Nullable types (PHP 7.1+)
    function findUser(int $id): ?array {
        // Return user array or null if not found
        if ($id > 0) {
            return ["id" => $id, "name" => "User $id"];
        }
        return null;
    }
    
    // Union types (PHP 8+)
    function process(string|int $input): string|int {
        if (is_string($input)) {
            return "String: $input";
        } else {
            return $input * 2;
        }
    }
?>
```

### Recursive Functions
```php
<?php
    // Calculate factorial
    function factorial($n) {
        if ($n <= 1) {
            return 1;
        }
        return $n * factorial($n - 1);
    }
    
    echo factorial(5); // Outputs: 120 (5*4*3*2*1)
    
    // Generate a nested array of directories and files
    function scanDirectory($dir) {
        $result = [];
        $files = scandir($dir);
        
        foreach ($files as $file) {
            if ($file === '.' || $file === '..') {
                continue;
            }
            
            $path = $dir . '/' . $file;
            
            if (is_dir($path)) {
                $result[$file] = scanDirectory($path); // Recursive call
            } else {
                $result[] = $file;
            }
        }
        
        return $result;
    }
    
    // Be careful with recursive functions to avoid infinite loops!
?>
```

### Variadic Functions
```php
<?php
    // Using func_get_args() (older method)
    function sum1() {
        $total = 0;
        foreach (func_get_args() as $num) {
            $total += $num;
        }
        return $total;
    }
    
    echo sum1(1, 2, 3, 4); // Outputs: 10
    
    // Using ... operator (PHP 5.6+)
    function sum2(...$numbers) {
        return array_sum($numbers);
    }
    
    echo sum2(1, 2, 3, 4); // Outputs: 10
    
    // Mixed parameters with variadic
    function teamInfo($teamName, $coach, ...$players) {
        echo "Team: $teamName\n";
        echo "Coach: $coach\n";
        echo "Players: " . implode(", ", $players);
    }
    
    teamInfo("Eagles", "Johnson", "Smith", "Williams", "Davis", "Brown");
?>
```

### Generators
```php
<?php
    // Simple generator function
    function countTo($n) {
        for ($i = 1; $i <= $n; $i++) {
            yield $i;
        }
    }
    
    foreach (countTo(5) as $number) {
        echo "$number ";
    }
    // Outputs: 1 2 3 4 5
    
    // Generator with keys
    function getColors() {
        yield 'r' => 'red';
        yield 'g' => 'green';
        yield 'b' => 'blue';
    }
    
    foreach (getColors() as $key => $color) {
        echo "$key: $color\n";
    }
    
    // Memory-efficient file reading
    function readFileLines($file) {
        $handle = fopen($file, 'r');
        
        while (!feof($handle)) {
            yield fgets($handle);
        }
        
        fclose($handle);
    }
    
    foreach (readFileLines('large_file.txt') as $line) {
        // Process each line without loading entire file into memory
        echo $line;
    }
?>
```

### Best Practices for Functions
1. Keep functions short and focused on a single task
2. Use descriptive function names (verb phrases)
3. Limit the number of parameters
4. Use type declarations for better code quality
5. Document function purpose, parameters, and return values with comments
6. Return values instead of echoing directly when possible
7. Consider using named arguments (PHP 8+) for complex function calls

## 11. Form Handling

### HTML Form Basics
```html
<!DOCTYPE html>
<html>
<head>
    <title>PHP Form Example</title>
</head>
<body>
    <h1>Contact Form</h1>
    
    <form action="process.php" method="post">
        <div>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        
        <div>
            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="5" required></textarea>
        </div>
        
        <div>
            <input type="submit" value="Submit">
        </div>
    </form>
</body>
</html>
```

### Processing Form Data with PHP
```php
<?php
// process.php
    // Check if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Collect form data
        $name = $_POST["name"];
        $email = $_POST["email"];
        $message = $_POST["message"];
        
        // Basic validation
        $errors = [];
        
        if (empty($name)) {
            $errors[] = "Name is required";
        }
        
        if (empty($email)) {
            $errors[] = "Email is required";
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = "Invalid email format";
        }
        
        if (empty($message)) {
            $errors[] = "Message is required";
        }
        
        // If no errors, process the form
        if (empty($errors)) {
            // Process the data (e.g., save to database, send email)
            echo "Thank you, $name! Your message has been received.";
            // Redirect to prevent form resubmission
            // header("Location: thank-you.php");
            // exit;
        } else {
            // Display errors
            echo "<ul>";
            foreach ($errors as $error) {
                echo "<li>$error</li>";
            }
            echo "</ul>";
        }
    } else {
        // Not a POST request
        echo "Form was not submitted";
    }
?>
```

### Self-Processing Form
```php
<?php
    // Define variables and set to empty values
    $name = $email = $message = "";
    $errors = [];
    
    // Check if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Collect form data
        $name = $_POST["name"] ?? "";
        $email = $_POST["email"] ?? "";
        $message = $_POST["message"] ?? "";
        
        // Validate form data
        if (empty($name)) {
            $errors['name'] = "Name is required";
        }
        
        if (empty($email)) {
            $errors['email'] = "Email is required";
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = "Invalid email format";
        }
        
        if (empty($message)) {
            $errors['message'] = "Message is required";
        }
        
        // If no errors, process the form
        if (empty($errors)) {
            // Process the data
            $success = "Thank you, $name! Your message has been received.";
        }
    }
?>

<!DOCTYPE html>
<html>
<head>
    <title>PHP Self-Processing Form</title>
    <style>
        .error { color: red; }
        .success { color: green; }
    </style>
</head>
<body>
    <h1>Contact Form</h1>
    
    <?php if (isset($success)): ?>
        <p class="success"><?= $success ?></p>
    <?php else: ?>
        <form method="post" action="<?= htmlspecialchars($_SERVER["PHP_SELF"]) ?>">
            <div>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<?= htmlspecialchars($name) ?>">
                <?php if (isset($errors['name'])): ?>
                    <span class="error"><?= $errors['name'] ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<?= htmlspecialchars($email) ?>">
                <?php if (isset($errors['email'])): ?>
                    <span class="error"><?= $errors['email'] ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="5"><?= htmlspecialchars($message) ?></textarea>
                <?php if (isset($errors['message'])): ?>
                    <span class="error"><?= $errors['message'] ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <input type="submit" value="Submit">
            </div>
        </form>
    <?php endif; ?>
</body>
</html>
```

## 12. PHP $_GET, $_POST, $_REQUEST

### $_GET Superglobal
`$_GET` contains variables passed to the script via URL parameters.

```php
<?php
    // URL: page.php?id=42&category=books
    
    // Accessing GET parameters
    $id = $_GET["id"] ?? null; // 42
    $category = $_GET["category"] ?? null; // "books"
    
    // Check if parameter exists
    if (isset($_GET["id"])) {
        echo "ID is set to: " . htmlspecialchars($_GET["id"]);
    }
    
    // Generating links with GET parameters
    $page = 2;
    $limit = 10;
    $url = "products.php?page=$page&limit=$limit";
    echo "<a href='" . htmlspecialchars($url) . "'>Next Page</a>";
?>
```

**When to use $_GET:**
- For retrieving data (not modifying)
- For bookmarkable pages
- For search queries
- For pagination
- When data doesn't need to be secure

### $_POST Superglobal
`$_POST` contains variables passed to the script via the HTTP POST method.

```php
<?php
    // Form submitted with POST method
    
    // Accessing POST parameters
    $username = $_POST["username"] ?? null;
    $password = $_POST["password"] ?? null;
    
    // Check if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Process form data
        if (isset($_POST["username"]) && isset($_POST["password"])) {
            // Validate and authenticate
            echo "Login attempt for user: " . htmlspecialchars($username);
        }
    }
?>

<!-- HTML Form -->
<form method="post" action="login.php">
    <input type="text" name="username">
    <input type="password" name="password">
    <input type="submit" value="Login">
</form>
```

**When to use $_POST:**
- For sending data to be processed/stored
- For forms with sensitive information
- For larger data payloads
- When changing state (database updates, etc.)
- When file uploads are involved

### $_REQUEST Superglobal
`$_REQUEST` contains the contents of $_GET, $_POST, and $_COOKIE combined.

```php
<?php
    // Can access both GET and POST variables
    $id = $_REQUEST["id"] ?? null;
    $username = $_REQUEST["username"] ?? null;
    
    // Useful when a form can be submitted via either method
    $search = $_REQUEST["search"] ?? null;
    
    // Note: If same variable name exists in multiple sources,
    // the order of precedence is typically: COOKIE, POST, GET
    // (depends on php.ini settings)
?>
```

**Caution when using $_REQUEST:**
- Less explicit about data source
- Security implications (mixing query parameters with form data)
- Generally better to use $_GET or $_POST explicitly

### Security Considerations

**1. Never trust user input:**
```php
<?php
    // BAD: Directly using user input
    $username = $_POST["username"];
    $query = "SELECT * FROM users WHERE username = '$username'";
    
    // GOOD: Sanitize input
    $username = filter_input(INPUT_POST, "username", FILTER_SANITIZE_STRING);
    // Or with PDO prepared statements
    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->execute([$username]);
?>
```

**2. Cross-Site Scripting (XSS) Prevention:**
```php
<?php
    // BAD: Directly outputting user input
    echo $_GET["message"];
    
    // GOOD: Encode output
    echo htmlspecialchars($_GET["message"], ENT_QUOTES, 'UTF-8');
    
    // When including user data in HTML attributes
    echo '<input type="text" value="' . htmlspecialchars($userInput, ENT_QUOTES, 'UTF-8') . '">';
    
    // When including user data in JavaScript
    echo '<script>var userName = "' . htmlspecialchars($userName, ENT_QUOTES, 'UTF-8') . '";</script>';
?>
```

**3. CSRF (Cross-Site Request Forgery) Prevention:**
```php
<?php
    // Start the session to store the token
    session_start();
    
    // Generate CSRF token if it doesn't exist
    if (!isset($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    
    // Check the token on form submission
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
            die('CSRF token validation failed');
        }
        
        // Process the form if token is valid
        // ...
    }
?>

<!-- Include the token in forms -->
<form method="post" action="process.php">
    <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">
    <!-- Other form fields -->
    <input type="submit" value="Submit">
</form>
```

**4. SQL Injection Prevention:**
```php
<?php
    // Connect to database (using PDO)
    $pdo = new PDO('mysql:host=localhost;dbname=test', 'username', 'password');
    
    // BAD: Direct variable in query
    $id = $_GET['id'];
    $query = "SELECT * FROM users WHERE id = $id"; // Vulnerable to SQL injection
    
    // GOOD: Use prepared statements
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$_GET['id']]);
    $user = $stmt->fetch();
    
    // GOOD: Named parameters
    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username AND status = :status");
    $stmt->execute([
        ':username' => $_POST['username'],
        ':status' => 'active'
    ]);
?>
```

### Handling Form Arrays
HTML forms can submit array data using square brackets in field names:

```html
<form method="post" action="process.php">
    <input type="checkbox" name="interests[]" value="music"> Music
    <input type="checkbox" name="interests[]" value="sports"> Sports
    <input type="checkbox" name="interests[]" value="reading"> Reading
    
    <input type="text" name="contact[email]">
    <input type="text" name="contact[phone]">
    
    <button type="submit">Submit</button>
</form>
```

```php
<?php
    // Processing the arrays
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Simple array (checkboxes)
        $interests = $_POST['interests'] ?? [];
        echo "Selected interests: " . implode(", ", $interests);
        
        // Associative array
        $contact = $_POST['contact'] ?? [];
        echo "Email: " . ($contact['email'] ?? 'Not provided');
        echo "Phone: " . ($contact['phone'] ?? 'Not provided');
    }
?>
```

### Handling File Uploads with Forms

```html
<form method="post" action="upload.php" enctype="multipart/form-data">
    <input type="file" name="profile_image">
    <input type="submit" value="Upload Image">
</form>
```

```php
<?php
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Check if file was uploaded without errors
        if (isset($_FILES['profile_image']) && $_FILES['profile_image']['error'] === UPLOAD_ERR_OK) {
            // Get file details
            $fileName = $_FILES['profile_image']['name'];
            $fileType = $_FILES['profile_image']['type'];
            $fileTmpPath = $_FILES['profile_image']['tmp_name'];
            $fileSize = $_FILES['profile_image']['size'];
            
            // Validate file (example)
            $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
            $maxSize = 2 * 1024 * 1024; // 2 MB
            
            if (!in_array($fileType, $allowedTypes)) {
                die("Error: Invalid file type. Only JPG, PNG and GIF are allowed.");
            }
            
            if ($fileSize > $maxSize) {
                die("Error: File size exceeds the 2MB limit.");
            }
            
            // Generate unique filename
            $newFileName = uniqid() . '_' . $fileName;
            $uploadPath = 'uploads/' . $newFileName;
            
            // Move the file from temporary location
            if (move_uploaded_file($fileTmpPath, $uploadPath)) {
                echo "File uploaded successfully. Saved as: $newFileName";
            } else {
                echo "Error: File upload failed.";
            }
        } else {
            // Get error message
            $errorMsg = match($_FILES['profile_image']['error'] ?? UPLOAD_ERR_NO_FILE) {
                UPLOAD_ERR_INI_SIZE => "File exceeds the upload_max_filesize directive in php.ini",
                UPLOAD_ERR_FORM_SIZE => "File exceeds the MAX_FILE_SIZE directive in the HTML form",
                UPLOAD_ERR_PARTIAL => "File was only partially uploaded",
                UPLOAD_ERR_NO_FILE => "No file was uploaded",
                UPLOAD_ERR_NO_TMP_DIR => "Missing a temporary folder",
                UPLOAD_ERR_CANT_WRITE => "Failed to write file to disk",
                UPLOAD_ERR_EXTENSION => "A PHP extension stopped the file upload",
                default => "Unknown upload error"
            };
            
            echo "Error: " . $errorMsg;
        }
    }
?>
```

## 13. PHP date() Function

The `date()` function is used to format timestamps into human-readable dates:

### Basic Date Formatting
```php
<?php
    // Current date with default timezone
    echo date("Y-m-d"); // e.g., 2023-04-16
    echo date("d/m/Y"); // e.g., 16/04/2023
    echo date("l, F j, Y"); // e.g., Sunday, April 16, 2023
    
    // Current time
    echo date("H:i:s"); // e.g., 14:30:45 (24-hour format)
    echo date("h:i:s A"); // e.g., 02:30:45 PM (12-hour format)
    
    // Date and time together
    echo date("Y-m-d H:i:s"); // e.g., 2023-04-16 14:30:45
?>
```

### Common Date Format Characters
```php
<?php
    // Day
    echo date("d"); // Day of month (01-31)
    echo date("j"); // Day of month without leading zeros (1-31)
    echo date("D"); // Day of week, short name (Mon-Sun)
    echo date("l"); // Day of week, full name (Monday-Sunday)
    echo date("z"); // Day of year (0-365)
    
    // Month
    echo date("m"); // Month (01-12)
    echo date("n"); // Month without leading zeros (1-12)
    echo date("M"); // Month, short name (Jan-Dec)
    echo date("F"); // Month, full name (January-December)
    
    // Year
    echo date("Y"); // Year, 4 digits (e.g., 2023)
    echo date("y"); // Year, 2 digits (e.g., 23)
    
    // Time
    echo date("H"); // Hour, 24-hour format (00-23)
    echo date("h"); // Hour, 12-hour format (01-12)
    echo date("i"); // Minutes (00-59)
    echo date("s"); // Seconds (00-59)
    echo date("A"); // AM or PM
    echo date("a"); // am or pm
    
    // Special
    echo date("U"); // Unix timestamp (seconds since January 1 1970)
    echo date("r"); // RFC 2822 formatted date (e.g., Wed, 16 Apr 2023 14:30:45 +0000)
    echo date("c"); // ISO 8601 date (e.g., 2023-04-16T14:30:45+00:00)
?>
```

### Working with Timestamps
```php
<?php
    // Current timestamp
    $now = time(); // Seconds since January 1, 1970
    
    // Format a specific timestamp
    echo date("Y-m-d", $now);
    
    // Creating timestamps
    $timestamp1 = mktime(14, 30, 0, 4, 16, 2023); // Hour, minute, second, month, day, year
    echo date("Y-m-d H:i:s", $timestamp1); // 2023-04-16 14:30:00
    
    // Using strtotime() to create timestamps from text
    $timestamp2 = strtotime("2023-04-16"); // Specific date
    $timestamp3 = strtotime("+1 week"); // One week from now
    $timestamp4 = strtotime("next Monday"); // Next Monday
    $timestamp5 = strtotime("last day of February 2023"); // Last day of February 2023
    
    echo date("Y-m-d", $timestamp3); // Date one week from now
    
    // Date calculations
    $tomorrow = strtotime("+1 day");
    $lastMonth = strtotime("-1 month");
    $nextYear = strtotime("+1 year");
    
    echo "Tomorrow: " . date("Y-m-d", $tomorrow) . "\n";
    echo "Last Month: " . date("Y-m-d", $lastMonth) . "\n";
    echo "Next Year: " . date("Y-m-d", $nextYear) . "\n";
?>
```

### DateTime Class (Object-Oriented Alternative)
```php
<?php
    // Create DateTime object (current time)
    $date = new DateTime();
    echo $date->format('Y-m-d H:i:s') . "\n";
    
    // Create DateTime for a specific date
    $date = new DateTime('2023-04-16');
    echo $date->format('Y-m-d') . "\n";
    
    // Add/subtract intervals
    $date->add(new DateInterval('P1D')); // Add 1 day
    echo $date->format('Y-m-d') . "\n"; // 2023-04-17
    
    $date->sub(new DateInterval('P2M')); // Subtract 2 months
    echo $date->format('Y-m-d') . "\n"; // 2023-02-17
    
    // Creating date intervals
    $interval = new DateInterval('P1Y2M3DT4H5M6S'); // 1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds
    $date->add($interval);
    
    // Calculate difference between dates
    $date1 = new DateTime('2023-01-01');
    $date2 = new DateTime('2023-12-31');
    $diff = $date1->diff($date2);
    
    echo "Difference: " . $diff->format('%y years, %m months, %d days') . "\n";
    echo "Total days: " . $diff->days . "\n";
    
    // Comparing dates
    $date1 = new DateTime('2023-01-01');
    $date2 = new DateTime('2023-12-31');
    
    if ($date1 < $date2) {
        echo "date1 is earlier than date2";
    }
    
    // Format datetime using IntlDateFormatter (requires intl extension)
    if (class_exists('IntlDateFormatter')) {
        $formatter = new IntlDateFormatter(
            'en_US',
            IntlDateFormatter::FULL,
            IntlDateFormatter::SHORT
        );
        echo $formatter->format(new DateTime());
    }
?>
```

### Timezone Handling
```php
<?php
    // Get current default timezone
    echo date_default_timezone_get() . "\n";
    
    // Set timezone
    date_default_timezone_set('America/New_York');
    echo date('Y-m-d H:i:s') . " (New York)\n";
    
    date_default_timezone_set('Europe/London');
    echo date('Y-m-d H:i:s') . " (London)\n";
    
    // Using DateTime with timezone
    $date = new DateTime('now', new DateTimeZone('Asia/Tokyo'));
    echo $date->format('Y-m-d H:i:s') . " (Tokyo)\n";
    
    // Change timezone on existing DateTime object
    $date->setTimezone(new DateTimeZone('Australia/Sydney'));
    echo $date->format('Y-m-d H:i:s') . " (Sydney)\n";
    
    // List all timezones
    $timezones = DateTimeZone::listIdentifiers();
    echo "Number of timezones: " . count($timezones) . "\n";
    // foreach ($timezones as $tz) {
    //    echo $tz . "\n";
    // }
?>
```

### Date Validation
```php
<?php
    // Using checkdate() function to validate dates
    // checkdate(month, day, year): Checks for valid Gregorian date
    var_dump(checkdate(2, 29, 2020)); // true (leap year)
    var_dump(checkdate(2, 29, 2023)); // false (not leap year)
    var_dump(checkdate(4, 31, 2023)); // false (April has 30 days)
    
    // Validating dates from user input
    function isValidDate($dateString) {
        $date = DateTime::createFromFormat('Y-m-d', $dateString);
        return $date && $date->format('Y-m-d') === $dateString;
    }
    
    var_dump(isValidDate('2023-04-16')); // true
    var_dump(isValidDate('2023-02-31')); // false
    
    // Validating dates with custom format
    function isValidDateFormat($dateString, $format) {
        $date = DateTime::createFromFormat($format, $dateString);
        return $date && $date->format($format) === $dateString;
    }
    
    var_dump(isValidDateFormat('16/04/2023', 'd/m/Y')); // true
    var_dump(isValidDateFormat('31/02/2023', 'd/m/Y')); // false
?>
```

## 14. PHP include File

PHP provides several ways to include code from one file into another:

### include
```php
<?php
    // Basic include
    include 'header.php';
    
    echo "Main content goes here";
    
    include 'footer.php';
    
    // Include with variables
    $title = "My Page";
    include 'header.php'; // header.php can use $title variable
    
    // If the file is not found, include produces a warning but continues execution
    include 'non_existent_file.php'; // Warning, but script continues
?>
```

### require
```php
<?php
    // Similar to include, but causes a fatal error if file not found
    require 'config.php'; // Essential file for the application
    
    echo "This won't execute if config.php is missing";
    
    // Often used for critical files
    require 'database.php';
?>
```

### include_once and require_once
```php
<?php
    // Include a file only once, even if called multiple times
    include_once 'functions.php';
    include_once 'functions.php'; // Second inclusion is ignored
    
    // Same with require_once
    require_once 'config.php';
    require_once 'config.php'; // Second requirement is ignored
    
    // Useful for class definitions and function libraries
    require_once 'User.class.php';
?>
```

### Practical Usage

**1. Separating Header and Footer:**
```php
<?php
    // index.php
    $pageTitle = "Home Page";
    include 'includes/header.php';
?>

<main>
    <h1>Welcome to our website</h1>
    <!-- Page content -->
</main>

<?php include 'includes/footer.php'; ?>
```

```php
<?php
    // includes/header.php
?>
<!DOCTYPE html>
<html>
<head>
    <title><?= htmlspecialchars($pageTitle ?? 'My Website') ?></title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <nav>
            <!-- Navigation menu -->
        </nav>
    </header>
```

```php
<?php
    // includes/footer.php
?>
    <footer>
        <p>&copy; <?= date('Y') ?> My Website</p>
    </footer>
</body>
</html>
```

**2. Configuration Files:**
```php
<?php
    // config.php
    return [
        'database' => [
            'host' => 'localhost',
            'dbname' => 'myapp',
            'username' => 'dbuser',
            'password' => 'dbpass'
        ],
        'app' => [
            'name' => 'My Application',
            'debug' => true
        ]
    ];
?>
```

```php
<?php
    // Using the config
    $config = require 'config.php';
    
    $dbHost = $config['database']['host'];
    $appName = $config['app']['name'];
    
    echo "Connecting to database at $dbHost for $appName";
?>
```

**3. Function Libraries:**
```php
<?php
    // functions.php
    function formatCurrency($amount, $currency = 'USD') {
        return number_format($amount, 2) . ' ' . $currency;
    }
    
    function sanitizeInput($input) {
        return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
    }
    
    function generateRandomString($length = 10) {
        return substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, $length);
    }
?>
```

```php
<?php
    // Using the functions
    require_once 'functions.php';
    
    $price = formatCurrency(15.75, 'EUR');
    $userInput = sanitizeInput($_POST['comment'] ?? '');
    $randomToken = generateRandomString(20);
?>
```

**4. Class Autoloading (Modern Approach):**
```php
<?php
    // autoload.php
    spl_autoload_register(function($className) {
        // Convert namespace to file path
        $path = str_replace('\\', '/', $className);
        $file = __DIR__ . '/classes/' . $path . '.php';
        
        if (file_exists($file)) {
            require_once $file;
            return true;
        }
        return false;
    });
?>
```

```php
<?php
    // index.php
    require_once 'autoload.php';
    
    // Classes are loaded automatically as needed
    $user = new App\Models\User();
    $product = new App\Models\Product();
?>
```

### Security Considerations

**1. Path Traversal Attacks:**
```php
<?php
    // INSECURE - Allows including arbitrary files
    $page = $_GET['page'] ?? 'home';
    include $page . '.php'; // Vulnerable to path traversal
    
    // SECURE - Validate against whitelist
    $allowedPages = ['home', 'about', 'contact'];
    $page = $_GET['page'] ?? 'home';
    
    if (in_array($page, $allowedPages)) {
        include 'pages/' . $page . '.php';
    } else {
        include 'pages/404.php';
    }
    
    // ALSO SECURE - Using switch/case
    $page = $_GET['page'] ?? 'home';
    
    switch ($page) {
        case 'home':
            include 'pages/home.php';
            break;
        case 'about':
            include 'pages/about.php';
            break;
        default:
            include 'pages/404.php';
    }
?>
```

**2. Avoid Including from Remote Sources:**
```php
<?php
    // NEVER do this in production code:
    include 'http://example.com/remote-script.php';
    
    // Remote includes can be disabled in php.ini:
    // allow_url_include = Off
?>
```

**3. Use Absolute Paths:**
```php
<?php
    // More reliable than relative paths
    include __DIR__ . '/includes/header.php';
    
    // Common constants
    // __DIR__: Directory of the current file
    // __FILE__: Full path to the current file
    // __NAMESPACE__: Current namespace
?>
```

## 15. File Handling

PHP provides various functions for working with files:

### Reading Files

```php
<?php
    // Reading entire file into a string
    $content = file_get_contents('data.txt');
    echo $content;
    
    // Reading file line by line
    $lines = file('data.txt'); // Returns array of lines
    foreach ($lines as $lineNumber => $line) {
        echo "Line #" . ($lineNumber + 1) . ": " . htmlspecialchars($line);
    }
    
    // Reading with file pointer (for large files)
    $handle = fopen('large_file.txt', 'r');
    if ($handle) {
        while (($line = fgets($handle)) !== false) {
            echo htmlspecialchars($line);
        }
        fclose($handle);
    } else {
        echo "Error opening file";
    }
    
    // Reading specific number of bytes
    $handle = fopen('data.bin', 'rb');
    $data = fread($handle, 1024); // Read 1024 bytes
    fclose($handle);
    
    // Reading CSV files
    $handle = fopen('data.csv', 'r');
    if ($handle) {
        while (($data = fgetcsv($handle, 1000, ',')) !== false) {
            // $data is an array of values in each row
            print_r($data);
        }
        fclose($handle);
    }
?>
```

### Writing to Files

```php
<?php
    // Writing string to file (overwrites existing file)
    file_put_contents('output.txt', 'Hello, world!');
    
    // Appending to file
    file_put_contents('log.txt', "Log entry: " . date('Y-m-d H:i:s') . "\n", FILE_APPEND);
    
    // Writing with file pointer
    $handle = fopen('output.txt', 'w'); // 'w' mode overwrites
    if ($handle) {
        fwrite($handle, "Line 1\n");
        fwrite($handle, "Line 2\n");
        fclose($handle);
    }
    
    // Appending with file pointer
    $handle = fopen('log.txt', 'a'); // 'a' mode appends
    if ($handle) {
        fwrite($handle, "New log entry: " . date('Y-m-d H:i:s') . "\n");
        fclose($handle);
    }
    
    // Writing CSV files
    $handle = fopen('export.csv', 'w');
    if ($handle) {
        // Write header row
        fputcsv($handle, ['Name', 'Email', 'Age']);
        
        // Write data rows
        fputcsv($handle, ['John Doe', 'john@example.com', 30]);
        fputcsv($handle, ['Jane Smith', 'jane@example.com', 25]);
        
        fclose($handle);
    }
?>
```

### File Information

```php
<?php
    $file = 'example.txt';
    
    // Check if file exists
    if (file_exists($file)) {
        echo "$file exists<br>";
    }
    
    // Check if it's a file or directory
    if (is_file($file)) {
        echo "$file is a file<br>";
    }
    if (is_dir('images')) {
        echo "images is a directory<br>";
    }
    
    // File size
    echo "Size: " . filesize($file) . " bytes<br>";
    
    // File permissions
    echo "Permissions: " . substr(sprintf('%o', fileperms($file)), -4) . "<br>";
    
    // File times
    echo "Last accessed: " . date('Y-m-d H:i:s', fileatime($file)) . "<br>";
    echo "Last modified: " . date('Y-m-d H:i:s', filemtime($file)) . "<br>";
    
    // File type
    echo "MIME type: " . mime_content_type($file) . "<br>";
    
    // Check if file is readable/writable
    if (is_readable($file)) {
        echo "$file is readable<br>";
    }
    if (is_writable($file)) {
        echo "$file is writable<br>";
    }
    
    // File ownership
    echo "Owner: " . fileowner($file) . "<br>";
    echo "Group: " . filegroup($file) . "<br>";
?>
```

### File System Operations

```php
<?php
    // Rename file
    rename('old_name.txt', 'new_name.txt');
    
    // Copy file
    copy('source.txt', 'destination.txt');
    
    // Delete file
    unlink('file_to_delete.txt');
    
    // Create directory
    mkdir('new_directory', 0755); // 0755 is the permission
    
    // Remove directory
    rmdir('empty_directory'); // Only works if directory is empty
    
    // Get directory contents
    $files = scandir('images');
    print_r($files);
    
    // Recursively delete directory
    function deleteDirectory($dir) {
        if (!file_exists($dir)) {
            return true;
        }
        
        if (!is_dir($dir)) {
            return unlink($dir);
        }
        
        foreach (scandir($dir) as $item) {
            if ($item == '.' || $item == '..') {
                continue;
            }
            
            if (!deleteDirectory($dir . DIRECTORY_SEPARATOR . $item)) {
                return false;
            }
        }
        
        return rmdir($dir);
    }
    
    // Create temporary file
    $tempfile = tempnam(sys_get_temp_dir(), 'prefix_');
    // Use the file...
    unlink($tempfile); // Delete when done
?>
```

### File Locking

```php
<?php
    // Exclusive lock for writing
    $handle = fopen('data.txt', 'w');
    if (flock($handle, LOCK_EX)) {
        fwrite($handle, 'New content');
        flock($handle, LOCK_UN); // Release the lock
    } else {
        echo "Couldn't get a lock";
    }
    fclose($handle);
    
    // Shared lock for reading
    $handle = fopen('data.txt', 'r');
    if (flock($handle, LOCK_SH)) {
        $content = fread($handle, filesize('data.txt'));
        flock($handle, LOCK_UN); // Release the lock
    }
    fclose($handle);
    
    // Non-blocking lock
    $handle = fopen('data.txt', 'w');
    if (flock($handle, LOCK_EX | LOCK_NB)) {
        // Got the lock, proceed
        fwrite($handle, 'New content');
        flock($handle, LOCK_UN);
    } else {
        echo "File is being used by another process";
    }
    fclose($handle);
?>
```

### Working with Remote Files

```php
<?php
    // Read remote file
    $content = file_get_contents('https://example.com/');
    echo $content;
    
    // More control with context options
    $opts = [
        'http' => [
            'method' => 'GET',
            'header' => [
                'User-Agent: PHP'
            ]
        ]
    ];
    $context = stream_context_create($opts);
    $content = file_get_contents('https://example.com/', false, $context);
    
    // POST request to remote URL
    $postData = http_build_query([
        'name' => 'John Doe',
        'email' => 'john@example.com'
    ]);
    
    $opts = [
        'http' => [
            'method' => 'POST',
            'header' => 'Content-Type: application/x-www-form-urlencoded',
            'content' => $postData
        ]
    ];
    
    $context = stream_context_create($opts);
    $result = file_get_contents('https://example.com/api', false, $context);
?>
```

### Security Best Practices for File Handling

1. **Validate file paths:**
```php
<?php
    // Sanitize and validate file paths
    $filename = basename($_GET['file']); // Strip directory components
    $safeDir = '/var/www/files/';
    $filepath = $safeDir . $filename;
    
    // Ensure the path is within the intended directory
    $realpath = realpath($filepath);
    if ($realpath === false || strpos($realpath, $safeDir) !== 0) {
        die("Invalid file path");
    }
?>
```

2. **Check file types for uploads:**
```php
<?php
    // Using finfo to verify MIME type
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $mimeType = $finfo->file($_FILES['upload']['tmp_name']);
    
    $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
    if (!in_array($mimeType, $allowedTypes)) {
        die("File type not allowed. Only JPEG, PNG, and GIF are accepted.");
    }
?>
```

3. **Use proper file permissions:**
```php
<?php
    // Set secure permissions when creating files
    file_put_contents('data.txt', 'Sensitive data');
    chmod('data.txt', 0600); // Owner read/write only
    
    // For directories
    mkdir('private_directory', 0700); // Owner read/write/execute only
?>
```

## 16. File Uploading

### HTML Form for File Upload
```html
<!DOCTYPE html>
<html>
<head>
    <title>File Upload Form</title>
</head>
<body>
    <h1>Upload File</h1>
    
    <!-- Must have enctype="multipart/form-data" -->
    <form action="upload.php" method="post" enctype="multipart/form-data">
        <div>
            <label for="file">Select file:</label>
            <input type="file" name="file" id="file" required>
        </div>
        
        <!-- For multiple files -->
        <div>
            <label for="gallery">Select multiple images:</label>
            <input type="file" name="gallery[]" id="gallery" multiple accept="image/*">
        </div>
        
        <!-- For limiting file size (in bytes, client-side only) -->
        <input type="hidden" name="MAX_FILE_SIZE" value="2097152"> <!-- 2MB -->
        
        <div>
            <button type="submit">Upload</button>
        </div>
    </form>
</body>
</html>
```

### Processing Single File Upload
```php
<?php
// upload.php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    // Get file details
    $file = $_FILES['file'];
    
    // Display file information
    echo "File name: " . htmlspecialchars($file['name']) . "<br>";
    echo "File type: " . htmlspecialchars($file['type']) . "<br>";
    echo "File size: " . htmlspecialchars($file['size']) . " bytes<br>";
    echo "Temporary location: " . htmlspecialchars($file['tmp_name']) . "<br>";
    
    // Check for upload errors
    if ($file['error'] !== UPLOAD_ERR_OK) {
        $errorMessages = [
            UPLOAD_ERR_INI_SIZE => "The uploaded file exceeds the upload_max_filesize directive in php.ini",
            UPLOAD_ERR_FORM_SIZE => "The uploaded file exceeds the MAX_FILE_SIZE directive in the HTML form",
            UPLOAD_ERR_PARTIAL => "The uploaded file was only partially uploaded",
            UPLOAD_ERR_NO_FILE => "No file was uploaded",
            UPLOAD_ERR_NO_TMP_DIR => "Missing a temporary folder",
            UPLOAD_ERR_CANT_WRITE => "Failed to write file to disk",
            UPLOAD_ERR_EXTENSION => "A PHP extension stopped the file upload"
        ];
        
        $errorMessage = $errorMessages[$file['error']] ?? "Unknown upload error";
        die("Upload error: " . $errorMessage);
    }
    
    // Validate file size (server-side)
    $maxSize = 2 * 1024 * 1024; // 2MB
    if ($file['size'] > $maxSize) {
        die("Error: File size exceeds the 2MB limit.");
    }
    
    // Validate file type
    $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $fileType = $finfo->file($file['tmp_name']);
    
    if (!in_array($fileType, $allowedTypes)) {
        die("Error: Invalid file type. Only JPG, PNG, and GIF are allowed.");
    }
    
    // Generate a unique filename to prevent overwriting
    $filename = uniqid() . '_' . basename($file['name']);
    
    // Specify the destination directory
    $uploadDir = 'uploads/';
    
    // Create directory if it doesn't exist
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }
    
    $destination = $uploadDir . $filename;
    
    // Move the uploaded file to the destination
    if (move_uploaded_file($file['tmp_name'], $destination)) {
        echo "File uploaded successfully. Saved as: " . htmlspecialchars($filename);
    } else {
        echo "Error: There was a problem moving the uploaded file.";
    }
} else {
    echo "No file uploaded or invalid request.";
}
?>
```

### Processing Multiple File Uploads
```php
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['gallery'])) {
    $gallery = $_FILES['gallery'];
    $uploadCount = count($gallery['name']);
    $uploadDir = 'uploads/gallery/';
    
    // Create directory if it doesn't exist
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }
    
    // Allowed file types
    $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
    $maxSize = 2 * 1024 * 1024; // 2MB
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    
    $successCount = 0;
    $errors = [];
    
    for ($i = 0; $i < $uploadCount; $i++) {
        // Skip if there was an upload error
        if ($gallery['error'][$i] !== UPLOAD_ERR_OK) {
            $errors[] = "Error uploading file {$gallery['name'][$i]}: " . 
                         "Error code {$gallery['error'][$i]}";
            continue;
        }
        
        // Check file size
        if ($gallery['size'][$i] > $maxSize) {
            $errors[] = "File {$gallery['name'][$i]} exceeds the 2MB size limit.";
            continue;
        }
        
        // Check file type
        $fileType = $finfo->file($gallery['tmp_name'][$i]);
        if (!in_array($fileType, $allowedTypes)) {
            $errors[] = "File {$gallery['name'][$i]} has an invalid type. Only JPG, PNG, and GIF are allowed.";
            continue;
        }
        
        // Generate unique filename
        $filename = uniqid() . '_' . basename($gallery['name'][$i]);
        $destination = $uploadDir . $filename;
        
        // Move the file
        if (move_uploaded_file($gallery['tmp_name'][$i], $destination)) {
            $successCount++;
        } else {
            $errors[] = "Failed to save file {$gallery['name'][$i]}.";
        }
    }
    
    echo "Successfully uploaded $successCount out of $uploadCount files.<br>";
    
    if (!empty($errors)) {
        echo "<h3>Errors:</h3><ul>";
        foreach ($errors as $error) {
            echo "<li>" . htmlspecialchars($error) . "</li>";
        }
        echo "</ul>";
    }
} else {
    echo "No files uploaded or invalid request.";
}
?>
```

### Image Validation and Processing
```php
<?php
function validateAndUploadImage($file, $uploadDir) {
    // Check if file is actually an image
    $imageInfo = getimagesize($file['tmp_name']);
    if ($imageInfo === false) {
        return [false, "The file is not a valid image."];
    }
    
    // Additional validation for image dimensions
    list($width, $height) = $imageInfo;
    if ($width < 200 || $height < 200) {
        return [false, "Image dimensions must be at least 200x200 pixels."];
    }
    
    if ($width > 4000 || $height > 4000) {
        return [false, "Image dimensions must not exceed 4000x4000 pixels."];
    }
    
    // Generate a unique filename
    $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
    $newFilename = uniqid() . '.' . $extension;
    $destination = $uploadDir . $newFilename;
    
    // Move the file
    if (move_uploaded_file($file['tmp_name'], $destination)) {
        return [true, $newFilename];
    } else {
        return [false, "Failed to save the image."];
    }
}

// Resize an image using GD library
function resizeImage($sourceFile, $destFile, $maxWidth, $maxHeight) {
    // Get original image dimensions and type
    list($origWidth, $origHeight, $type) = getimagesize($sourceFile);
    
    // Calculate new dimensions while maintaining aspect ratio
    if ($origWidth > $origHeight) {
        $newWidth = $maxWidth;
        $newHeight = intval($origHeight * $maxWidth / $origWidth);
    } else {
        $newHeight = $maxHeight;
        $newWidth = intval($origWidth * $maxHeight / $origHeight);
    }
    
    // Create a new image resource
    $newImage = imagecreatetruecolor($newWidth, $newHeight);
    
    // Load the original image based on type
    switch ($type) {
        case IMAGETYPE_JPEG:
            $sourceImage = imagecreatefromjpeg($sourceFile);
            break;
        case IMAGETYPE_PNG:
            $sourceImage = imagecreatefrompng($sourceFile);
            // Preserve transparency
            imagealphablending($newImage, false);
            imagesavealpha($newImage, true);
            $transparent = imagecolorallocatealpha($newImage, 255, 255, 255, 127);
            imagefilledrectangle($newImage, 0, 0, $newWidth, $newHeight, $transparent);
            break;
        case IMAGETYPE_GIF:
            $sourceImage = imagecreatefromgif($sourceFile);
            break;
        default:
            return false;
    }
    
    // Resize the image
    imagecopyresampled($newImage, $sourceImage, 0, 0, 0, 0, $newWidth, $newHeight, $origWidth, $origHeight);
    
    // Save the new image
    switch ($type) {
        case IMAGETYPE_JPEG:
            imagejpeg($newImage, $destFile, 90); // 90 is the quality (0-100)
            break;
        case IMAGETYPE_PNG:
            imagepng($newImage, $destFile, 9); // 9 is the compression level (0-9)
            break;
        case IMAGETYPE_GIF:
            imagegif($newImage, $destFile);
            break;
    }
    
    // Free up memory
    imagedestroy($sourceImage);
    imagedestroy($newImage);
    
    return true;
}

// Example usage
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['image'])) {
    $uploadDir = 'uploads/images/';
    
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }
    
    list($success, $result) = validateAndUploadImage($_FILES['image'], $uploadDir);
    
    if ($success) {
        $originalFile = $uploadDir . $result;
        $thumbFile = $uploadDir . 'thumb_' . $result;
        
        // Create a thumbnail
        if (resizeImage($originalFile, $thumbFile, 200, 200)) {
            echo "Image uploaded and thumbnail created successfully.";
        } else {
            echo "Image uploaded but failed to create thumbnail.";
        }
    } else {
        echo "Error: " . $result;
    }
}
?>
```

### Handling File Upload Progress
For large file uploads, you can show progress using:

1. **Server-side session tracking** (requires specific PHP configuration):
```php
<?php
// In your php.ini:
// session.upload_progress.enabled = On
// session.upload_progress.prefix = "upload_progress_"
// session.upload_progress.name = "PHP_SESSION_UPLOAD_PROGRESS"
// session.upload_progress.freq = "1%"
// session.upload_progress.min_freq = "1"

// Form:
// <form action="upload.php" method="post" enctype="multipart/form-data">
//     <input type="hidden" name="PHP_SESSION_UPLOAD_PROGRESS" value="123">
//     <input type="file" name="file">
//     <button type="submit">Upload</button>
// </form>

// Progress script (progress.php):
session_start();
$key = ini_get("session.upload_progress.prefix") . "123";

if (!empty($_SESSION[$key])) {
    $current = $_SESSION[$key]["bytes_processed"];
    $total = $_SESSION[$key]["content_length"];
    $progress = $current / $total * 100;
    
    echo json_encode([
        'progress' => round($progress, 1),
        'current' => $current,
        'total' => $total
    ]);
} else {
    echo json_encode(['progress' => 0]);
}
?>

<script>
// JavaScript to poll the progress
let progressCheck = setInterval(function() {
    fetch('progress.php')
        .then(response => response.json())
        .then(data => {
            document.getElementById('progress').style.width = data.progress + '%';
            document.getElementById('progress-text').textContent = data.progress + '%';
            
            if (data.progress >= 100) {
                clearInterval(progressCheck);
            }
        });
}, 500);
</script>
```

2. **Client-side using XMLHttpRequest:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>File Upload with Progress</title>
    <style>
        .progress-bar {
            width: 300px;
            height: 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
            margin-top: 10px;
        }
        .progress {
            height: 100%;
            background-color: #4CAF50;
            width: 0%;
            transition: width 0.3s;
        }
    </style>
</head>
<body>
    <h1>Upload with Progress</h1>
    
    <div>
        <input type="file" id="file">
        <button onclick="uploadFile()">Upload</button>
    </div>
    
    <div class="progress-bar">
        <div id="progress" class="progress"></div>
    </div>
    <div id="status"></div>
    
    <script>
        function uploadFile() {
            const file = document.getElementById('file').files[0];
            if (!file) {
                alert('Please select a file first');
                return;
            }
            
            const formData = new FormData();
            formData.append('file', file);
            
            const xhr = new XMLHttpRequest();
            
            // Progress handler
            xhr.upload.addEventListener('progress', function(e) {
                if (e.lengthComputable) {
                    const percent = Math.round((e.loaded / e.total) * 100);
                    document.getElementById('progress').style.width = percent + '%';
                    document.getElementById('status').textContent = 
                        Math.round(e.loaded / 1024) + 'KB of ' + 
                        Math.round(e.total / 1024) + 'KB (' + percent + '%)';
                }
            });
            
            // Load handler
            xhr.addEventListener('load', function() {
                if (xhr.status === 200) {
                    document.getElementById('status').textContent = 'Upload completed';
                } else {
                    document.getElementById('status').textContent = 'Upload failed: ' + xhr.status;
                }
            });
            
            // Error handler
            xhr.addEventListener('error', function() {
                document.getElementById('status').textContent = 'Upload failed';
            });
            
            // Open and send the request
            xhr.open('POST', 'upload.php', true);
            xhr.send(formData);
        }
    </script>
</body>
</html>
```

### Security Best Practices for File Uploads

1. **Never trust user input:**
   - Always validate file types, sizes, and content
   - Check both the file extension AND the MIME type
   - Use `getimagesize()` for image validation

2. **Store uploaded files outside the web root:**
   ```php
   // Insecure: Files stored in publicly accessible directory
   $uploadDir = 'uploads/';
   
   // Secure: Store outside web root
   $uploadDir = dirname(__DIR__) . '/private_uploads/';
   
   // To serve these files, create a script to proxy the content:
   // serve.php
   $file = dirname(__DIR__) . '/private_uploads/' . basename($_GET['file']);
   if (file_exists($file) && pathinfo($file, PATHINFO_EXTENSION) === 'jpg') {
       header('Content-Type: image/jpeg');
       readfile($file);
   } else {
       header('HTTP/1.0 404 Not Found');
   }
   ```

3. **Use a whitelist approach for file extensions and MIME types:**
   ```php
   // Whitelist of allowed extensions
   $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'pdf'];
   $extension = strtolower(pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION));
   
   if (!in_array($extension, $allowedExtensions)) {
       die('Invalid file extension');
   }
   
   // Check MIME type with finfo
   $finfo = new finfo(FILEINFO_MIME_TYPE);
   $mimeType = $finfo->file($_FILES['file']['tmp_name']);
   
   $allowedMimeTypes = [
       'image/jpeg',
       'image/png',
       'image/gif',
       'application/pdf'
   ];
   
   if (!in_array($mimeType, $allowedMimeTypes)) {
       die('Invalid file type');
   }
   ```

4. **Limit file size:**
   ```php
   // Set maximum file size (in bytes)
   $maxFileSize = 2 * 1024 * 1024; // 2MB
   
   if ($_FILES['file']['size'] > $maxFileSize) {
       die('File size exceeds the limit');
   }
   ```

5. **Generate a random filename:**
   ```php
   // Don't use the original filename directly
   $newFilename = md5(uniqid() . $_FILES['file']['name']) . '.' . $extension;
   // or
   $newFilename = bin2hex(random_bytes(16)) . '.' . $extension;
   ```

6. **Scan for malicious content:**
   - For PHP files, check for PHP tags:
   ```php
   $content = file_get_contents($_FILES['file']['tmp_name']);
   if (preg_match('/<\?php/i', $content)) {
       die('PHP code detected in the file');
   }
   ```
   
   - For enterprise applications, consider integrating with antivirus services

7. **Set proper file permissions:**
   ```php
   // Set restrictive permissions after uploading
   chmod($uploadDir . $newFilename, 0644); // rw-r--r--
   ```

8. **Implement file upload limits in PHP configuration:**
   ```ini
   ; in php.ini
   upload_max_filesize = 10M
   post_max_size = 10M
   max_file_uploads = 20
   ```

9. **Use a Content-Disposition header when serving user-uploaded files:**
   ```php
   // When serving a file from your application
   $file = '/path/to/user/uploads/' . basename($_GET['file']);
   
   header('Content-Disposition: attachment; filename="' . basename($file) . '"');
   header('Content-Type: application/octet-stream');
   header('Content-Length: ' . filesize($file));
   header('Content-Transfer-Encoding: binary');
   header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
   header('Expires: 0');
   header('Pragma: public');
   
   readfile($file);
   exit;
   ```

## 17. PHP Sessions

PHP sessions provide a way to store information across multiple pages for a specific user:

### Starting and Using Sessions
```php
<?php
// Must be called before any output is sent to browser
session_start();

// Store data in the session
$_SESSION['username'] = 'john';
$_SESSION['user_id'] = 123;
$_SESSION['is_admin'] = true;
$_SESSION['last_login'] = time();

// Retrieve data from the session
echo "Welcome back, " . $_SESSION['username'] . "!";
if ($_SESSION['is_admin']) {
    echo " You have admin privileges.";
}

// Check if a session variable exists
if (isset($_SESSION['user_id'])) {
    // Use the value
    $userId = $_SESSION['user_id'];
}

// Remove a single variable from the session
unset($_SESSION['last_login']);

// Destroy the entire session
session_destroy();
?>
```

### Session Configuration
```php
<?php
// Change session cookie parameters
session_set_cookie_params([
    'lifetime' => 3600,        // Session lifetime in seconds (1 hour)
    'path' => '/',             // Available across entire domain
    'domain' => 'example.com', // Restrict to specific domain
    'secure' => true,          // Only send over HTTPS
    'httponly' => true,        // Not accessible via JavaScript
    'samesite' => 'Lax'        // Controls when cookies are sent with cross-site requests
]);

// Start the session after setting parameters
session_start();

// You can also configure sessions in php.ini
// session.gc_maxlifetime = 1440 (seconds)
// session.cookie_lifetime = 0 (until browser closes)
// session.cookie_secure = 1 (only HTTPS)
// session.cookie_httponly = 1 (not accessible via JavaScript)
// session.cookie_samesite = "Lax" (PHP 7.3+)
?>
```

### Session Expiration and Regeneration
```php
<?php
session_start();

// Set session expiration time (e.g., 30 minutes)
if (!isset($_SESSION['created'])) {
    $_SESSION['created'] = time();
} else if (time() - $_SESSION['created'] > 1800) {
    // Session is older than 30 minutes
    session_regenerate_id(true); // Change session ID and delete old session
    $_SESSION['created'] = time(); // Update creation time
}

// Another approach: last activity time
if (!isset($_SESSION['last_activity'])) {
    $_SESSION['last_activity'] = time();
}

if (time() - $_SESSION['last_activity'] > 1800) {
    // Expired
    session_unset();     // Unset all session variables
    session_destroy();   // Destroy the session
    header("Location: login.php");
    exit;
}

// Update last activity time
$_SESSION['last_activity'] = time();

// Regenerate session ID periodically to prevent session fixation
if (!isset($_SESSION['created'])) {
    $_SESSION['created'] = time();
} else if (time() - $_SESSION['created'] > 1800) {
    // Session is older than 30 minutes
    session_regenerate_id(true);
    $_SESSION['created'] = time();
}
?>
```

### Simple Login System with Sessions
```php
<?php
// login.php
session_start();

// If already logged in, redirect to index
if (isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit;
}

// Check login credentials
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    
    // In a real application, you would validate against a database
    // This is a simplified example
    if ($username === 'admin' && $password === 'password') {
        // Successful login
        $_SESSION['user_id'] = 1;
        $_SESSION['username'] = 'admin';
        $_SESSION['is_admin'] = true;
        $_SESSION['login_time'] = time();
        
        // Regenerate session ID for security
        session_regenerate_id(true);
        
        header("Location: index.php");
        exit;
    } else {
        $error = "Invalid username or password";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h1>Login</h1>
    
    <?php if (isset($error)): ?>
        <p style="color: red;"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>
    
    <form method="post">
        <div>
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>
        </div>
        <div>
            <button type="submit">Login</button>
        </div>
    </form>
</body>
</html>
```

```php
<?php
// index.php
session_start();

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

// Page content for logged-in users
?>

<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h1>Welcome, <?= htmlspecialchars($_SESSION['username']) ?></h1>
    
    <p>You are logged in.</p>
    
    <?php if ($_SESSION['is_admin']): ?>
        <p>You have admin privileges.</p>
    <?php endif; ?>
    
    <p>Login time: <?= date('Y-m-d H:i:s', $_SESSION['login_time']) ?></p>
    
    <p><a href="logout.php">Logout</a></p>
</body>
</html>
```

```php
<?php
// logout.php
session_start();

// Unset all session variables
$_SESSION = [];

// Delete the session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy the session
session_destroy();

// Redirect to login page
header("Location: login.php");
exit;
?>
```

### Session Security Best Practices

1. **Use HTTPS for all session data:**
   ```php
   // Force HTTPS
   if (!isset($_SERVER['HTTPS']) || $_SERVER['HTTPS'] !== 'on') {
       header("Location: https://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
       exit;
   }
   
   // Set secure cookie parameters
   session_set_cookie_params([
       'lifetime' => 3600,
       'path' => '/',
       'domain' => 'example.com',
       'secure' => true,
       'httponly' => true,
       'samesite' => 'Lax'
   ]);
   ```

2. **Regenerate session IDs on privilege changes:**
   ```php
   // After login or changing user level
   session_regenerate_id(true);
   ```

3. **Implement session timeouts:**
   ```php
   // Check if session has expired
   $sessionTimeout = 1800; // 30 minutes
   
   if (isset($_SESSION['last_activity']) && 
       (time() - $_SESSION['last_activity'] > $sessionTimeout)) {
       // Session expired
       session_unset();
       session_destroy();
       header("Location: login.php?expired=1");
       exit;
   }
   
   // Update last activity time
   $_SESSION['last_activity'] = time();
   ```

4. **Validate user data stored in sessions:**
   ```php
   // When retrieving user ID from session, verify it's still valid
   if (isset($_SESSION['user_id'])) {
       $userId = (int)$_SESSION['user_id'];
       
       // Verify against database
       $stmt = $pdo->prepare("SELECT active FROM users WHERE id = ?");
       $stmt->execute([$userId]);
       $user = $stmt->fetch();
       
       if (!$user || $user['active'] != 1) {
           // User no longer valid
           session_unset();
           session_destroy();
           header("Location: login.php");
           exit;
       }
   }
   ```

5. **Consider using database-backed sessions for larger applications:**
   ```php
   // Configure in php.ini or at runtime
   ini_set('session.save_handler', 'user');
   
   // Implement the SessionHandlerInterface
   class DatabaseSessionHandler implements SessionHandlerInterface {
       private $db;
       
       public function __construct(PDO $db) {
           $this->db = $db;
       }
       
       public function open($savePath, $sessionName) {
           return true;
       }
       
       public function close() {
           return true;
       }
       
       public function read($id) {
           $stmt = $this->db->prepare("SELECT data FROM sessions WHERE id = ?");
           $stmt->execute([$id]);
           $row = $stmt->fetch(PDO::FETCH_ASSOC);
           
           return $row ? $row['data'] : '';
       }
       
       public function write($id, $data) {
           $stmt = $this->db->prepare(
               "REPLACE INTO sessions (id, data, last_accessed) VALUES (?, ?, NOW())"
           );
           return $stmt->execute([$id, $data]);
       }
       
       public function destroy($id) {
           $stmt = $this->db->prepare("DELETE FROM sessions WHERE id = ?");
           return $stmt->execute([$id]);
       }
       
       public function gc($maxlifetime) {
           $stmt = $this->db->prepare(
               "DELETE FROM sessions WHERE last_accessed < DATE_SUB(NOW(), INTERVAL ? SECOND)"
           );
           return $stmt->execute([$maxlifetime]);
       }
   }
   
   // Register the handler
   $handler = new DatabaseSessionHandler($pdo);
   session_set_save_handler($handler, true);
   
   // Start the session
   session_start();
   ```

## 18. Sending Emails with PHP

PHP's `mail()` function and the PHPMailer library allow you to send emails from your application:

### Using the mail() Function
```php
<?php
// Basic email
$to = 'recipient@example.com';
$subject = 'Test Email';
$message = 'This is a test email sent from PHP.';
$headers = 'From: sender@example.com' . "\r\n" .
           'Reply-To: sender@example.com' . "\r\n" .
           'X-Mailer: PHP/' . phpversion();

$success = mail($to, $subject, $message, $headers);

if ($success) {
    echo "Email sent successfully!";
} else {
    echo "Failed to send email.";
}

// HTML email
$to = 'recipient@example.com';
$subject = 'HTML Email Test';

// HTML message
$message = '
<html>
<head>
    <title>HTML Email</title>
</head>
<body>
    <h1>Hello!</h1>
    <p>This is an <b>HTML</b> email sent from <a href="https://example.com">our website</a>.</p>
    <p>Thank you!</p>
</body>
</html>
';

// Headers for HTML email
$headers = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=UTF-8' . "\r\n";
$headers .= 'From: sender@example.com' . "\r\n";

mail($to, $subject, $message, $headers);

// Email with attachment (not recommended this way)
// This method has limitations and security issues
$to = 'recipient@example.com';
$subject = 'Email with Attachment';

// Boundary for multipart message
$boundary = md5(time());

// Headers
$headers = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'From: sender@example.com' . "\r\n";
$headers .= 'Content-Type: multipart/mixed; boundary="' . $boundary . '"' . "\r\n";

// Message with attachment
$message = '--' . $boundary . "\r\n";
$message .= 'Content-Type: text/plain; charset=UTF-8' . "\r\n";
$message .= 'Content-Transfer-Encoding: 7bit' . "\r\n\r\n";
$message .= "This email contains an attachment.\r\n\r\n";

// Attachment
$file = 'document.pdf';
$content = file_get_contents($file);
$encoded_content = chunk_split(base64_encode($content));

$message .= '--' . $boundary . "\r\n";
$message .= 'Content-Type: application/pdf; name="' . basename($file) . '"' . "\r\n";
$message .= 'Content-Transfer-Encoding: base64' . "\r\n";
$message .= 'Content-Disposition: attachment; filename="' . basename($file) . '"' . "\r\n\r\n";
$message .= $encoded_content . "\r\n";
$message .= '--' . $boundary . '--';

mail($to, $subject, $message, $headers);
?>
```

### Using PHPMailer (Recommended)
PHPMailer is a popular library that provides more features and better reliability than the built-in `mail()` function:

```php
<?php
// First, install PHPMailer via Composer:
// composer require phpmailer/phpmailer

// Simple email with PHPMailer
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';

$mail = new PHPMailer(true); // true enables exceptions

try {
    // Server settings
    $mail->SMTPDebug = 0;                      // Set to 2 for debugging
    $mail->isSMTP();                           // Use SMTP
    $mail->Host       = 'smtp.example.com';    // SMTP server
    $mail->SMTPAuth   = true;                  // Enable SMTP authentication
    $mail->Username   = 'user@example.com';    // SMTP username
    $mail->Password   = 'password';            // SMTP password
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // Enable TLS encryption
    $mail->Port       = 587;                   // TCP port to connect to

    // Recipients
    $mail->setFrom('from@example.com', 'Sender Name');
    $mail->addAddress('recipient@example.com', 'Recipient Name');
    $mail->addReplyTo('reply@example.com', 'Reply Name');
    $mail->addCC('cc@example.com');
    $mail->addBCC('bcc@example.com');

    // Content
    $mail->isHTML(true);
    $mail->Subject = 'Email Subject';
    $mail->Body    = '<h1>Hello!</h1><p>This is the HTML message body.</p>';
    $mail->AltBody = 'This is the plain text version for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}

// Email with attachment using PHPMailer
$mail = new PHPMailer(true);

try {
    // Server settings (same as above)
    // ...

    // Recipients (same as above)
    // ...

    // Attachments
    $mail->addAttachment('path/to/file.pdf', 'custom_filename.pdf');    // Optional name
    $mail->addAttachment('path/to/image.jpg');                          // Use original filename

    // Content (same as above)
    // ...

    $mail->send();
    echo 'Message with attachment has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
?>
```

### Creating an Email Contact Form
```php
<?php
// contact.php
require 'vendor/autoload.php'; // For PHPMailer

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$errors = [];
$success = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get form data
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $subject = trim($_POST['subject'] ?? '');
    $message = trim($_POST['message'] ?? '');
    
    // Validate form data
    if (empty($name)) {
        $errors['name'] = 'Name is required';
    }
    
    if (empty($email)) {
        $errors['email'] = 'Email is required';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Valid email is required';
    }
    
    if (empty($subject)) {
        $errors['subject'] = 'Subject is required';
    }
    
    if (empty($message)) {
        $errors['message'] = 'Message is required';
    }
    
    // If no errors, send email
    if (empty($errors)) {
        $mail = new PHPMailer(true);
        
        try {
            // Server settings
            $mail->isSMTP();
            $mail->Host = 'smtp.example.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'your-email@example.com';
            $mail->Password = 'your-password';
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;
            
            // Recipients
            $mail->setFrom('your-email@example.com', 'Contact Form');
            $mail->addAddress('your-email@example.com');
            $mail->addReplyTo($email, $name);
            
            // Content
            $mail->isHTML(true);
            $mail->Subject = 'Contact Form: ' . $subject;
            
            // Create both HTML and plain text versions
            $htmlMessage = "
            <h2>Contact Form Submission</h2>
            <p><strong>Name:</strong> " . htmlspecialchars($name) . "</p>
            <p><strong>Email:</strong> " . htmlspecialchars($email) . "</p>
            <p><strong>Subject:</strong> " . htmlspecialchars($subject) . "</p>
            <p><strong>Message:</strong></p>
            <p>" . nl2br(htmlspecialchars($message)) . "</p>
            ";
            
            $plainMessage = "
            Contact Form Submission
            
            Name: $name
            Email: $email
            Subject: $subject
            
            Message:
            $message
            ";
            
            $mail->Body = $htmlMessage;
            $mail->AltBody = $plainMessage;
            
            $mail->send();
            $success = true;
            
            // Clear form data after successful submission
            $name = $email = $subject = $message = '';
        } catch (Exception $e) {
            $errors['mail'] = "Failed to send email. Error: {$mail->ErrorInfo}";
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        form div { margin-bottom: 15px; }
    </style>
</head>
<body>
    <h1>Contact Us</h1>
    
    <?php if ($success): ?>
        <p class="success">Thank you for your message! We'll respond as soon as possible.</p>
    <?php else: ?>
        <?php if (isset($errors['mail'])): ?>
            <p class="error"><?= htmlspecialchars($errors['mail']) ?></p>
        <?php endif; ?>
        
        <form method="post">
            <div>
                <label for="name">Name:</label><br>
                <input type="text" id="name" name="name" value="<?= htmlspecialchars($name ?? '') ?>">
                <?php if (isset($errors['name'])): ?>
                    <span class="error"><?= htmlspecialchars($errors['name']) ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" value="<?= htmlspecialchars($email ?? '') ?>">
                <?php if (isset($errors['email'])): ?>
                    <span class="error"><?= htmlspecialchars($errors['email']) ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <label for="subject">Subject:</label><br>
                <input type="text" id="subject" name="subject" value="<?= htmlspecialchars($subject ?? '') ?>">
                <?php if (isset($errors['subject'])): ?>
                    <span class="error"><?= htmlspecialchars($errors['subject']) ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <label for="message">Message:</label><br>
                <textarea id="message" name="message" rows="6" cols="50"><?= htmlspecialchars($message ?? '') ?></textarea>
                <?php if (isset($errors['message'])): ?>
                    <span class="error"><?= htmlspecialchars($errors['message']) ?></span>
                <?php endif; ?>
            </div>
            
            <div>
                <button type="submit">Send Message</button>
            </div>
        </form>
    <?php endif; ?>
</body>
</html>
```

### Email Best Practices and Security

1. **Always use SMTP instead of mail() when possible:**
   - More reliable delivery
   - Better error reporting
   - Authentication and encryption support

2. **Validate all user input:**
   ```php
   $email = filter_var($_POST['email'], FILTER_VALIDATE_EMAIL);
   if (!$email) {
       // Invalid email
   }
   ```

3. **Prevent header injection attacks:**
   ```php
   // Sanitize email headers
   $name = str_replace(["\r", "\n", "%0a", "%0d"], '', $_POST['name']);
   $email = str_replace(["\r", "\n", "%0a", "%0d"], '', $_POST['email']);
   
   // Better: use a library like PHPMailer that handles this automatically
   ```

4. **Implement rate limiting for email forms:**
   ```php
   session_start();
   
   // Check if user has submitted the form recently
   if (isset($_SESSION['last_email_time'])) {
       $timeSinceLastEmail = time() - $_SESSION['last_email_time'];
       if ($timeSinceLastEmail < 60) { // 1 minute limit
           die("Please wait before sending another email.");
       }
   }
   
   // Process email
   // ...
   
   // Record submission time
   $_SESSION['last_email_time'] = time();
   ```

5. **Use CAPTCHA or other anti-spam measures:**
   ```php
   // Using Google reCAPTCHA
   if ($_SERVER['REQUEST_METHOD'] === 'POST') {
       $recaptchaSecret = 'your-secret-key';
       $recaptchaResponse = $_POST['g-recaptcha-response'] ?? '';
       
       $recaptchaVerify = file_get_contents(
           "https://www.google.com/recaptcha/api/siteverify?secret={$recaptchaSecret}&response={$recaptchaResponse}"
       );
       
       $captchaResult = json_decode($recaptchaVerify);
       
       if (!$captchaResult->success) {
           $errors['captcha'] = 'Please verify that you are not a robot.';
       }
   }
   ```

6. **Add DKIM and SPF records to improve deliverability:**
   - Configure your DNS records properly
   - Use a reputable email service or SMTP provider

7. **Include unsubscribe links in marketing emails:**
   - Required by laws like CAN-SPAM and GDPR
   - Example: `<a href="https://example.com/unsubscribe?email=user@example.com&token=abc123">Unsubscribe</a>`

8. **Keep email size reasonable:**
   - Aim for under 100KB total
   - Optimize images
   - Link to resources rather than embedding large files

9. **Log all email activity:**
   ```php
   function logEmailSent($to, $subject, $success) {
       $logFile = 'email_log.txt';
       $timestamp = date('Y-m-d H:i:s');
       $status = $success ? 'SUCCESS' : 'FAILURE';
       $logEntry = "[$timestamp] $status - To: $to - Subject: $subject\n";
       
       file_put_contents($logFile, $logEntry, FILE_APPEND);
   }
   ```

## 19. PHP Cookies

Cookies are small pieces of data stored in the user's browser that allow websites to remember information:

### Setting Cookies
```php
<?php
// Basic cookie (name, value)
setcookie("username", "john");

// Cookie with expiration time (86400 seconds = 1 day)
setcookie("user_id", "123", time() + 86400);

// Full cookie options
setcookie(
    "preferences",      // Name
    "theme=dark",       // Value
    [
        'expires' => time() + 30*86400,  // 30 days
        'path' => '/',                   // Available throughout the site
        'domain' => 'example.com',       // Domain restriction
        'secure' => true,                // HTTPS only
        'httponly' => true,              // Not accessible via JavaScript
        'samesite' => 'Strict'           // Restrict to same site requests
    ]
);

// For PHP < 7.3 (without array syntax)
setcookie(
    "preferences", 
    "theme=dark", 
    time() + 30*86400, 
    "/", 
    "example.com", 
    true, 
    true
);
?>
```

### Reading Cookies
```php
<?php
// Check if cookie exists
if (isset($_COOKIE['username'])) {
    echo "Welcome back, " . htmlspecialchars($_COOKIE['username']);
}

// Get cookie value
$userId = $_COOKIE['user_id'] ?? null;

// Get all cookies
foreach ($_COOKIE as $name => $value) {
    echo "$name: " . htmlspecialchars($value) . "<br>";
}
?>
```

### Updating Cookies
```php
<?php
// Simply set it again with the same name
setcookie("username", "jane"); // Updates existing cookie

// For arrays or objects, you typically serialize/deserialize
$preferences = [
    'theme' => 'dark',
    'fontSize' => 'large',
    'notifications' => true
];

setcookie("user_prefs", json_encode($preferences), time() + 86400);

// Reading back
if (isset($_COOKIE['user_prefs'])) {
    $preferences = json_decode($_COOKIE['user_prefs'], true);
    echo "Theme: " . htmlspecialchars($preferences['theme']);
}
?>
```

### Deleting Cookies
```php
<?php
// Set expiration time in the past
setcookie("username", "", time() - 3600);

// More thorough deletion
setcookie(
    "username",
    "",
    [
        'expires' => time() - 3600,
        'path' => '/',
        'domain' => 'example.com',
        'secure' => true,
        'httponly' => true,
        'samesite' => 'Strict'
    ]
);

// Delete all cookies
foreach ($_COOKIE as $name => $value) {
    setcookie($name, "", time() - 3600);
}
?>
```

### Common Uses of Cookies

**1. Remember Me Functionality:**
```php
<?php
// login.php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    $remember = isset($_POST['remember']);
    
    // Validate credentials (simplified example)
    if ($username === 'admin' && $password === 'password') {
        // Set session
        session_start();
        $_SESSION['user_id'] = 1;
        
        // If remember me is checked, set a persistent cookie
        if ($remember) {
            // Generate a secure token
            $token = bin2hex(random_bytes(32));
            
            // Store the token in database (simplified)
            // saveRememberToken($userId, $token);
            
            // Set cookie for 30 days
            setcookie(
                "remember_token",
                $token,
                [
                    'expires' => time() + 30*86400,
                    'path' => '/',
                    'httponly' => true,
                    'secure' => true,
                    'samesite' => 'Lax'
                ]
            );
        }
        
        header("Location: dashboard.php");
        exit;
    }
}
?>

<!-- Login form -->
<form method="post">
    <!-- Username and password fields -->
    <div>
        <input type="checkbox" id="remember" name="remember">
        <label for="remember">Remember me</label>
    </div>
    <button type="submit">Login</button>
</form>
```

```php
<?php
// check_auth.php
session_start();

// Function to check if user is logged in
function isLoggedIn() {
    // Check session first
    if (isset($_SESSION['user_id'])) {
        return true;
    }
    
    // Check remember token cookie
    if (isset($_COOKIE['remember_token'])) {
        $token = $_COOKIE['remember_token'];
        
        // Verify token in database (simplified)
        // $userId = getUserIdFromToken($token);
        $userId = 1; // For example only
        
        if ($userId) {
            // Valid token, set session
            $_SESSION['user_id'] = $userId;
            return true;
        } else {
            // Invalid token, clear cookie
            setcookie("remember_token", "", time() - 3600, "/");
        }
    }
    
    return false;
}

// Usage
if (!isLoggedIn()) {
    header("Location: login.php");
    exit;
}
?>
```

**2. User Preferences:**
```php
<?php
// save_preferences.php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $theme = $_POST['theme'] ?? 'light';
    $fontSize = $_POST['font_size'] ?? 'medium';
    
    $preferences = [
        'theme' => $theme,
        'fontSize' => $fontSize,
        'timestamp' => time()
    ];
    
    // Save preferences in cookie
    setcookie(
        "user_preferences",
        json_encode($preferences),
        time() + 365*86400, // 1 year
        "/"
    );
    
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit;
}
?>

<!-- Preferences form -->
<form method="post" action="save_preferences.php">
    <div>
        <label>Theme:</label>
        <select name="theme">
            <option value="light">Light</option>
            <option value="dark">Dark</option>
        </select>
    </div>
    <div>
        <label>Font Size:</label>
        <select name="font_size">
            <option value="small">Small</option>
            <option value="medium">Medium</option>
            <option value="large">Large</option>
        </select>
    </div>
    <button type="submit">Save Preferences</button>
</form>
```

```php
<?php
// Apply preferences
$defaultPreferences = [
    'theme' => 'light',
    'fontSize' => 'medium'
];

$preferences = $defaultPreferences;

if (isset($_COOKIE['user_preferences'])) {
    $savedPrefs = json_decode($_COOKIE['user_preferences'], true);
    if (is_array($savedPrefs)) {
        $preferences = array_merge($defaultPreferences, $savedPrefs);
    }
}

// Apply CSS based on preferences
$themeClass = htmlspecialchars($preferences['theme']);
$fontSizeClass = htmlspecialchars($preferences['fontSize']);
?>

<!DOCTYPE html>
<html>
<head>
    <title>User Preferences Example</title>
    <style>
        body.light { background-color: #fff; color: #333; }
        body.dark { background-color: #333; color: #fff; }
        body.small { font-size: 14px; }
        body.medium { font-size: 16px; }
        body.large { font-size: 18px; }
    </style>
</head>
<body class="<?= $themeClass ?> <?= $fontSizeClass ?>">
    <h1>Welcome to our site</h1>
    <p>This content adapts to your preferences.</p>
</body>
</html>
```

**3. Shopping Cart:**
```php
<?php
// add_to_cart.php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $productId = (int)$_POST['product_id'];
    $quantity = (int)$_POST['quantity'];
    
    if ($productId <= 0 || $quantity <= 0) {
        die("Invalid product or quantity");
    }
    
    // Get current cart
    $cart = [];
    if (isset($_COOKIE['shopping_cart'])) {
        $cart = json_decode($_COOKIE['shopping_cart'], true);
        if (!is_array($cart)) {
            $cart = [];
        }
    }
    
    // Add or update product in cart
    if (isset($cart[$productId])) {
        $cart[$productId] += $quantity;
    } else {
        $cart[$productId] = $quantity;
    }
    
    // Save updated cart
    setcookie(
        "shopping_cart",
        json_encode($cart),
        time() + 7*86400, // 1 week
        "/"
    );
    
    header("Location: cart.php");
    exit;
}
?>
```

```php
<?php
// cart.php
// Get cart data
$cart = [];
if (isset($_COOKIE['shopping_cart'])) {
    $cart = json_decode($_COOKIE['shopping_cart'], true) ?? [];
}

// Sample product data (in real app, would come from database)
$products = [
    1 => ['name' => 'Product A', 'price' => 19.99],
    2 => ['name' => 'Product B', 'price' => 29.99],
    3 => ['name' => 'Product C', 'price' => 39.99]
];

// Calculate totals
$totalItems = 0;
$totalPrice = 0;

foreach ($cart as $productId => $quantity) {
    if (isset($products[$productId])) {
        $totalItems += $quantity;
        $totalPrice += $products[$productId]['price'] * $quantity;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
</head>
<body>
    <h1>Your Shopping Cart</h1>
    
    <?php if (empty($cart)): ?>
        <p>Your cart is empty.</p>
    <?php else: ?>
        <table border="1">
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
            <?php foreach ($cart as $productId => $quantity): ?>
                <?php if (isset($products[$productId])): ?>
                    <tr>
                        <td><?= htmlspecialchars($products[$productId]['name']) ?></td>
                        <td>$<?= number_format($products[$productId]['price'], 2) ?></td>
                        <td><?= $quantity ?></td>
                        <td>$<?= number_format($products[$productId]['price'] * $quantity, 2) ?></td>
                    </tr>
                <?php endif; ?>
            <?php endforeach; ?>
            <tr>
                <td colspan="3"><strong>Total</strong></td>
                <td><strong>$<?= number_format($totalPrice, 2) ?></strong></td>
            </tr>
        </table>
        
        <p>
            <a href="clear_cart.php">Clear Cart</a>
        </p>
    <?php endif; ?>
    
    <p>
        <a href="products.php">Continue Shopping</a>
    </p>
</body>
</html>
```

```php
<?php
// clear_cart.php
setcookie("shopping_cart", "", time() - 3600, "/");
header("Location: cart.php");
exit;
?>
```

### Cookie Security Best Practices

1. **Use the HttpOnly flag to prevent JavaScript access:**
   ```php
   setcookie("user_id", "123", [
       'expires' => time() + 86400,
       'httponly' => true
   ]);
   ```

2. **Use the Secure flag to ensure cookies are sent only over HTTPS:**
   ```php
   setcookie("user_id", "123", [
       'expires' => time() + 86400,
       'secure' => true
   ]);
   ```

3. **Use the SameSite attribute to prevent CSRF attacks:**
   ```php
   setcookie("user_id", "123", [
       'expires' => time() + 86400,
       'samesite' => 'Lax' // Options: None, Lax, Strict
   ]);
   ```

4. **Set a reasonable expiration time:**
   ```php
   // Session cookie (expires when browser closes)
   setcookie("temp_data", "value");
   
   // Short-lived cookie for sensitive data
   setcookie("auth_token", $token, time() + 3600); // 1 hour
   
   // Longer cookie for preferences
   setcookie("preferences", $prefs, time() + 30*86400); // 30 days
   ```

5. **Never store sensitive information in cookies:**
   ```php
   // BAD: Storing password or personal data
   setcookie("user_password", $password); // Never do this!
   
   // GOOD: Store just an identifier
   setcookie("user_id", $userId);
   ```

6. **Use encryption for sensitive cookie data:**
   ```php
   // Using sodium library for encryption (PHP 7.2+)
   $key = /* your secure key */;
   $data = json_encode(['user_id' => 123, 'role' => 'admin']);
   
   $nonce = random_bytes(SODIUM_CRYPTO_SECRETBOX_NONCEBYTES);
   $ciphertext = sodium_crypto_secretbox($data, $nonce, $key);
   $cookie_value = base64_encode($nonce . $ciphertext);
   
   setcookie("encrypted_data", $cookie_value, [
       'expires' => time() + 3600,
       'httponly' => true,
       'secure' => true
   ]);
   
   // Decryption
   if (isset($_COOKIE['encrypted_data'])) {
       $cookie_value = base64_decode($_COOKIE['encrypted_data']);
       $nonce = mb_substr($cookie_value, 0, SODIUM_CRYPTO_SECRETBOX_NONCEBYTES, '8bit');
       $ciphertext = mb_substr($cookie_value, SODIUM_CRYPTO_SECRETBOX_NONCEBYTES, null, '8bit');
       
       $data = sodium_crypto_secretbox_open($ciphertext, $nonce, $key);
       if ($data !== false) {
           $data = json_decode($data, true);
           // Use $data
       }
   }
   ```

7. **Limit cookie size:**
   - Browsers typically limit cookies to 4KB per domain
   - Use cookies for small pieces of data, consider localStorage for larger client-side storage