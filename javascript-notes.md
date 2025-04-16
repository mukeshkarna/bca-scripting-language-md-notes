# Unit 1: Client Side Scripting - JavaScript

## 1. Introduction to JavaScript

### What is JavaScript?
JavaScript is a lightweight, interpreted programming language primarily used for client-side web development. It allows you to make web pages interactive by:
- Responding to user actions
- Modifying content dynamically
- Validating form inputs
- Creating animations and effects
- Communicating with servers asynchronously

### Key Features
- **Client-side execution**: Runs in the user's browser
- **Interpreted**: No compilation needed
- **Event-driven**: Responds to user actions
- **Object-oriented**: Uses objects to organize code and data
- **Loosely typed**: Variables can change types
- **Cross-platform**: Works on all major browsers and devices

### JavaScript vs. Java
Despite the similar name, JavaScript is entirely different from Java:
- JavaScript was created by Brendan Eich at Netscape in 1995
- Originally named "Mocha", then "LiveScript", finally "JavaScript"
- The name change to JavaScript was primarily for marketing reasons
- Different syntax, semantics, and use cases than Java

## 2. Need for Client-Side Scripting Languages

### Limitations of HTML and CSS
- HTML: Provides structure but is static
- CSS: Provides styling but has limited interactivity
- Both lack programming capabilities (conditionals, loops, etc.)

### Benefits of Client-Side Scripting
- **Reduced server load**: Processing happens on the client's device
- **Improved user experience**: Instant feedback without page reloads
- **Offline functionality**: Some features can work without internet
- **Reduced bandwidth usage**: Only necessary data is transmitted
- **Enhanced interactivity**: Dynamic content and user interface elements

### Common Client-Side Scripting Languages
- JavaScript (dominant)
- WebAssembly (for performance-critical applications)
- Historically: VBScript (deprecated), Flash/ActionScript (deprecated)

## 3. Formatting and Coding Conventions

### Code Style Guidelines
- Use consistent indentation (2 or 4 spaces)
- Use camelCase for variables and functions
- Use PascalCase for classes and constructors
- Use UPPERCASE for constants
- Place opening braces on the same line as the statement
- End statements with semicolons
- Add spaces around operators

### Commenting Best Practices
- Single-line comments: `// This is a comment`
- Multi-line comments: `/* This is a multi-line comment */`
- Document functions with JSDoc-style comments:
  ```javascript
  /**
   * Calculates the sum of two numbers
   * @param {number} a - First number
   * @param {number} b - Second number
   * @return {number} Sum of a and b
   */
  function add(a, b) {
      return a + b;
  }
  ```

### Code Organization
- Group related functionality
- Separate logic into functions
- Use meaningful variable and function names
- Avoid deeply nested code
- Limit line length (typically 80-120 characters)

## 4. JavaScript Files and Integration

### External JavaScript Files
- Create files with `.js` extension
- Link in HTML using the `<script>` tag:
  ```html
  <script src="script.js"></script>
  ```
- Benefits: caching, organization, separation of concerns

### Inline JavaScript
- Embedded directly in HTML using `<script>` tags:
  ```html
  <script>
    alert("Hello, world!");
  </script>
  ```
- Use sparingly; prefer external files for maintainability

### Script Placement
- Traditionally placed in the `<head>` section
- Modern best practice: place before closing `</body>` tag to improve page load performance
- Alternative: Use `defer` or `async` attributes:
  ```html
  <script src="script.js" defer></script>
  <script src="analytics.js" async></script>
  ```

## 5. Using Script and NoScript Tags

### Script Tag Attributes
- **`src`**: Path to external JavaScript file
- **`type`**: Specifies the MIME type (optional in HTML5, defaults to "text/javascript")
- **`defer`**: Delays execution until after HTML parsing
- **`async`**: Loads script asynchronously with HTML parsing
- **`charset`**: Specifies character encoding (rarely needed)
- **`crossorigin`**: CORS settings for loading from different domains

### NoScript Tag
- Provides fallback content when JavaScript is disabled:
  ```html
  <noscript>
    <p>Please enable JavaScript to use this application.</p>
  </noscript>
  ```
- Good for accessibility and graceful degradation
- Should contain meaningful alternative content

## 6. JavaScript Syntax Basics

### Variables and Data Types
- Declaring variables: `var`, `let`, `const`
  ```javascript
  var name = "John";       // Function-scoped, can be redeclared
  let age = 25;            // Block-scoped, cannot be redeclared
  const PI = 3.14159;      // Block-scoped, cannot be reassigned
  ```

- Primitive data types:
  - **String**: Text values - `"Hello"`, `'World'`
  - **Number**: Numeric values - `42`, `3.14`
  - **Boolean**: `true` or `false` 
  - **Undefined**: Variable declared but not assigned
  - **Null**: Explicitly assigned "no value"
  - **Symbol**: Unique identifier (ES6)
  - **BigInt**: Large integers (ES11)

- Complex data types:
  - **Object**: Collection of key-value pairs
  - **Array**: Ordered list of values
  - **Function**: Reusable blocks of code
  - **Date**: Date and time representation

### Operators

#### Arithmetic Operators
- Addition: `+`
- Subtraction: `-`
- Multiplication: `*`
- Division: `/`
- Modulus (remainder): `%`
- Exponentiation: `**`
- Increment: `++`
- Decrement: `--`

#### Assignment Operators
- Basic assignment: `=`
- Add and assign: `+=`
- Subtract and assign: `-=`
- Multiply and assign: `*=`
- Divide and assign: `/=`
- Modulus and assign: `%=`

#### Comparison Operators
- Equal value: `==`
- Equal value and type: `===` (strict equality)
- Not equal value: `!=`
- Not equal value or type: `!==` (strict inequality)
- Greater than: `>`
- Less than: `<`
- Greater than or equal: `>=`
- Less than or equal: `<=`

#### Logical Operators
- Logical AND: `&&`
- Logical OR: `||`
- Logical NOT: `!`
- Nullish coalescing: `??`

#### Other Operators
- Ternary: `condition ? trueValue : falseValue`
- String concatenation: `+`
- Type operator: `typeof`
- Instance operator: `instanceof`

## 7. Control Structures

### Conditional Statements

#### If Statement
```javascript
if (condition) {
    // Code executed if condition is true
}
```

#### If-Else Statement
```javascript
if (condition) {
    // Code executed if condition is true
} else {
    // Code executed if condition is false
}
```

#### If-Else If-Else Statement
```javascript
if (condition1) {
    // Code executed if condition1 is true
} else if (condition2) {
    // Code executed if condition1 is false and condition2 is true
} else {
    // Code executed if both conditions are false
}
```

#### Switch Statement
```javascript
switch (expression) {
    case value1:
        // Code executed if expression === value1
        break;
    case value2:
        // Code executed if expression === value2
        break;
    default:
        // Code executed if no case matches
}
```

### Loops

#### For Loop
```javascript
for (initialization; condition; increment) {
    // Code executed repeatedly until condition is false
}

// Example
for (let i = 0; i < 5; i++) {
    console.log(i); // Outputs 0, 1, 2, 3, 4
}
```

#### While Loop
```javascript
while (condition) {
    // Code executed repeatedly until condition is false
}

// Example
let i = 0;
while (i < 5) {
    console.log(i); // Outputs 0, 1, 2, 3, 4
    i++;
}
```

#### Do-While Loop
```javascript
do {
    // Code executed at least once, then repeatedly until condition is false
} while (condition);

// Example
let i = 0;
do {
    console.log(i); // Outputs 0, 1, 2, 3, 4
    i++;
} while (i < 5);
```

#### Break and Continue
- `break`: Exits the loop completely
- `continue`: Skips the current iteration and continues the loop

## 8. Arrays and For-Each Loop

### Array Basics
- Creating arrays:
  ```javascript
  let fruits = ["apple", "banana", "cherry"];
  let numbers = new Array(1, 2, 3, 4, 5);
  let mixed = [1, "two", true, {name: "John"}, [5, 6]];
  ```

- Accessing elements:
  ```javascript
  let firstFruit = fruits[0]; // "apple"
  ```

- Modifying elements:
  ```javascript
  fruits[1] = "orange"; // Changes "banana" to "orange"
  ```

- Array properties and methods:
  - `length`: Returns number of elements
  - `push()`: Adds element to end
  - `pop()`: Removes and returns last element
  - `shift()`: Removes and returns first element
  - `unshift()`: Adds element to beginning
  - `concat()`: Joins arrays
  - `slice()`: Returns portion of array
  - `splice()`: Adds/removes elements
  - `indexOf()`: Finds element index
  - `sort()`: Sorts elements
  - `reverse()`: Reverses order

### For-Each Loop
- Traditional approach with for loop:
  ```javascript
  for (let i = 0; i < fruits.length; i++) {
      console.log(fruits[i]);
  }
  ```

- Using for...of loop (ES6):
  ```javascript
  for (let fruit of fruits) {
      console.log(fruit);
  }
  ```

- Using forEach method:
  ```javascript
  fruits.forEach(function(fruit) {
      console.log(fruit);
  });
  
  // With arrow function (ES6)
  fruits.forEach(fruit => console.log(fruit));
  ```

## 9. Defining and Invoking Functions

### Function Declaration
```javascript
function greet(name) {
    return "Hello, " + name + "!";
}

// Calling the function
let greeting = greet("John"); // "Hello, John!"
```

### Function Expression
```javascript
const greet = function(name) {
    return "Hello, " + name + "!";
};

// Calling the function
let greeting = greet("John"); // "Hello, John!"
```

### Arrow Functions (ES6)
```javascript
const greet = (name) => {
    return "Hello, " + name + "!";
};

// Shorter syntax for single-line functions
const greet = name => "Hello, " + name + "!";

// Calling the function
let greeting = greet("John"); // "Hello, John!"
```

### Function Parameters
- Default parameters:
  ```javascript
  function greet(name = "Guest") {
      return "Hello, " + name + "!";
  }
  
  greet(); // "Hello, Guest!"
  ```

- Rest parameters:
  ```javascript
  function sum(...numbers) {
      return numbers.reduce((total, num) => total + num, 0);
  }
  
  sum(1, 2, 3, 4); // 10
  ```

### Scope and Closures
- Global scope: Variables defined outside functions
- Local scope: Variables defined inside functions
- Block scope: Variables defined in code blocks (with `let` and `const`)
- Closures: Functions that remember their creation environment

## 10. Built-in Objects

### Math Object
```javascript
Math.PI; // 3.141592653589793
Math.round(4.7); // 5
Math.pow(2, 3); // 8
Math.sqrt(16); // 4
Math.abs(-5); // 5
Math.floor(4.7); // 4
Math.ceil(4.3); // 5
Math.random(); // Random number between 0 and 1
```

### String Object
```javascript
let text = "Hello, World!";
text.length; // 13
text.toUpperCase(); // "HELLO, WORLD!"
text.toLowerCase(); // "hello, world!"
text.indexOf("World"); // 7
text.substring(7, 12); // "World"
text.replace("World", "JavaScript"); // "Hello, JavaScript!"
text.split(", "); // ["Hello", "World!"]
```

### Array Object
```javascript
let fruits = ["apple", "banana", "cherry"];
fruits.length; // 3
fruits.join(", "); // "apple, banana, cherry"
fruits.includes("banana"); // true
fruits.filter(fruit => fruit.length > 5); // ["banana", "cherry"]
fruits.map(fruit => fruit.toUpperCase()); // ["APPLE", "BANANA", "CHERRY"]
fruits.find(fruit => fruit.startsWith("a")); // "apple"
fruits.some(fruit => fruit.length > 5); // true
fruits.every(fruit => fruit.length > 3); // true
```

### JSON Object
```javascript
// Converting object to JSON string
let person = { name: "John", age: 30 };
let jsonString = JSON.stringify(person); // '{"name":"John","age":30}'

// Converting JSON string to object
let jsonObj = JSON.parse(jsonString); // {name: "John", age: 30}
```

## 11. Date Objects

### Creating Date Objects
```javascript
// Current date and time
let now = new Date();

// Specific date and time
let date1 = new Date("2023-01-15"); // ISO format
let date2 = new Date(2023, 0, 15); // Year, month (0-11), day
let date3 = new Date(2023, 0, 15, 10, 30, 0); // Year, month, day, hour, minute, second
```

### Date Methods
```javascript
let date = new Date();

// Getters
date.getFullYear(); // e.g., 2023
date.getMonth(); // 0-11 (Jan-Dec)
date.getDate(); // 1-31
date.getDay(); // 0-6 (Sun-Sat)
date.getHours(); // 0-23
date.getMinutes(); // 0-59
date.getSeconds(); // 0-59
date.getMilliseconds(); // 0-999
date.getTime(); // Milliseconds since Jan 1, 1970

// Setters
date.setFullYear(2024);
date.setMonth(11); // December
date.setDate(25);
date.setHours(10);
date.setMinutes(30);
date.setSeconds(0);
```

### Date Formatting
```javascript
let date = new Date();

// Built-in formats
date.toString(); // "Wed Jan 15 2023 10:30:00 GMT+0000 (Coordinated Universal Time)"
date.toDateString(); // "Wed Jan 15 2023"
date.toTimeString(); // "10:30:00 GMT+0000 (Coordinated Universal Time)"
date.toISOString(); // "2023-01-15T10:30:00.000Z"
date.toLocaleString(); // "1/15/2023, 10:30:00 AM"
date.toLocaleDateString(); // "1/15/2023"
date.toLocaleTimeString(); // "10:30:00 AM"

// Custom formatting (manual)
function formatDate(date) {
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
}
```

## 12. Interacting with the Browser

### Browser Object Model (BOM)
- **Window Object**: The global object in browser-side JavaScript
  ```javascript
  window.innerHeight; // Height of browser window viewport
  window.innerWidth; // Width of browser window viewport
  window.open("https://example.com"); // Open new window/tab
  window.close(); // Close current window
  window.location.href; // Current URL
  window.location.hostname; // Domain name
  window.location.pathname; // Path
  window.location.search; // Query string
  window.history.back(); // Navigate back
  window.history.forward(); // Navigate forward
  ```

- **Navigator Object**: Information about the browser
  ```javascript
  navigator.userAgent; // Browser identification
  navigator.language; // Browser language
  navigator.onLine; // Online status
  navigator.geolocation.getCurrentPosition(); // Get user location
  ```

- **Screen Object**: Information about user's screen
  ```javascript
  screen.width; // Screen width
  screen.height; // Screen height
  screen.availWidth; // Available screen width
  screen.availHeight; // Available screen height
  screen.colorDepth; // Color depth
  ```

### Timing Functions
```javascript
// Execute once after delay
setTimeout(function() {
    console.log("Executed after 2 seconds");
}, 2000);

// Clear timeout
let timeoutId = setTimeout(function() {}, 1000);
clearTimeout(timeoutId);

// Execute repeatedly
setInterval(function() {
    console.log("Executes every 3 seconds");
}, 3000);

// Clear interval
let intervalId = setInterval(function() {}, 1000);
clearInterval(intervalId);
```

## 13. Windows and Frames

### Window Management
```javascript
// Open new window
let newWindow = window.open("https://example.com", "Example", "width=500,height=400");

// Close window
newWindow.close();

// Check if window was closed
if (newWindow.closed) {
    console.log("Window was closed");
}

// Focus window
newWindow.focus();

// Window dimensions
let width = window.outerWidth;
let height = window.outerHeight;

// Window position
window.moveTo(100, 100); // Move to specific coordinates
window.moveBy(10, 10); // Move relative to current position

// Window size
window.resizeTo(800, 600); // Resize to specific dimensions
window.resizeBy(10, 10); // Resize relative to current size
```

### Working with Frames
```html
<frameset rows="50%,50%">
    <frame src="top.html" name="topFrame">
    <frame src="bottom.html" name="bottomFrame">
</frameset>
```

```javascript
// Access frames
window.frames[0]; // First frame
window.frames["topFrame"]; // Frame by name

// Access parent window from frame
window.parent;

// Access top-most window
window.top;

// Navigate frame
window.frames["topFrame"].location.href = "new-page.html";
```

### iframes (Modern Approach)
```html
<iframe src="content.html" name="myIframe" width="500" height="300"></iframe>
```

```javascript
// Access iframe content
let iframe = document.getElementById("myIframe");
let iframeDocument = iframe.contentDocument || iframe.contentWindow.document;

// Access parent from iframe
window.parent;

// Communication between frames
// In parent window:
window.addEventListener("message", function(event) {
    console.log("Message from iframe:", event.data);
});

// In iframe:
window.parent.postMessage("Hello from iframe!", "*");
```

## 14. Document Object Model (DOM)

### DOM Structure
- The DOM represents HTML as a tree structure:
  - **Document**: Root of the DOM tree
  - **Elements**: HTML tags
  - **Attributes**: Properties of elements
  - **Text**: Content within elements

### Selecting DOM Elements
```javascript
// By ID
let element = document.getElementById("myId");

// By class name
let elements = document.getElementsByClassName("myClass");

// By tag name
let paragraphs = document.getElementsByTagName("p");

// CSS selectors (more versatile)
let element = document.querySelector("#myId"); // First matching element
let elements = document.querySelectorAll(".myClass"); // All matching elements
```

### Manipulating DOM Elements
```javascript
// Changing content
element.textContent = "New text"; // Plain text
element.innerHTML = "<strong>Bold text</strong>"; // HTML content

// Changing attributes
element.setAttribute("class", "newClass");
element.getAttribute("class");
element.removeAttribute("class");

// Shorthand for common attributes
element.id = "newId";
element.className = "newClass";
element.style.color = "red";
element.style.fontSize = "16px";

// Adding/removing classes
element.classList.add("highlight");
element.classList.remove("old");
element.classList.toggle("active");
element.classList.contains("highlight"); // Check if class exists
```

### Creating and Modifying Elements
```javascript
// Create new element
let newDiv = document.createElement("div");
newDiv.textContent = "Hello, world!";

// Add to DOM
document.body.appendChild(newDiv); // Add as last child
parentElement.insertBefore(newDiv, referenceElement); // Add before specific element

// Modern insertion methods
parentElement.append(newDiv); // Add as last child
parentElement.prepend(newDiv); // Add as first child
referenceElement.before(newDiv); // Add before element
referenceElement.after(newDiv); // Add after element
referenceElement.replaceWith(newDiv); // Replace element

// Remove elements
element.remove(); // Modern method
parentElement.removeChild(element); // Traditional method
```

### Traversing the DOM
```javascript
// Parent
element.parentNode; // Any parent node
element.parentElement; // Element parent

// Children
element.childNodes; // All child nodes (including text nodes)
element.children; // Only element children
element.firstChild; // First child node
element.lastChild; // Last child node
element.firstElementChild; // First element child
element.lastElementChild; // Last element child

// Siblings
element.previousSibling; // Previous sibling node
element.nextSibling; // Next sibling node
element.previousElementSibling; // Previous element sibling
element.nextElementSibling; // Next element sibling
```

## 15. Event Handling

### Event Registration
```javascript
// Method 1: HTML attribute (not recommended)
<button onclick="alert('Clicked!')">Click me</button>

// Method 2: DOM property
document.getElementById("myButton").onclick = function() {
    alert("Clicked!");
};

// Method 3: Event listeners (recommended)
document.getElementById("myButton").addEventListener("click", function(event) {
    alert("Clicked!");
});
```

### Common Event Types
- **Mouse events**: `click`, `dblclick`, `mousedown`, `mouseup`, `mousemove`, `mouseover`, `mouseout`, `mouseenter`, `mouseleave`
- **Keyboard events**: `keydown`, `keyup`, `keypress`
- **Form events**: `submit`, `reset`, `change`, `input`, `focus`, `blur`
- **Window events**: `load`, `resize`, `scroll`, `unload`, `beforeunload`
- **Document events**: `DOMContentLoaded`
- **Touch events**: `touchstart`, `touchend`, `touchmove`, `touchcancel`

### Event Object
```javascript
element.addEventListener("click", function(event) {
    // Event information
    console.log(event.type); // "click"
    console.log(event.target); // Element that triggered the event
    console.log(event.currentTarget); // Element that the listener is attached to
    
    // Mouse position
    console.log(event.clientX, event.clientY); // Relative to viewport
    console.log(event.pageX, event.pageY); // Relative to document
    
    // Keyboard information (for keyboard events)
    console.log(event.key); // Key value
    console.log(event.keyCode); // Key code (deprecated)
    console.log(event.code); // Physical key identifier
    
    // Modifier keys
    console.log(event.ctrlKey); // Whether Ctrl was pressed
    console.log(event.shiftKey); // Whether Shift was pressed
    console.log(event.altKey); // Whether Alt was pressed
    console.log(event.metaKey); // Whether Meta/Command was pressed
    
    // Prevent default behavior
    event.preventDefault();
    
    // Stop propagation
    event.stopPropagation();
});
```

### Event Propagation
- **Bubbling**: Events propagate from the target element up through ancestors
- **Capturing**: Events propagate from the root down to the target element
- **Event delegation**: Attaching a single event listener to a parent element that will fire for all descendants matching a selector

```javascript
// With event delegation
document.getElementById("parent").addEventListener("click", function(event) {
    if (event.target.matches(".button")) {
        console.log("Button clicked:", event.target);
    }
});

// Specify capture phase
element.addEventListener("click", handler, true); // Third parameter for capture phase
```

## 16. Forms and Form Handling

### Accessing Forms and Form Elements
```javascript
// Access form by ID
let form = document.getElementById("myForm");

// Access form by name
let form = document.forms["myForm"];

// Access elements within a form
let username = form.elements["username"];
let password = form.elements["password"];

// Shorthand if element has a name attribute
let username = form.username;
```

### Form Events
```javascript
// Form submission
form.addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent form submission
    console.log("Form submitted");
    // Validate and process form data
});

// Input changes
form.username.addEventListener("input", function(event) {
    console.log("Input value changed:", this.value);
});

// Focus/blur
form.username.addEventListener("focus", function() {
    console.log("Input received focus");
});

form.username.addEventListener("blur", function() {
    console.log("Input lost focus");
});

// Form reset
form.addEventListener("reset", function(event) {
    console.log("Form reset");
});
```

### Form Validation
```javascript
form.addEventListener("submit", function(event) {
    let username = form.username.value;
    let password = form.password.value;
    let isValid = true;
    
    // Validate username
    if (username.trim() === "") {
        document.getElementById("usernameError").textContent = "Username is required";
        isValid = false;
    } else {
        document.getElementById("usernameError").textContent = "";
    }
    
    // Validate password
    if (password.length < 8) {
        document.getElementById("passwordError").textContent = "Password must be at least 8 characters";
        isValid = false;
    } else {
        document.getElementById("passwordError").textContent = "";
    }
    
    // Prevent submission if invalid
    if (!isValid) {
        event.preventDefault();
    }
});
```

### Form Data Processing
```javascript
form.addEventListener("submit", function(event) {
    event.preventDefault();
    
    // Method 1: Access individual form elements
    let username = form.username.value;
    let password = form.password.value;
    
    // Method 2: FormData object (modern approach)
    let formData = new FormData(form);
    
    // Access FormData values
    let username = formData.get("username");
    let password = formData.get("password");
    
    // Convert FormData to object
    let formObject = Object.fromEntries(formData.entries());
    console.log(formObject); // {username: "value", password: "value", ...}
    
    // Submit data via fetch API
    fetch("https://example.com/api/submit", {
        method: "POST",
        body: formData
    })
    .then(response => response.json())
    .then(data => console.log("Success:", data))
    .catch(error => console.error("Error:", error));
});
```

### HTML5 Form Validation
```html
<form id="myForm">
    <input type="text" name="username" required>
    <input type="email" name="email" required>
    <input type="password" name="password" minlength="8" required>
    <input type="number" name="age" min="18" max="120">
    <input type="url" name="website">
    <input type="tel" name="phone" pattern="[0-9]{10}">
    <button type="submit">Submit</button>
</form>
```

```javascript
// Check validity
let isValid = form.checkValidity();

// Check individual element validity
let isUsernameValid = form.username.checkValidity();

// Custom validation messages
form.username.setCustomValidity("Username already taken");
form.username.reportValidity();
```

## 17. Cookies

### What are Cookies?
- Small text files stored in the browser
- Used to store information about the user or session
- Limited to approximately 4KB per cookie
- Associate with a specific domain
- Have expiration dates (session or persistent)

### Creating Cookies
```javascript
// Basic cookie
document.cookie = "username=John";

// With expiration date
document.cookie = "username=John; expires=Thu, 31 Dec 2023 23:59:59 UTC";

// With expiration in days
function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/";
}

// Additional parameters
document.cookie = "username=John; expires=Thu, 31 Dec 2023 23:59:59 UTC; path=/; domain=example.com; secure; samesite=strict";
```

### Reading Cookies
```javascript
// Read all cookies
let allCookies = document.cookie; // Returns "cookie1=value1; cookie2=value2; ..."

// Function to get specific cookie
function getCookie(name) {
    let nameEQ = name + "=";
    let ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i].trim();
        if (c.indexOf(nameEQ) === 0) {
            return decodeURIComponent(c.substring(nameEQ.length, c.length));
        }
    }
    return null;
}

// Usage
let username = getCookie("username");
```

### Updating Cookies
```javascript
// Same as creating - just set again with the same name
document.cookie = "username=Jane; expires=Thu, 31 Dec 2023 23:59:59 UTC; path=/";
```

### Deleting Cookies
```javascript
// Set expiration date to the past
document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";

// Function to delete cookie
function deleteCookie(name) {
    document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
}
```

### Cookie Limitations and Best Practices
- **Security concerns**: Don't store sensitive information in cookies
- **Size limitations**: Maximum ~4KB per cookie
- **Number limitations**: Most browsers limit to 50-300 cookies per domain
- **Set appropriate flags**:
  - `HttpOnly`: Prevents JavaScript access (server-side cookies only)
  - `Secure`: Only sent over HTTPS connections
  - `SameSite`: Controls cross-site request behavior
- **Consider alternatives**: For larger storage needs, consider `localStorage` or `sessionStorage`
- **Respect privacy laws**: Inform users about cookies (GDPR, CCPA, etc.)

## 18. Regular Expressions

### Creating Regular Expressions
```javascript
// Method 1: Literal notation
let pattern1 = /pattern/flags;

// Method 2: Constructor
let pattern2 = new RegExp("pattern", "flags");
```

### Regular Expression Flags
- `g`: Global match (find all matches)
- `i`: Case-insensitive matching
- `m`: Multi-line matching
- `s`: Dot matches newlines
- `u`: Unicode support
- `y`: Sticky matching

### Pattern Syntax
- **Character classes**:
  - `.`: Any character except newline
  - `\d`: Digit [0-9]
  - `\D`: Non-digit
  - `\w`: Word character [A-Za-z0-9_]
  - `\W`: Non-word character
  - `\s`: Whitespace
  - `\S`: Non-whitespace
  - `[abc]`: Any character in the brackets
  - `[^abc]`: Any character not in the brackets
  - `[a-z]`: Character range

- **Quantifiers**:
  - `*`: 0 or more
  - `+`: 1 or more
  - `?`: 0 or 1
  - `{n}`: Exactly n occurrences
  - `{n,}`: n or more occurrences
  - `{n,m}`: Between n and m occurrences

- **Anchors**:
  - `^`: Start of string or line
  - `$`: End of string or line
  - `\b`: Word boundary
  - `\B`: Non-word boundary

- **Groups and alternation**:
  - `(pattern)`: Capturing group
  - `(?:pattern)`: Non-capturing group
  - `pattern1|pattern2`: Alternation (pattern1 OR pattern2)

### Methods for Using Regular Expressions

#### String Methods
```javascript
let text = "Hello, world! Hello, universe!";
let pattern = /Hello/g;

// test - returns boolean
pattern.test(text); // true

// exec - returns match information (iterative with 'g' flag)
let match;
while ((match = pattern.exec(text)) !== null) {
    console.log(`Found ${match[0]} at position ${match.index}`);
}

// match - returns array of matches
text.match(pattern); // ["Hello", "Hello"]

// matchAll - returns iterator of all matches (ES2020)
[...text.matchAll(pattern)]; // Array of match objects

// search - returns index of first match or -1
text.search(pattern); // 0

// replace - replace matches with replacement
text.replace(pattern, "Hi"); // "Hi, world! Hi, universe!"

// replaceAll - replace all matches (ES2021)
text.replaceAll(pattern, "Hi"); // "Hi, world! Hi, universe!"

// split - split string by pattern
"apple,orange,banana".split(/,/); // ["apple", "orange", "banana"]
```

### Common Regular Expression Patterns
```javascript
// Email validation
const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
emailPattern.test("user@example.com"); // true

// URL validation
const urlPattern = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;
urlPattern.test("https://example.com"); // true

// US phone number validation
const phonePattern = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;
phonePattern.test("(123) 456-7890"); // true

// Password strength (at least 8 characters, one uppercase, one lowercase, one number)
const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
passwordPattern.test("Passw0rd"); // true

// Date validation (MM/DD/YYYY)
const datePattern = /^(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/\d{4}$/;
datePattern.test("01/01/2023"); // true
```

## 19. Client-Side Validations

### Types of Validation
- **Format validation**: Ensure data matches expected format (e.g., email, phone number)
- **Range validation**: Check if numeric values are within valid ranges
- **Presence validation**: Ensure required fields are filled
- **Confirmation validation**: Verify two fields match (e.g., password confirmation)
- **Custom validation**: Application-specific rules

### Implementing Form Validation

#### Basic Required Field Validation
```javascript
function validateForm() {
    let name = document.getElementById("name").value;
    let email = document.getElementById("email").value;
    let isValid = true;
    
    // Check required fields
    if (name.trim() === "") {
        document.getElementById("nameError").textContent = "Name is required";
        isValid = false;
    } else {
        document.getElementById("nameError").textContent = "";
    }
    
    if (email.trim() === "") {
        document.getElementById("emailError").textContent = "Email is required";
        isValid = false;
    } else {
        document.getElementById("emailError").textContent = "";
    }
    
    return isValid;
}

// Attach to form
document.getElementById("myForm").onsubmit = function(event) {
    if (!validateForm()) {
        event.preventDefault();
    }
};
```

#### Email Validation
```javascript
function validateEmail(email) {
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailPattern.test(email);
}

document.getElementById("email").addEventListener("blur", function() {
    if (this.value.trim() !== "" && !validateEmail(this.value)) {
        document.getElementById("emailError").textContent = "Please enter a valid email address";
    } else {
        document.getElementById("emailError").textContent = "";
    }
});
```

#### Password Strength Validation
```javascript
function checkPasswordStrength(password) {
    // Check length
    if (password.length < 8) {
        return "Password must be at least 8 characters long";
    }
    
    // Check for uppercase
    if (!/[A-Z]/.test(password)) {
        return "Password must contain at least one uppercase letter";
    }
    
    // Check for lowercase
    if (!/[a-z]/.test(password)) {
        return "Password must contain at least one lowercase letter";
    }
    
    // Check for number
    if (!/[0-9]/.test(password)) {
        return "Password must contain at least one number";
    }
    
    // Check for special character
    if (!/[^A-Za-z0-9]/.test(password)) {
        return "Password must contain at least one special character";
    }
    
    return ""; // Valid password
}

document.getElementById("password").addEventListener("input", function() {
    const error = checkPasswordStrength(this.value);
    document.getElementById("passwordError").textContent = error;
    
    // Visual strength indicator
    const strengthIndicator = document.getElementById("strengthIndicator");
    if (error === "") {
        strengthIndicator.className = "strong";
        strengthIndicator.textContent = "Strong";
    } else if (this.value.length >= 8 && /[A-Z]/.test(this.value) && /[a-z]/.test(this.value)) {
        strengthIndicator.className = "medium";
        strengthIndicator.textContent = "Medium";
    } else if (this.value.length > 0) {
        strengthIndicator.className = "weak";
        strengthIndicator.textContent = "Weak";
    } else {
        strengthIndicator.className = "";
        strengthIndicator.textContent = "";
    }
});
```

#### Password Confirmation Validation
```javascript
function validatePasswordMatch() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    
    if (confirmPassword !== password) {
        document.getElementById("confirmPasswordError").textContent = "Passwords do not match";
        return false;
    } else {
        document.getElementById("confirmPasswordError").textContent = "";
        return true;
    }
}

document.getElementById("confirmPassword").addEventListener("input", validatePasswordMatch);
```

#### Real-time Validation
```javascript
// Validate on input events
const inputs = document.querySelectorAll("input, select, textarea");
inputs.forEach(input => {
    input.addEventListener("input", function() {
        // Clear error when user starts typing
        const errorElement = document.getElementById(this.id + "Error");
        if (errorElement) {
            errorElement.textContent = "";
        }
    });
    
    input.addEventListener("blur", function() {
        // Validate when input loses focus
        validateField(this);
    });
});

function validateField(field) {
    const errorElement = document.getElementById(field.id + "Error");
    if (!errorElement) return;
    
    // Required field check
    if (field.required && field.value.trim() === "") {
        errorElement.textContent = "This field is required";
        return false;
    }
    
    // Type-specific validation
    switch (field.type) {
        case "email":
            if (field.value && !validateEmail(field.value)) {
                errorElement.textContent = "Please enter a valid email address";
                return false;
            }
            break;
            
        case "tel":
            if (field.value && !/^\d{10}$/.test(field.value.replace(/[^0-9]/g, ''))) {
                errorElement.textContent = "Please enter a valid 10-digit phone number";
                return false;
            }
            break;
            
        // Add more cases as needed
    }
    
    return true;
}
```

#### HTML5 Form Validation
```html
<form id="myForm" novalidate>
    <div>
        <label for="name">Name:</label>
        <input 
            type="text" 
            id="name" 
            name="name" 
            required 
            minlength="2" 
            maxlength="50">
        <span class="error" id="nameError"></span>
    </div>
    
    <div>
        <label for="email">Email:</label>
        <input 
            type="email" 
            id="email" 
            name="email" 
            required>
        <span class="error" id="emailError"></span>
    </div>
    
    <div>
        <label for="age">Age:</label>
        <input 
            type="number" 
            id="age" 
            name="age" 
            min="18" 
            max="120">
        <span class="error" id="ageError"></span>
    </div>
    
    <button type="submit">Submit</button>
</form>
```

```javascript
// Using HTML5 Constraint Validation API
document.getElementById("myForm").addEventListener("submit", function(event) {
    const form = this;
    
    if (!form.checkValidity()) {
        event.preventDefault();
        
        // Display custom error messages
        Array.from(form.elements).forEach(field => {
            const errorElement = document.getElementById(field.id + "Error");
            if (!errorElement) return;
            
            if (!field.validity.valid) {
                if (field.validity.valueMissing) {
                    errorElement.textContent = "This field is required";
                } else if (field.validity.typeMismatch) {
                    errorElement.textContent = `Please enter a valid ${field.type}`;
                } else if (field.validity.tooShort) {
                    errorElement.textContent = `Minimum length is ${field.minLength} characters`;
                } else if (field.validity.tooLong) {
                    errorElement.textContent = `Maximum length is ${field.maxLength} characters`;
                } else if (field.validity.rangeUnderflow) {
                    errorElement.textContent = `Minimum value is ${field.min}`;
                } else if (field.validity.rangeOverflow) {
                    errorElement.textContent = `Maximum value is ${field.max}`;
                } else if (field.validity.patternMismatch) {
                    errorElement.textContent = "Please match the requested format";
                }
            } else {
                errorElement.textContent = "";
            }
        });
    }
});
```

### Best Practices for Form Validation
1. **Validate both client-side and server-side**: Client-side for immediate feedback, server-side for security
2. **Provide clear error messages**: Be specific about what's wrong and how to fix it
3. **Show validation errors in real-time**: Validate as users type or when fields lose focus
4. **Use appropriate input types**: `email`, `number`, `tel`, etc.
5. **Use visual cues**: Colors, icons to indicate validation state
6. **Focus on accessibility**: Ensure screen readers can announce validation errors
7. **Balance security and usability**: Don't make forms unnecessarily difficult
8. **Test thoroughly**: Test with different browsers, devices, and assistive technologies

## 20. Additional Resources and Practice

### Coding Exercises
- Create a simple to-do list application
- Build a calculator with basic operations
- Develop a form with comprehensive validation
- Design an image gallery with navigation
- Implement a countdown timer
- Create an interactive quiz application

### JavaScript Style Guides
- **Airbnb JavaScript Style Guide**
  - https://github.com/airbnb/javascript
- **Google JavaScript Style Guide**
  - https://google.github.io/styleguide/jsguide.html
- **StandardJS**
  - https://standardjs.com/