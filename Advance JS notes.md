# Advanced Functions & Scope in JavaScript

## 1. Function Expressions vs Declarations

### Function Declarations
Function declarations are hoisted, meaning they can be called before they are defined in the code.

```javascript
// Function Declaration
function greet(name) {
    return "Hello, " + name + "!";
}

// Can be called before declaration due to hoisting
console.log(sayHello("World")); // Works!

function sayHello(name) {
    return "Hello, " + name + "!";
}

// Characteristics of Function Declarations:
// 1. Hoisted completely
// 2. Creates a binding in the enclosing scope
// 3. Can be called before definition
```

### Function Expressions
Function expressions are not hoisted and must be defined before use.

```javascript
// Function Expression
const greet = function(name) {
    return "Hello, " + name + "!";
};

// Named Function Expression
const greet2 = function greetFunction(name) {
    return "Hello, " + name + "!";
    // greetFunction is only available inside this function
};

// Anonymous Function Expression
const greet3 = function(name) {
    return "Hello, " + name + "!";
};

// This will cause an error - cannot call before definition
// console.log(sayGoodbye("World")); // Error!

const sayGoodbye = function(name) {
    return "Goodbye, " + name + "!";
};

// Conditional Function Creation
let condition = true;
let myFunction;

if (condition) {
    myFunction = function() {
        return "Condition is true";
    };
} else {
    myFunction = function() {
        return "Condition is false";
    };
}

console.log(myFunction()); // "Condition is true"
```

### Key Differences
```javascript
// Hoisting Behavior
console.log(typeof declaredFunction); // "function"
console.log(typeof expressedFunction); // "undefined"

function declaredFunction() {
    return "I'm hoisted!";
}

var expressedFunction = function() {
    return "I'm not hoisted!";
};

// Block Scope Behavior
if (true) {
    function blockDeclaration() {
        return "Block function";
    }
    
    const blockExpression = function() {
        return "Block expression";
    };
}

// blockDeclaration might be accessible (depends on environment)
// blockExpression is not accessible outside the block
```

## 2. Arrow Functions and Lexical Scope

### Basic Arrow Function Syntax
```javascript
// Traditional function
const add = function(a, b) {
    return a + b;
};

// Arrow function
const addArrow = (a, b) => {
    return a + b;
};

// Concise arrow function (implicit return)
const addConcise = (a, b) => a + b;

// Single parameter (parentheses optional)
const square = x => x * x;

// No parameters
const getRandom = () => Math.random();

// Multiple statements
const processData = (data) => {
    const processed = data.map(item => item * 2);
    const sum = processed.reduce((acc, val) => acc + val, 0);
    return sum;
};

// Returning object literals (wrap in parentheses)
const createUser = (name, age) => ({
    name: name,
    age: age,
    greeting: function() {
        return `Hello, I'm ${this.name}`;
    }
});
```

### Lexical Scope and 'this' Binding
```javascript
// Traditional function - 'this' is dynamic
const traditionalObject = {
    name: "Traditional",
    hobbies: ["reading", "swimming"],
    
    showHobbies: function() {
        console.log(this.name + "'s hobbies:");
        
        // Problem: 'this' changes in callback
        this.hobbies.forEach(function(hobby) {
            // 'this' is undefined or global object here
            console.log(this.name + " likes " + hobby); // Error!
        });
    },
    
    showHobbiesFixed: function() {
        console.log(this.name + "'s hobbies:");
        const self = this; // Store reference
        
        this.hobbies.forEach(function(hobby) {
            console.log(self.name + " likes " + hobby); // Works!
        });
    }
};

// Arrow function - 'this' is lexical
const arrowObject = {
    name: "Arrow",
    hobbies: ["reading", "swimming"],
    
    showHobbies: function() {
        console.log(this.name + "'s hobbies:");
        
        // Arrow function inherits 'this' from enclosing scope
        this.hobbies.forEach((hobby) => {
            console.log(this.name + " likes " + hobby); // Works!
        });
    }
};

// Practical example with event handlers
class Button {
    constructor(element) {
        this.element = element;
        this.clickCount = 0;
        
        // Arrow function preserves 'this'
        this.element.addEventListener('click', () => {
            this.clickCount++;
            console.log(`Clicked ${this.clickCount} times`);
        });
    }
    
    // This won't work as expected
    badHandler() {
        this.element.addEventListener('click', function() {
            this.clickCount++; // 'this' refers to the element, not the Button instance
            console.log(`Clicked ${this.clickCount} times`);
        });
    }
}

// When NOT to use arrow functions
const calculator = {
    value: 0,
    
    // Don't use arrow function for methods
    add: (num) => {
        this.value += num; // 'this' doesn't refer to calculator
        return this;
    },
    
    // Use regular function for methods
    subtract: function(num) {
        this.value -= num;
        return this;
    }
};
```

### Arrow Functions in Array Methods
```javascript
const numbers = [1, 2, 3, 4, 5];

// Map with arrow functions
const doubled = numbers.map(n => n * 2);
console.log(doubled); // [2, 4, 6, 8, 10]

// Filter with arrow functions
const evens = numbers.filter(n => n % 2 === 0);
console.log(evens); // [2, 4]

// Reduce with arrow functions
const sum = numbers.reduce((acc, n) => acc + n, 0);
console.log(sum); // 15

// Complex data processing
const users = [
    { name: "Alice", age: 30, active: true },
    { name: "Bob", age: 25, active: false },
    { name: "Charlie", age: 35, active: true }
];

const activeUserNames = users
    .filter(user => user.active)
    .map(user => user.name)
    .sort();

console.log(activeUserNames); // ["Alice", "Charlie"]
```

## 3. Higher-Order Functions

### Functions that Take Functions as Arguments
```javascript
// Basic higher-order function
function applyOperation(arr, operation) {
    const result = [];
    for (let i = 0; i < arr.length; i++) {
        result.push(operation(arr[i]));
    }
    return result;
}

const numbers = [1, 2, 3, 4, 5];

// Using different operations
const squared = applyOperation(numbers, x => x * x);
const doubled = applyOperation(numbers, x => x * 2);
const negated = applyOperation(numbers, x => -x);

console.log(squared); // [1, 4, 9, 16, 25]
console.log(doubled); // [2, 4, 6, 8, 10]
console.log(negated); // [-1, -2, -3, -4, -5]

// More complex example: custom forEach
function customForEach(array, callback) {
    for (let i = 0; i < array.length; i++) {
        callback(array[i], i, array);
    }
}

customForEach([1, 2, 3], (value, index) => {
    console.log(`Index ${index}: ${value}`);
});

// Function composition
function compose(f, g) {
    return function(x) {
        return f(g(x));
    };
}

const addOne = x => x + 1;
const multiplyByTwo = x => x * 2;

const addOneThenDouble = compose(multiplyByTwo, addOne);
console.log(addOneThenDouble(3)); // 8 (3 + 1 = 4, 4 * 2 = 8)

// Pipe function (left to right composition)
function pipe(...functions) {
    return function(value) {
        return functions.reduce((acc, fn) => fn(acc), value);
    };
}

const transform = pipe(
    x => x + 1,
    x => x * 2,
    x => x - 3
);

console.log(transform(5)); // 9 (5 + 1 = 6, 6 * 2 = 12, 12 - 3 = 9)
```

### Functions that Return Functions
```javascript
// Function factory
function createMultiplier(multiplier) {
    return function(x) {
        return x * multiplier;
    };
}

const double = createMultiplier(2);
const triple = createMultiplier(3);

console.log(double(5)); // 10
console.log(triple(5)); // 15

// Configurable validators
function createValidator(rule) {
    return function(value) {
        return rule(value);
    };
}

const isEmail = createValidator(email => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email));
const isMinLength = (minLength) => createValidator(str => str.length >= minLength);
const isNumeric = createValidator(value => !isNaN(value) && !isNaN(parseFloat(value)));

console.log(isEmail("test@example.com")); // true
console.log(isMinLength(8)("password123")); // true
console.log(isNumeric("42")); // true

// Partial application
function multiply(a, b, c) {
    return a * b * c;
}

function partial(fn, ...argsToApply) {
    return function(...remainingArgs) {
        return fn(...argsToApply, ...remainingArgs);
    };
}

const multiplyByTwo = partial(multiply, 2);
const multiplyByTwoAndThree = partial(multiply, 2, 3);

console.log(multiplyByTwo(3, 4)); // 24 (2 * 3 * 4)
console.log(multiplyByTwoAndThree(5)); // 30 (2 * 3 * 5)

// Event handler factory
function createEventHandler(action) {
    return function(event) {
        console.log(`Performing action: ${action}`);
        console.log(`Event type: ${event.type}`);
        console.log(`Target: ${event.target.tagName}`);
    };
}

// Usage in DOM
// document.getElementById('saveBtn').addEventListener('click', createEventHandler('save'));
// document.getElementById('deleteBtn').addEventListener('click', createEventHandler('delete'));
```

## 4. Callbacks and Callback Patterns

### Basic Callback Pattern
```javascript
// Synchronous callback
function processData(data, callback) {
    const processed = data.map(item => item.toUpperCase());
    callback(processed);
}

processData(['hello', 'world'], function(result) {
    console.log(result); // ['HELLO', 'WORLD']
});

// Asynchronous callback
function fetchData(callback) {
    setTimeout(() => {
        const data = { id: 1, name: "John Doe" };
        callback(data);
    }, 1000);
}

fetchData(function(data) {
    console.log("Received data:", data);
});

// Error-first callback pattern (Node.js style)
function readFile(filename, callback) {
    setTimeout(() => {
        if (filename === 'error.txt') {
            callback(new Error('File not found'), null);
        } else {
            callback(null, 'File content here');
        }
    }, 500);
}

readFile('data.txt', function(err, data) {
    if (err) {
        console.error('Error:', err.message);
    } else {
        console.log('File content:', data);
    }
});
```

### Advanced Callback Patterns
```javascript
// Multiple callbacks for different events
function createUser(userData, callbacks) {
    // Simulate validation
    if (!userData.email) {
        callbacks.onError(new Error('Email is required'));
        return;
    }
    
    callbacks.onProgress('Validating user data...');
    
    setTimeout(() => {
        callbacks.onProgress('Creating user...');
        
        setTimeout(() => {
            const user = { id: Date.now(), ...userData };
            callbacks.onSuccess(user);
        }, 1000);
    }, 500);
}

createUser(
    { name: 'John', email: 'john@example.com' },
    {
        onProgress: (message) => console.log('Progress:', message),
        onSuccess: (user) => console.log('User created:', user),
        onError: (error) => console.error('Error:', error.message)
    }
);

// Callback with configuration
function apiRequest(url, options, callback) {
    const defaultOptions = {
        method: 'GET',
        timeout: 5000,
        retries: 3
    };
    
    const config = { ...defaultOptions, ...options };
    
    // Simulate API request
    setTimeout(() => {
        if (url.includes('error')) {
            callback(new Error('API Error'), null);
        } else {
            callback(null, { status: 'success', data: 'API response' });
        }
    }, config.timeout);
}

apiRequest('/api/users', { method: 'POST' }, function(err, response) {
    if (err) {
        console.error('Request failed:', err.message);
    } else {
        console.log('Response:', response);
    }
});

// Callback hell example and solution
// BAD: Callback hell
function getUserData(userId, callback) {
    fetchUser(userId, function(err, user) {
        if (err) return callback(err);
        
        fetchUserPosts(user.id, function(err, posts) {
            if (err) return callback(err);
            
            fetchPostComments(posts[0].id, function(err, comments) {
                if (err) return callback(err);
                
                callback(null, { user, posts, comments });
            });
        });
    });
}

// BETTER: Named functions to avoid callback hell
function handleUserFetch(userId, callback) {
    fetchUser(userId, (err, user) => {
        if (err) return callback(err);
        handlePostsFetch(user, callback);
    });
}

function handlePostsFetch(user, callback) {
    fetchUserPosts(user.id, (err, posts) => {
        if (err) return callback(err);
        handleCommentsFetch(user, posts, callback);
    });
}

function handleCommentsFetch(user, posts, callback) {
    fetchPostComments(posts[0].id, (err, comments) => {
        if (err) return callback(err);
        callback(null, { user, posts, comments });
    });
}

function getUserDataBetter(userId, callback) {
    handleUserFetch(userId, callback);
}
```

### Practical Callback Examples
```javascript
// Custom event emitter using callbacks
class EventEmitter {
    constructor() {
        this.events = {};
    }
    
    on(event, callback) {
        if (!this.events[event]) {
            this.events[event] = [];
        }
        this.events[event].push(callback);
    }
    
    emit(event, data) {
        if (this.events[event]) {
            this.events[event].forEach(callback => callback(data));
        }
    }
    
    off(event, callbackToRemove) {
        if (this.events[event]) {
            this.events[event] = this.events[event].filter(
                callback => callback !== callbackToRemove
            );
        }
    }
}

// Usage
const emitter = new EventEmitter();

const userLoginHandler = (user) => console.log(`User ${user.name} logged in`);
const analyticsHandler = (user) => console.log(`Track login for ${user.id}`);

emitter.on('userLogin', userLoginHandler);
emitter.on('userLogin', analyticsHandler);

emitter.emit('userLogin', { id: 1, name: 'John' });
// Output: User John logged in
//         Track login for 1

// Form validation with callbacks
function validateForm(formData, validationRules, callbacks) {
    const errors = [];
    let validatedFields = 0;
    const totalFields = Object.keys(validationRules).length;
    
    Object.keys(validationRules).forEach(field => {
        const value = formData[field];
        const rules = validationRules[field];
        
        // Simulate async validation
        setTimeout(() => {
            rules.forEach(rule => {
                if (!rule.validator(value)) {
                    errors.push({ field, message: rule.message });
                }
            });
            
            validatedFields++;
            
            if (callbacks.onProgress) {
                callbacks.onProgress({
                    completed: validatedFields,
                    total: totalFields,
                    percentage: Math.round((validatedFields / totalFields) * 100)
                });
            }
            
            if (validatedFields === totalFields) {
                if (errors.length > 0) {
                    callbacks.onError(errors);
                } else {
                    callbacks.onSuccess(formData);
                }
            }
        }, Math.random() * 1000); // Random delay to simulate network validation
    });
}

// Usage
const formData = {
    email: 'john@example.com',
    password: '123456',
    confirmPassword: '123456'
};

const validationRules = {
    email: [
        { validator: email => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email), message: 'Invalid email format' }
    ],
    password: [
        { validator: pwd => pwd.length >= 8, message: 'Password must be at least 8 characters' }
    ],
    confirmPassword: [
        { validator: confirm => confirm === formData.password, message: 'Passwords do not match' }
    ]
};

validateForm(formData, validationRules, {
    onProgress: (progress) => console.log(`Validation progress: ${progress.percentage}%`),
    onSuccess: (data) => console.log('Form is valid:', data),
    onError: (errors) => console.log('Validation errors:', errors)
});
```

## 5. Function Binding (call, apply, bind)

### Understanding 'this' Context
```javascript
const person = {
    name: 'John',
    age: 30,
    greet: function() {
        console.log(`Hello, I'm ${this.name} and I'm ${this.age} years old`);
    }
};

person.greet(); // "Hello, I'm John and I'm 30 years old"

// Problem: Lost context
const greetFunction = person.greet;
greetFunction(); // "Hello, I'm undefined and I'm undefined years old"

// Context depends on how function is called
function showThis() {
    console.log(this);
}

showThis(); // Window object (in browser) or global object (in Node.js)
const obj = { showThis };
obj.showThis(); // obj object
```

### Function.prototype.call()
```javascript
// call() - immediately invokes function with specified 'this' and arguments
function greet(greeting, punctuation) {
    console.log(`${greeting}, I'm ${this.name}${punctuation}`);
}

const person1 = { name: 'Alice' };
const person2 = { name: 'Bob' };

// Using call to set 'this' context
greet.call(person1, 'Hello', '!'); // "Hello, I'm Alice!"
greet.call(person2, 'Hi', '.'); // "Hi, I'm Bob."

// Borrowing methods
const array1 = [1, 2, 3];
const array2 = [4, 5, 6];

// Borrow push method
Array.prototype.push.call(array1, 4);
console.log(array1); // [1, 2, 3, 4]

// Convert array-like objects to arrays
function convertArguments() {
    const argsArray = Array.prototype.slice.call(arguments);
    console.log(argsArray);
    return argsArray;
}

convertArguments(1, 2, 3, 4); // [1, 2, 3, 4]

// Finding max in array using Math.max
const numbers = [1, 5, 3, 9, 2];
const max = Math.max.call(null, ...numbers);
console.log(max); // 9

// Real-world example: Form validation
function validateField(value) {
    if (this.required && !value) {
        return `${this.name} is required`;
    }
    if (this.minLength && value.length < this.minLength) {
        return `${this.name} must be at least ${this.minLength} characters`;
    }
    return null;
}

const emailField = {
    name: 'Email',
    required: true,
    minLength: 5
};

const passwordField = {
    name: 'Password',
    required: true,
    minLength: 8
};

console.log(validateField.call(emailField, 'john@example.com')); // null (valid)
console.log(validateField.call(passwordField, '123')); // "Password must be at least 8 characters"
```

### Function.prototype.apply()
```javascript
// apply() - like call() but takes arguments as an array
function introduce(greeting, occupation, hobby) {
    console.log(`${greeting}! I'm ${this.name}, a ${occupation} who loves ${hobby}.`);
}

const person = { name: 'Sarah' };
const args = ['Hello', 'developer', 'coding'];

introduce.apply(person, args); // "Hello! I'm Sarah, a developer who loves coding."

// Practical use: Finding min/max in arrays
const numbers = [10, 5, 8, 3, 15, 2];
const max = Math.max.apply(null, numbers);
const min = Math.min.apply(null, numbers);

console.log(`Max: ${max}, Min: ${min}`); // Max: 15, Min: 2

// Concatenating arrays (before spread operator)
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];

Array.prototype.push.apply(arr1, arr2);
console.log(arr1); // [1, 2, 3, 4, 5, 6]

// Function that accepts variable arguments
function sum() {
    const args = Array.prototype.slice.call(arguments);
    return args.reduce((total, num) => total + num, 0);
}

const numbersToSum = [1, 2, 3, 4, 5];
const total = sum.apply(null, numbersToSum);
console.log(total); // 15

// Creating a reusable logger
function log(level, message) {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] ${level.toUpperCase()}: ${message} - ${this.module}`);
}

const authModule = { module: 'AUTH' };
const dbModule = { module: 'DATABASE' };

log.apply(authModule, ['info', 'User logged in']);
log.apply(dbModule, ['error', 'Connection failed']);
```

### Function.prototype.bind()
```javascript
// bind() - creates a new function with bound 'this' context
function greet() {
    console.log(`Hello from ${this.name}`);
}

const person = { name: 'Charlie' };

// bind() returns a new function
const boundGreet = greet.bind(person);
boundGreet(); // "Hello from Charlie"

// Partial application with bind()
function multiply(a, b, c) {
    return a * b * c;
}

const multiplyByTwo = multiply.bind(null, 2);
const multiplyByTwoAndThree = multiply.bind(null, 2, 3);

console.log(multiplyByTwo(3, 4)); // 24 (2 * 3 * 4)
console.log(multiplyByTwoAndThree(5)); // 30 (2 * 3 * 5)

// Event handlers with proper context
class Timer {
    constructor(duration) {
        this.duration = duration;
        this.timeLeft = duration;
        this.isRunning = false;
    }
    
    start() {
        if (this.isRunning) return;
        
        this.isRunning = true;
        console.log(`Timer started for ${this.duration} seconds`);
        
        // bind() ensures 'this' refers to Timer instance
        this.intervalId = setInterval(this.tick.bind(this), 1000);
    }
    
    tick() {
        this.timeLeft--;
        console.log(`Time left: ${this.timeLeft}`);
        
        if (this.timeLeft <= 0) {
            this.stop();
        }
    }
    
    stop() {
        if (!this.isRunning) return;
        
        clearInterval(this.intervalId);
        this.isRunning = false;
        console.log('Timer stopped!');
    }
}

const timer = new Timer(5);
timer.start();

// Button click handler with context
class Counter {
    constructor() {
        this.count = 0;
        this.element = document.createElement('button');
        this.element.textContent = 'Click me: 0';
        
        // bind() preserves 'this' context
        this.element.addEventListener('click', this.increment.bind(this));
    }
    
    increment() {
        this.count++;
        this.element.textContent = `Click me: ${this.count}`;
        console.log(`Count is now: ${this.count}`);
    }
    
    getElement() {
        return this.element;
    }
}

// React-style event handling
class Component {
    constructor(props) {
        this.state = { value: props.initialValue || 0 };
        
        // Bind methods in constructor
        this.handleClick = this.handleClick.bind(this);
        this.handleChange = this.handleChange.bind(this);
    }
    
    handleClick(event) {
        console.log('Button clicked', this.state);
        this.setState({ value: this.state.value + 1 });
    }
    
    handleChange(event) {
        this.setState({ value: parseInt(event.target.value) || 0 });
    }
    
    setState(newState) {
        this.state = { ...this.state, ...newState };
        this.render();
    }
    
    render() {
        console.log('Rendering with state:', this.state);
    }
}

// Creating bound versions of utility functions
const utils = {
    prefix: '[UTILS]',
    
    log: function(message) {
        console.log(`${this.prefix} ${message}`);
    },
    
    warn: function(message) {
        console.warn(`${this.prefix} WARNING: ${message}`);
    },
    
    error: function(message) {
        console.error(`${this.prefix} ERROR: ${message}`);
    }
};

// Create bound versions for easier use
const log = utils.log.bind(utils);
const warn = utils.warn.bind(utils);
const error = utils.error.bind(utils);

log('This is a log message');
warn('This is a warning');
error('This is an error');
```

### Practical Examples and Use Cases
```javascript
// Configuration object with bound methods
function createAPI(baseURL, apiKey) {
    const api = {
        baseURL,
        apiKey,
        
        request: function(endpoint, options = {}) {
            const url = `${this.baseURL}${endpoint}`;
            const headers = {
                'Authorization': `Bearer ${this.apiKey}`,
                'Content-Type': 'application/json',
                ...options.headers
            };
            
            console.log(`Making request to ${url}`);
            // Simulate API request
            return Promise.resolve({ url, headers, ...options });
        }
    };
    
    // Return bound methods for easier use
    return {
        get: api.request.bind(api),
        post: (endpoint, data) => api.request.call(api, endpoint, { method: 'POST', body: JSON.stringify(data) }),
        put: (endpoint, data) => api.request.call(api, endpoint, { method: 'PUT', body: JSON.stringify(data) }),
        delete: api.request.bind(api, null, { method: 'DELETE' })
    };
}

const userAPI = createAPI('https://api.example.com', 'abc123');

userAPI.get('/users/1').then(response => console.log(response));
userAPI.post('/users', { name: 'John', email: 'john@example.com' });

// Method chaining with bound context
class Calculator {
    constructor(initialValue = 0) {
        this.value = initialValue;
        
        // Bind all methods to maintain context in chaining
        this.add = this.add.bind(this);
        this.subtract = this.subtract.bind(this);
        this.multiply = this.multiply.bind(this);
        this.divide = this.divide.bind(this);
    }
    
    add(num) {
        this.value += num;
        return this;
    }
    
    subtract(num) {
        this.value -= num;
        return this;
    }
    
    multiply(num) {
        this.value *= num;
        return this;
    }
    
    divide(num) {
        if (num !== 0) {
            this.value /= num;
        }
        return this;
    }
    
    getResult() {
        return this.value;
    }
}

const calc = new Calculator(10);
const result = calc.add(5).multiply(2).subtract(3).divide(2).getResult();
console.log(result); // 13.5

// Debouncing with proper context
function debounce(func, delay, context) {
    let timeoutId;
    
    return function(...args) {
        clearTimeout(timeoutId);
        
        timeoutId = setTimeout(() => {
            func.apply(context || this, args);
        }, delay);
    };
}

class SearchBox {
    constructor() {
        this.query = '';
        this.results = [];
        
        // Debounced search with bound context
        this.debouncedSearch = debounce(this.performSearch, 300, this);
    }
    
    handleInput(event) {
        this.query = event.target.value;
        this.debouncedSearch();
    }
    
    performSearch() {
        console.log(`Searching for: ${this.query}`);
        // Simulate search API call
        this.results = [`Result for "${this.query}" #1`, `Result for "${this.query}" #2`];
        this.displayResults();
    }
    
    displayResults() {
        console.log('Search results:', this.results);
    }
}

const searchBox = new SearchBox();
// searchBox.handleInput({ target: { value: 'JavaScript' } });
```

## 6. Closures and Practical Applications

### Understanding Closures
```javascript
// Basic closure example
function outerFunction(x) {
    // Outer function's variable
    
    function innerFunction(y) {
        // Inner function has access to outer function's variables
        return x + y;
    }
    
    return innerFunction;
}

const addFive = outerFunction(5);
console.log(addFive(3)); // 8

// The inner function "closes over" the variable x
// Even after outerFunction has finished executing,
// the returned function still has access to x

// More detailed example
function createCounter() {
    let count = 0; // Private variable
    
    return function() {
        count++; // Accessing outer variable
        return count;
    };
}

const counter1 = createCounter();
const counter2 = createCounter();

console.log(counter1()); // 1
console.log(counter1()); // 2
console.log(counter2()); // 1 (separate instance)
console.log(counter1()); // 3

// Lexical scoping demonstration
function init() {
    var name = 'Mozilla'; // Local variable created by init
    
    function displayName() { // Inner function, a closure
        console.log(name); // Uses variable declared in the parent function
    }
    
    displayName();
}

init(); // "Mozilla"

// Multiple nested closures
function a(x) {
    return function b(y) {
        return function c(z) {
            return x + y + z;
        };
    };
}

const result = a(1)(2)(3);
console.log(result); // 6

// Closure with loop - common pitfall and solution
// PROBLEM: All functions reference the same variable
console.log("Problem with var in loops:");
for (var i = 0; i < 3; i++) {
    setTimeout(function() {
        console.log(i); // Prints 3, 3, 3
    }, 100);
}

// SOLUTION 1: Use let instead of var
console.log("Solution 1 - let:");
for (let i = 0; i < 3; i++) {
    setTimeout(function() {
        console.log(i); // Prints 0, 1, 2
    }, 200);
}

// SOLUTION 2: Use closure to capture the value
console.log("Solution 2 - closure:");
for (var i = 0; i < 3; i++) {
    (function(index) {
        setTimeout(function() {
            console.log(index); // Prints 0, 1, 2
        }, 300);
    })(i);
}

// SOLUTION 3: Function that returns a closure
function createTimeoutFunction(index) {
    return function() {
        console.log(index);
    };
}

console.log("Solution 3 - function factory:");
for (var i = 0; i < 3; i++) {
    setTimeout(createTimeoutFunction(i), 400);
}
```

### Practical Applications of Closures

#### 1. Data Privacy and Encapsulation
```javascript
// Module pattern using closures
const UserModule = (function() {
    // Private variables
    let users = [];
    let currentId = 1;
    
    // Private functions
    function validateUser(user) {
        return user.name && user.email && user.email.includes('@');
    }
    
    function generateId() {
        return currentId++;
    }
    
    // Public interface
    return {
        addUser: function(name, email) {
            const user = { name, email };
            
            if (validateUser(user)) {
                user.id = generateId();
                users.push(user);
                return user;
            } else {
                throw new Error('Invalid user data');
            }
        },
        
        getUser: function(id) {
            return users.find(user => user.id === id);
        },
        
        getAllUsers: function() {
            // Return a copy to prevent external modification
            return users.map(user => ({ ...user }));
        },
        
        getUserCount: function() {
            return users.length;
        },
        
        removeUser: function(id) {
            const index = users.findIndex(user => user.id === id);
            if (index !== -1) {
                return users.splice(index, 1)[0];
            }
            return null;
        }
    };
})();

// Usage
const user1 = UserModule.addUser('John Doe', 'john@example.com');
const user2 = UserModule.addUser('Jane Smith', 'jane@example.com');

console.log(UserModule.getAllUsers());
console.log(UserModule.getUserCount()); // 2

// Private variables are inaccessible
// console.log(users); // ReferenceError: users is not defined

// Factory pattern with closures
function createBankAccount(initialBalance = 0) {
    let balance = initialBalance;
    let transactionHistory = [];
    
    function addTransaction(type, amount) {
        transactionHistory.push({
            type,
            amount,
            date: new Date(),
            balance: balance
        });
    }
    
    return {
        deposit: function(amount) {
            if (amount > 0) {
                balance += amount;
                addTransaction('deposit', amount);
                return balance;
            }
            throw new Error('Deposit amount must be positive');
        },
        
        withdraw: function(amount) {
            if (amount > 0 && amount <= balance) {
                balance -= amount;
                addTransaction('withdrawal', amount);
                return balance;
            }
            throw new Error('Invalid withdrawal amount');
        },
        
        getBalance: function() {
            return balance;
        },
        
        getTransactionHistory: function() {
            return [...transactionHistory]; // Return copy
        },
        
        // Method that shows closure accessing multiple private variables
        getAccountSummary: function() {
            return {
                currentBalance: balance,
                totalTransactions: transactionHistory.length,
                lastTransaction: transactionHistory[transactionHistory.length - 1] || null
            };
        }
    };
}

const account = createBankAccount(1000);
account.deposit(500);
account.withdraw(200);
console.log(account.getAccountSummary());
// { currentBalance: 1300, totalTransactions: 2, lastTransaction: {...} }
```

#### 2. Function Factories and Configuration
```javascript
// Configuration function using closures
function createAPIClient(baseURL, defaultHeaders = {}) {
    // These variables are "captured" by the returned functions
    const config = {
        baseURL,
        defaultHeaders,
        timeout: 5000
    };
    
    function makeRequest(endpoint, options = {}) {
        const url = `${config.baseURL}${endpoint}`;
        const headers = { ...config.defaultHeaders, ...options.headers };
        
        console.log(`Making ${options.method || 'GET'} request to ${url}`);
        console.log('Headers:', headers);
        
        // Simulate API request
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve({
                    url,
                    headers,
                    data: options.body || null
                });
            }, 100);
        });
    }
    
    return {
        get: function(endpoint, headers = {}) {
            return makeRequest(endpoint, { method: 'GET', headers });
        },
        
        post: function(endpoint, data, headers = {}) {
            return makeRequest(endpoint, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', ...headers },
                body: JSON.stringify(data)
            });
        },
        
        put: function(endpoint, data, headers = {}) {
            return makeRequest(endpoint, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json', ...headers },
                body: JSON.stringify(data)
            });
        },
        
        delete: function(endpoint, headers = {}) {
            return makeRequest(endpoint, { method: 'DELETE', headers });
        },
        
        // Method to update configuration
        updateConfig: function(newConfig) {
            Object.assign(config, newConfig);
        },
        
        getConfig: function() {
            return { ...config }; // Return copy
        }
    };
}

// Usage
const apiClient = createAPIClient('https://api.example.com', {
    'Authorization': 'Bearer token123',
    'User-Agent': 'MyApp/1.0'
});

apiClient.get('/users/1');
apiClient.post('/users', { name: 'John', email: 'john@example.com' });

// Validator factory using closures
function createValidator(rules) {
    // Rules are captured in closure
    return function(data) {
        const errors = [];
        
        for (const field in rules) {
            const value = data[field];
            const fieldRules = rules[field];
            
            for (const rule of fieldRules) {
                if (!rule.test(value)) {
                    errors.push({
                        field,
                        message: rule.message,
                        value
                    });
                }
            }
        }
        
        return {
            isValid: errors.length === 0,
            errors
        };
    };
}

// Create specific validators
const userValidator = createValidator({
    name: [
        { test: val => val && val.length >= 2, message: 'Name must be at least 2 characters' },
        { test: val => val && val.length <= 50, message: 'Name must be less than 50 characters' }
    ],
    email: [
        { test: val => val && val.includes('@'), message: 'Email must contain @' },
        { test: val => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val), message: 'Invalid email format' }
    ],
    age: [
        { test: val => val >= 18, message: 'Must be at least 18 years old' },
        { test: val => val <= 120, message: 'Age must be realistic' }
    ]
});

const productValidator = createValidator({
    name: [
        { test: val => val && val.length >= 1, message: 'Product name is required' }
    ],
    price: [
        { test: val => val > 0, message: 'Price must be positive' },
        { test: val => val < 10000, message: 'Price must be reasonable' }
    ]
});

// Usage
const userResult = userValidator({
    name: 'John',
    email: 'john@example.com',
    age: 25
});

const productResult = productValidator({
    name: 'Widget',
    price: -5
});

console.log(userResult); // { isValid: true, errors: [] }
console.log(productResult); // { isValid: false, errors: [...] }
```

#### 3. Event Handling and Callbacks
```javascript
// Event handler factory with closure
function createClickHandler(message, count = 1) {
    let clickCount = 0;
    
    return function(event) {
        clickCount++;
        console.log(`${message} - Click #${clickCount}`);
        
        if (clickCount >= count) {
            console.log('Maximum clicks reached, removing handler');
            event.target.removeEventListener('click', arguments.callee);
        }
    };
}

// Usage (in browser environment)
// const button1 = document.getElementById('btn1');
// const button2 = document.getElementById('btn2');

// button1.addEventListener('click', createClickHandler('Button 1 clicked', 3));
// button2.addEventListener('click', createClickHandler('Button 2 clicked', 5));

// Debounce function using closure
function debounce(func, delay) {
    let timeoutId;
    
    return function(...args) {
        // Clear previous timeout
        clearTimeout(timeoutId);
        
        // Set new timeout
        timeoutId = setTimeout(() => {
            func.apply(this, args);
        }, delay);
    };
}

// Throttle function using closure
function throttle(func, delay) {
    let lastCall = 0;
    
    return function(...args) {
        const now = Date.now();
        
        if (now - lastCall >= delay) {
            lastCall = now;
            func.apply(this, args);
        }
    };
}

// Usage examples
const expensiveOperation = (data) => {
    console.log('Performing expensive operation with:', data);
};

const debouncedOperation = debounce(expensiveOperation, 300);
const throttledOperation = throttle(expensiveOperation, 1000);

// Simulate rapid calls
// debouncedOperation('data1'); // Will be cancelled
// debouncedOperation('data2'); // Will be cancelled  
// debouncedOperation('data3'); // Will execute after 300ms

// State management with closures
function createStore(initialState = {}) {
    let state = { ...initialState };
    let listeners = [];
    
    return {
        getState: function() {
            return { ...state }; // Return copy to prevent mutation
        },
        
        setState: function(updates) {
            const prevState = { ...state };
            state = { ...state, ...updates };
            
            // Notify all listeners
            listeners.forEach(listener => {
                listener(state, prevState);
            });
        },
        
        subscribe: function(listener) {
            listeners.push(listener);
            
            // Return unsubscribe function
            return function unsubscribe() {
                const index = listeners.indexOf(listener);
                if (index > -1) {
                    listeners.splice(index, 1);
                }
            };
        },
        
        // Advanced: Add middleware support
        dispatch: function(action) {
            if (typeof action === 'function') {
                // Thunk middleware - allow action creators
                action(this.dispatch.bind(this), this.getState.bind(this));
            } else {
                // Handle regular actions
                console.log('Dispatching action:', action);
                this.setState({ lastAction: action });
            }
        }
    };
}

// Usage
const store = createStore({ count: 0, user: null });

// Subscribe to changes
const unsubscribe = store.subscribe((newState, prevState) => {
    console.log('State changed from', prevState, 'to', newState);
});

// Update state
store.setState({ count: 1 });
store.setState({ user: { name: 'John' } });

// Action creators using closures
function createActionCreators(store) {
    return {
        increment: () => {
            const currentState = store.getState();
            store.setState({ count: currentState.count + 1 });
        },
        
        decrement: () => {
            const currentState = store.getState();
            store.setState({ count: currentState.count - 1 });
        },
        
        asyncIncrement: (delay = 1000) => {
            return (dispatch, getState) => {
                setTimeout(() => {
                    const currentState = getState();
                    dispatch({ type: 'INCREMENT_ASYNC', count: currentState.count + 1 });
                }, delay);
            };
        }
    };
}

const actions = createActionCreators(store);
actions.increment();
actions.decrement();
store.dispatch(actions.asyncIncrement(500));
```

#### 4. Memoization and Caching
```javascript
// Memoization using closures
function memoize(func) {
    const cache = new Map();
    
    return function(...args) {
        const key = JSON.stringify(args);
        
        if (cache.has(key)) {
            console.log('Cache hit for:', key);
            return cache.get(key);
        }
        
        console.log('Computing result for:', key);
        const result = func.apply(this, args);
        cache.set(key, result);
        
        return result;
    };
}

// Expensive function to memoize
function fibonacci(n) {
    if (n < 2) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

function expensiveCalculation(a, b, c) {
    // Simulate expensive operation
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
        result += (a * b * c) / (i + 1);
    }
    return result;
}

// Create memoized versions
const memoizedFib = memoize(fibonacci);
const memoizedCalc = memoize(expensiveCalculation);

// Usage
console.time('First call');
console.log(memoizedFib(40)); // Takes time to compute
console.timeEnd('First call');

console.time('Second call');
console.log(memoizedFib(40)); // Returns cached result instantly
console.timeEnd('Second call');

// Cache with TTL (Time To Live)
function memoizeWithTTL(func, ttl = 60000) { // Default 1 minute
    const cache = new Map();
    
    return function(...args) {
        const key = JSON.stringify(args);
        const now = Date.now();
        
        if (cache.has(key)) {
            const { value, timestamp } = cache.get(key);
            
            if (now - timestamp < ttl) {
                console.log('Cache hit (within TTL)');
                return value;
            } else {
                console.log('Cache expired, removing entry');
                cache.delete(key);
            }
        }
        
        console.log('Computing new result');
        const result = func.apply(this, args);
        cache.set(key, { value: result, timestamp: now });
        
        return result;
    };
}

// Usage with TTL
const cachedApiCall = memoizeWithTTL(function(endpoint) {
    console.log(`Making API call to ${endpoint}`);
    return `Response from ${endpoint}`;
}, 5000); // 5 second TTL

console.log(cachedApiCall('/users')); // Makes call
console.log(cachedApiCall('/users')); // Returns cached
setTimeout(() => {
    console.log(cachedApiCall('/users')); // Makes new call after TTL
}, 6000);
```

## 7. IIFE (Immediately Invoked Function Expressions)

### Basic IIFE Syntax
```javascript
// Basic IIFE syntax
(function() {
    console.log("This function runs immediately!");
})();

// Alternative syntax
(function() {
    console.log("This also runs immediately!");
}());

// Arrow function IIFE
(() => {
    console.log("Arrow function IIFE");
})();

// IIFE with parameters
(function(name, age) {
    console.log(`Hello ${name}, you are ${age} years old`);
})("John", 30);

// IIFE with return value
const result = (function(x, y) {
    return x + y;
})(5, 3);

console.log(result); // 8

// Named IIFE (useful for debugging)
(function myIIFE() {
    console.log("Named IIFE - easier to debug");
    // Function name is only available inside the function
})();

// Async IIFE
(async function() {
    console.log("Starting async operations...");
    
    // Simulate async operations
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    console.log("Async operations completed!");
})();
```

### Avoiding Global Pollution
```javascript
// Problem: Global namespace pollution
var userCount = 0;
var maxUsers = 100;

function addUser() {
    if (userCount < maxUsers) {
        userCount++;
        console.log("User added. Total:", userCount);
    }
}

function removeUser() {
    if (userCount > 0) {
        userCount--;
        console.log("User removed. Total:", userCount);
    }
}

// Solution: IIFE to create private scope
const UserManager = (function() {
    // Private variables
    let userCount = 0;
    let maxUsers = 100;
    
    // Private function
    function validateUserCount() {
        return userCount >= 0 && userCount <= maxUsers;
    }
    
    // Public API
    return {
        addUser: function() {
            if (userCount < maxUsers) {
                userCount++;
                console.log("User added. Total:", userCount);
                return true;
            }
            console.log("Cannot add user: maximum reached");
            return false;
        },
        
        removeUser: function() {
            if (userCount > 0) {
                userCount--;
                console.log("User removed. Total:", userCount);
                return true;
            }
            console.log("Cannot remove user: no users present");
            return false;
        },
        
        getUserCount: function() {
            return userCount;
        },
        
        getMaxUsers: function() {
            return maxUsers;
        },
        
        setMaxUsers: function(max) {
            if (max > 0 && max >= userCount) {
                maxUsers = max;
                return true;
            }
            return false;
        }
    };
})();

// Usage
UserManager.addUser(); // Works
UserManager.addUser(); // Works
console.log(UserManager.getUserCount()); // 2

// Private variables are not accessible
// console.log(userCount); // ReferenceError if the global userCount doesn't exist
```

### Module Pattern with IIFE
```javascript
// Simple module pattern
const Calculator = (function() {
    // Private variables
    let history = [];
    let precision = 2;
    
    // Private functions
    function round(number) {
        return Math.round(number * Math.pow(10, precision)) / Math.pow(10, precision);
    }
    
    function addToHistory(operation, operands, result) {
        history.push({
            operation,
            operands,
            result,
            timestamp: new Date()
        });
    }
    
    // Public interface
    return {
        add: function(a, b) {
            const result = round(a + b);
            addToHistory('addition', [a, b], result);
            return result;
        },
        
        subtract: function(a, b) {
            const result = round(a - b);
            addToHistory('subtraction', [a, b], result);
            return result;
        },
        
        multiply: function(a, b) {
            const result = round(a * b);
            addToHistory('multiplication', [a, b], result);
            return result;
        },
        
        divide: function(a, b) {
            if (b === 0) {
                throw new Error("Division by zero is not allowed");
            }
            const result = round(a / b);
            addToHistory('division', [a, b], result);
            return result;
        },
        
        getHistory: function() {
            return [...history]; // Return copy
        },
        
        clearHistory: function() {
            history = [];
        },
        
        setPrecision: function(newPrecision) {
            if (newPrecision >= 0 && newPrecision <= 10) {
                precision = newPrecision;
                return true;
            }
            return false;
        },
        
        getPrecision: function() {
            return precision;
        }
    };
})();

// Usage
console.log(Calculator.add(5, 3)); // 8
console.log(Calculator.divide(10, 3)); // 3.33
console.log(Calculator.getHistory());

// Complex module with sub-modules
const App = (function() {
    // Private app-level variables
    let isInitialized = false;
    let config = {
        debug: false,
        apiBaseUrl: 'https://api.example.com',
        version: '1.0.0'
    };
    
    // Sub-module: Logger
    const Logger = (function() {
        let logs = [];
        
        return {
            log: function(message, level = 'info') {
                const logEntry = {
                    message,
                    level,
                    timestamp: new Date().toISOString()
                };
                
                logs.push(logEntry);
                
                if (config.debug) {
                    console.log(`[${level.toUpperCase()}] ${message}`);
                }
            },
            
            getLogs: function() {
                return [...logs];
            },
            
            clearLogs: function() {
                logs = [];
            }
        };
    })();
    
    // Sub-module: API
    const API = (function() {
        function makeRequest(endpoint, options = {}) {
            const url = `${config.apiBaseUrl}${endpoint}`;
            Logger.log(`Making ${options.method || 'GET'} request to ${url}`);
            
            // Simulate API request
            return new Promise((resolve) => {
                setTimeout(() => {
                    resolve({ url, ...options });
                }, 100);
            });
        }
        
        return {
            get: function(endpoint) {
                return makeRequest(endpoint, { method: 'GET' });
            },
            
            post: function(endpoint, data) {
                return makeRequest(endpoint, { method: 'POST', body: data });
            }
        };
    })();
    
    // Main app interface
    return {
        init: function(userConfig = {}) {
            if (isInitialized) {
                Logger.log('App already initialized', 'warn');
                return false;
            }
            
            // Merge user config with defaults
            config = { ...config, ...userConfig };
            isInitialized = true;
            
            Logger.log('App initialized successfully');
            return true;
        },
        
        getConfig: function() {
            return { ...config };
        },
        
        logger: Logger,
        api: API,
        
        isReady: function() {
            return isInitialized;
        }
    };
})();

// Usage
App.init({ debug: true });
App.logger.log('Application started');
App.api.get('/users').then(response => {
    App.logger.log('Users fetched successfully');
});
```

### Configuration and Initialization
```javascript
// Library initialization with IIFE
window.MyLibrary = (function(global, document) {
    // Private configuration
    const defaults = {
        selector: '.my-widget',
        animationSpeed: 300,
        theme: 'light',
        autoInit: true
    };
    
    let config = { ...defaults };
    let initialized = false;
    let instances = [];
    
    // Private utility functions
    function extend(target, source) {
        for (let key in source) {
            if (source.hasOwnProperty(key)) {
                target[key] = source[key];
            }
        }
        return target;
    }
    
    function createElement(tag, className, content) {
        const element = document.createElement(tag);
        if (className) element.className = className;
        if (content) element.textContent = content;
        return element;
    }
    
    function findElements(selector) {
        return document.querySelectorAll(selector);
    }
    
    // Widget constructor
    function Widget(element, options) {
        this.element = element;
        this.options = extend({}, config);
        extend(this.options, options || {});
        this.init();
    }
    
    Widget.prototype.init = function() {
        this.element.classList.add('my-library-widget');
        this.render();
        this.bindEvents();
    };
    
    Widget.prototype.render = function() {
        const content = createElement('div', 'widget-content', 'Hello from MyLibrary!');
        this.element.appendChild(content);
    };
    
    Widget.prototype.bindEvents = function() {
        this.element.addEventListener('click', () => {
            console.log('Widget clicked!');
        });
    };
    
    Widget.prototype.destroy = function() {
        this.element.classList.remove('my-library-widget');
        this.element.innerHTML = '';
        
        // Remove from instances array
        const index = instances.indexOf(this);
        if (index > -1) {
            instances.splice(index, 1);
        }
    };
    
    // Public API
    return {
        init: function(options) {
            if (initialized) return this;
            
            extend(config, options || {});
            
            if (config.autoInit) {
                this.autoInit();
            }
            
            initialized = true;
            return this;
        },
        
        autoInit: function() {
            const elements = findElements(config.selector);
            elements.forEach(element => {
                instances.push(new Widget(element));
            });
            return this;
        },
        
        create: function(element, options) {
            const widget = new Widget(element, options);
            instances.push(widget);
            return widget;
        },
        
        destroyAll: function() {
            instances.forEach(instance => instance.destroy());
            instances = [];
            return this;
        },
        
        getInstances: function() {
            return [...instances];
        },
        
        version: '1.2.3'
    };
})(window, document);

// Auto-initialization
(function() {
    // Wait for DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            MyLibrary.init();
        });
    } else {
        MyLibrary.init();
    }
})();

// Feature detection and polyfills with IIFE
(function() {
    // Check for required features
    const hasLocalStorage = (function() {
        try {
            const test = 'test';
            localStorage.setItem(test, test);
            localStorage.removeItem(test);
            return true;
        } catch(e) {
            return false;
        }
    })();
    
    const hasJSON = (function() {
        return typeof JSON !== 'undefined' && 
               typeof JSON.parse === 'function' && 
               typeof JSON.stringify === 'function';
    })();
    
    // Simple polyfills
    if (!Array.prototype.forEach) {
        Array.prototype.forEach = function(callback, thisArg) {
            for (let i = 0; i < this.length; i++) {
                callback.call(thisArg, this[i], i, this);
            }
        };
    }
    
    if (!Array.prototype.map) {
        Array.prototype.map = function(callback, thisArg) {
            const result = [];
            for (let i = 0; i < this.length; i++) {
                result[i] = callback.call(thisArg, this[i], i, this);
            }
            return result;
        };
    }
    
    // Expose feature detection results
    window.FeatureSupport = {
        localStorage: hasLocalStorage,
        JSON: hasJSON
    };
})();
```

### Performance Optimization with IIFE
```javascript
// Optimized DOM operations with IIFE
const DOMOptimizer = (function() {
    // Cache frequently used elements
    const cache = new Map();
    
    // Batch DOM operations
    let pendingOperations = [];
    let rafId = null;
    
    function flushOperations() {
        pendingOperations.forEach(operation => operation());
        pendingOperations = [];
        rafId = null;
    }
    
    function scheduleOperation(operation) {
        pendingOperations.push(operation);
        
        if (!rafId) {
            rafId = requestAnimationFrame(flushOperations);
        }
    }
    
    return {
        // Cached element selection
        select: function(selector) {
            if (!cache.has(selector)) {
                cache.set(selector, document.querySelector(selector));
            }
            return cache.get(selector);
        },
        
        selectAll: function(selector) {
            if (!cache.has(selector + '_all')) {
                cache.set(selector + '_all', document.querySelectorAll(selector));
            }
            return cache.get(selector + '_all');
        },
        
        // Batched style updates
        updateStyles: function(element, styles) {
            scheduleOperation(() => {
                Object.assign(element.style, styles);
            });
        },
        
        // Batched class operations
        addClass: function(element, className) {
            scheduleOperation(() => {
                element.classList.add(className);
            });
        },
        
        removeClass: function(element, className) {
            scheduleOperation(() => {
                element.classList.remove(className);
            });
        },
        
        // Batched content updates
        updateContent: function(element, content) {
            scheduleOperation(() => {
                element.textContent = content;
            });
        },
        
        updateHTML: function(element, html) {
            scheduleOperation(() => {
                element.innerHTML = html;
            });
        },
        
        // Clear cache when needed
        clearCache: function() {
            cache.clear();
        },
        
        // Force immediate execution of pending operations
        flush: function() {
            if (rafId) {
                cancelAnimationFrame(rafId);
                flushOperations();
            }
        }
    };
})();

// Usage example
const element = DOMOptimizer.select('#myElement');
DOMOptimizer.updateStyles(element, { color: 'red', fontSize: '16px' });
DOMOptimizer.addClass(element, 'active');
DOMOptimizer.updateContent(element, 'Updated content');
// All operations will be batched and executed in the next animation frame
```

## 8. Function Currying and Partial Application

### Understanding Currying
```javascript
// Traditional function with multiple parameters
function add(a, b, c) {
    return a + b + c;
}

console.log(add(1, 2, 3)); // 6

// Curried version - returns a series of functions
function addCurried(a) {
    return function(b) {
        return function(c) {
            return a + b + c;
        };
    };
}

console.log(addCurried(1)(2)(3)); // 6

// Arrow function version (more concise)
const addCurriedArrow = a => b => c => a + b + c;

console.log(addCurriedArrow(1)(2)(3)); // 6

// Generic curry function
function curry(func) {
    return function curried(...args) {
        if (args.length >= func.length) {
            return func.apply(this, args);
        } else {
            return function(...args2) {
                return curried.apply(this, args.concat(args2));
            };
        }
    };
}

// Usage of generic curry
const multiply = (a, b, c) => a * b * c;
const curriedMultiply = curry(multiply);

console.log(curriedMultiply(2)(3)(4)); // 24
console.log(curriedMultiply(2, 3)(4)); // 24
console.log(curriedMultiply(2, 3, 4)); // 24

// Practical example: URL builder
function buildURL(protocol) {
    return function(domain) {
        return function(path) {
            return function(params) {
                const paramString = new URLSearchParams(params).toString();
                return `${protocol}://${domain}${path}${paramString ? '?' + paramString : ''}`;
            };
        };
    };
}

const httpsURL = buildURL('https');
const exampleURL = httpsURL('example.com');
const apiURL = exampleURL('/api/v1');

console.log(apiURL({})); // https://example.com/api/v1
console.log(apiURL({ user: 'john', active: 'true' })); // https://example.com/api/v1?user=john&active=true

// More practical: Configuration-based functions
const createLogger = (level) => (module) => (message) => {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] [${level.toUpperCase()}] [${module}] ${message}`);
};

const infoLogger = createLogger('info');
const authLogger = infoLogger('AUTH');
const dbLogger = infoLogger('DATABASE');

authLogger('User logged in successfully');
dbLogger('Connection established');

const errorLogger = createLogger('error');
const paymentErrorLogger = errorLogger('PAYMENT');
paymentErrorLogger('Payment processing failed');
```

### Partial Application
```javascript
// Basic partial application
function partial(func, ...argsToApply) {
    return function(...remainingArgs) {
        return func(...argsToApply, ...remainingArgs);
    };
}

// Example: Mathematical operations
function calculate(operation, a, b, c) {
    switch(operation) {
        case 'add': return a + b + c;
        case 'multiply': return a * b * c;
        case 'average': return (a + b + c) / 3;
        default: return 0;
    }
}

const addThreeNumbers = partial(calculate, 'add');
const multiplyThreeNumbers = partial(calculate, 'multiply');
const averageThreeNumbers = partial(calculate, 'average');

console.log(addThreeNumbers(1, 2, 3)); // 6
console.log(multiplyThreeNumbers(2, 3, 4)); // 24
console.log(averageThreeNumbers(10, 20, 30)); // 20

// Advanced partial application with placeholders
const _ = Symbol('placeholder');

function partialWithPlaceholders(func, ...args) {
    return function(...remainingArgs) {
        const finalArgs = [];
        let remainingIndex = 0;
        
        for (let i = 0; i < args.length; i++) {
            if (args[i] === _) {
                finalArgs[i] = remainingArgs[remainingIndex++];
            } else {
                finalArgs[i] = args[i];
            }
        }
        
        // Add any remaining arguments
        while (remainingIndex < remainingArgs.length) {
            finalArgs.push(remainingArgs[remainingIndex++]);
        }
        
        return func(...finalArgs);
    };
}

// Usage with placeholders
function greet(greeting, name, punctuation) {
    return `${greeting} ${name}${punctuation}`;
}

const sayHelloTo = partialWithPlaceholders(greet, 'Hello', _, '!');
const askAbout = partialWithPlaceholders(greet, _, 'John', '?');

console.log(sayHelloTo('Alice')); // "Hello Alice!"
console.log(askAbout('How are you')); // "How are you John?"

// Practical example: Event handling
function handleEvent(eventType, selector, handler, element) {
    if (element.matches(selector)) {
        handler(element);
    }
}

const handleClickOnButton = partial(handleEvent, 'click', 'button');
const handleHoverOnLink = partial(handleEvent, 'mouseover', 'a');

// Create specific handlers
const clickHandler = (element) => {
    console.log('Button clicked:', element.textContent);
};

const hoverHandler = (element) => {
    console.log('Link hovered:', element.href);
};

// Usage in event delegation
document.addEventListener('click', (event) => {
    handleClickOnButton(clickHandler, event.target);
});

document.addEventListener('mouseover', (event) => {
    handleHoverOnLink(hoverHandler, event.target);
});
```

### Advanced Currying Patterns
```javascript
// Currying with validation
function createValidator(rules) {
    return function(fieldName) {
        return function(value) {
            const fieldRules = rules[fieldName] || [];
            const errors = [];
            
            fieldRules.forEach(rule => {
                if (!rule.test(value)) {
                    errors.push(rule.message);
                }
            });
            
            return {
                isValid: errors.length === 0,
                errors,
                fieldName,
                value
            };
        };
    };
}

const userValidationRules = {
    email: [
        { test: val => val && val.includes('@'), message: 'Email must contain @' },
        { test: val => val && val.length >= 5, message: 'Email too short' }
    ],
    password: [
        { test: val => val && val.length >= 8, message: 'Password must be at least 8 characters' },
        { test: val => /[A-Z]/.test(val), message: 'Password must contain uppercase letter' }
    ]
};

const validateUser = createValidator(userValidationRules);
const validateEmail = validateUser('email');
const validatePassword = validateUser('password');

console.log(validateEmail('john@example.com')); // { isValid: true, ... }
console.log(validatePassword('weakpass')); // { isValid: false, errors: [...] }

// Currying for API requests
function createAPIRequest(baseURL) {
    return function(endpoint) {
        return function(method) {
            return function(data = null) {
                return function(headers = {}) {
                    const url = `${baseURL}${endpoint}`;
                    const config = {
                        method,
                        headers: {
                            'Content-Type': 'application/json',
                            ...headers
                        }
                    };
                    
                    if (data && (method === 'POST' || method === 'PUT')) {
                        config.body = JSON.stringify(data);
                    }
                    
                    console.log(`Making ${method} request to ${url}`);
                    return fetch(url, config);
                };
            };
        };
    };
}

// Create API client for specific service
const apiRequest = createAPIRequest('https://api.example.com');

// Create endpoint-specific functions
const usersAPI = apiRequest('/users');
const productsAPI = apiRequest('/products');

// Create method-specific functions
const getUsers = usersAPI('GET')();
const postUser = usersAPI('POST');
const getProducts = productsAPI('GET')();

// Usage
getUsers(); // GET request to /users
postUser({ name: 'John', email: 'john@example.com' })(); // POST request with data

// Pipeline processing with currying
const pipe = (...functions) => (value) => 
    functions.reduce((acc, fn) => fn(acc), value);

const compose = (...functions) => (value) => 
    functions.reduceRight((acc, fn) => fn(acc), value);

// Transform functions using currying
const map = (fn) => (array) => array.map(fn);
const filter = (predicate) => (array) => array.filter(predicate);
const reduce = (fn, initial) => (array) => array.reduce(fn, initial);

// Create reusable transformations
const double = x => x * 2;
const isEven = x => x % 2 === 0;
const sum = (acc, val) => acc + val;

const processNumbers = pipe(
    map(double),           // Double each number
    filter(isEven),        // Keep only even numbers
    reduce(sum, 0)         // Sum them up
);

console.log(processNumbers([1, 2, 3, 4, 5])); // 2 + 4 + 6 + 8 + 10 = 30

// Form handling with curried functions
function createFormHandler(validators) {
    return function(transformers) {
        return function(onSuccess) {
            return function(onError) {
                return function(formData) {
                    // Validate
                    const validationErrors = [];
                    Object.keys(validators).forEach(field => {
                        const result = validators[field](formData[field]);
                        if (!result.isValid) {
                            validationErrors.push(...result.errors);
                        }
                    });
                    
                    if (validationErrors.length > 0) {
                        onError(validationErrors);
                        return;
                    }
                    
                    // Transform
                    const transformedData = { ...formData };
                    Object.keys(transformers).forEach(field => {
                        if (transformedData[field] !== undefined) {
                            transformedData[field] = transformers[field](transformedData[field]);
                        }
                    });
                    
                    onSuccess(transformedData);
                };
            };
        };
    };
}

// Setup form handler
const formValidators = {
    email: validateEmail,
    password: validatePassword
};

const formTransformers = {
    email: email => email.toLowerCase().trim(),
    password: password => password.trim()
};

const handleSuccess = (data) => {
    console.log('Form submitted successfully:', data);
};

const handleError = (errors) => {
    console.log('Form validation failed:', errors);
};

const processForm = createFormHandler(formValidators)(formTransformers)(handleSuccess)(handleError);

// Usage
processForm({
    email: '  JOHN@EXAMPLE.COM  ',
    password: 'ValidPassword123'
});
```

## 9. Memoization Techniques

### Basic Memoization
```javascript
// Simple memoization implementation
function memoize(fn) {
    const cache = {};
    
    return function(...args) {
        const key = JSON.stringify(args);
        
        if (key in cache) {
            console.log('Cache hit for:', key);
            return cache[key];
        }
        
        console.log('Computing result for:', key);
        const result = fn.apply(this, args);
        cache[key] = result;
        
        return result;
    };
}

// Example: Expensive recursive function
function fibonacci(n) {
    if (n < 2) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// Without memoization - very slow for large numbers
console.time('fibonacci(40) without memoization');
console.log(fibonacci(40));
console.timeEnd('fibonacci(40) without memoization');

// With memoization - much faster
const memoizedFibonacci = memoize(function(n) {
    if (n < 2) return n;
    return memoizedFibonacci(n - 1) + memoizedFibonacci(n - 2);
});

console.time('fibonacci(40) with memoization');
console.log(memoizedFibonacci(40));
console.timeEnd('fibonacci(40) with memoization');

// Advanced memoization with Map for better performance
function memoizeWithMap(fn) {
    const cache = new Map();
    
    return function(...args) {
        const key = JSON.stringify(args);
        
        if (cache.has(key)) {
            return cache.get(key);
        }
        
        const result = fn.apply(this, args);
        cache.set(key, result);
        
        return result;
    };
}

// Memoization with custom key generation
function memoizeWithCustomKey(fn, keyGenerator) {
    const cache = new Map();
    
    return function(...args) {
        const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);
        
        if (cache.has(key)) {
            return cache.get(key);
        }
        
        const result = fn.apply(this, args);
        cache.set(key, result);
        
        return result;
    };
}

// Example with custom key generator
function expensiveCalculation(obj1, obj2) {
    // Simulate expensive operation
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
        result += obj1.value * obj2.value;
    }
    return result;
}

const memoizedCalculation = memoizeWithCustomKey(
    expensiveCalculation,
    (obj1, obj2) => `${obj1.id}-${obj2.id}` // Custom key based on IDs
);

const objA = { id: 1, value: 5 };
const objB = { id: 2, value: 10 };

console.log(memoizedCalculation(objA, objB)); // Computes result
console.log(memoizedCalculation(objA, objB)); // Returns cached result
```

### Advanced Memoization Patterns
```javascript
// Memoization with TTL (Time To Live)
function memoizeWithTTL(fn, ttl = 60000) { // Default 1 minute
    const cache = new Map();
    
    return function(...args) {
        const key = JSON.stringify(args);
        const now = Date.now();
        
        if (cache.has(key)) {
            const { value, timestamp } = cache.get(key);
            
            if (now - timestamp < ttl) {
                return value;
            } else {
                cache.delete(key);
            }
        }
        
        const result = fn.apply(this, args);
        cache.set(key, { value: result, timestamp: now });
        
        return result;
    };
}

// Example: API call memoization with TTL
const fetchUserData = memoizeWithTTL(async function(userId) {
    console.log(`Fetching user data for ID: ${userId}`);
    
    // Simulate API call
    return new Promise(resolve => {
        setTimeout(() => {
            resolve({
                id: userId,
                name: `User ${userId}`,
                timestamp: new Date().toISOString()
            });
        }, 1000);
    });
}, 30000); // Cache for 30 seconds

// LRU (Least Recently Used) Cache Memoization
class LRUCache {
    constructor(maxSize = 100) {
        this.maxSize = maxSize;
        this.cache = new Map();
    }
    
    get(key) {
        if (this.cache.has(key)) {
            // Move to end (most recently used)
            const value = this.cache.get(key);
            this.cache.delete(key);
            this.cache.set(key, value);
            return value;
        }
        return undefined;
    }
    
    set(key, value) {
        if (this.cache.has(key)) {
            // Update existing key
            this.cache.delete(key);
        } else if (this.cache.size >= this.maxSize) {
            // Remove least recently used (first item)
            const firstKey = this.cache.keys().next().value;
            this.cache.delete(firstKey);
        }
        
        this.cache.set(key, value);
    }
    
    has(key) {
        return this.cache.has(key);
    }
    
    clear() {
        this.cache.clear();
    }
    
    get size() {
        return this.cache.size;
    }
}

function memoizeWithLRU(fn, maxSize = 100) {
    const cache = new LRUCache(maxSize);
    
    return function(...args) {
        const key = JSON.stringify(args);
        
        if (cache.has(key)) {
            return cache.get(key);
        }
        
        const result = fn.apply(this, args);
        cache.set(key, result);
        
        return result;
    };
}

// Memoization with cleanup and statistics
function memoizeWithStats(fn, options = {}) {
    const cache = new Map();
    const stats = {
        hits: 0,
        misses: 0,
        computations: 0
    };
    
    const memoized = function(...args) {
        const key = JSON.stringify(args);
        
        if (cache.has(key)) {
            stats.hits++;
            return cache.get(key);
        }
        
        stats.misses++;
        stats.computations++;
        const result = fn.apply(this, args);
        cache.set(key, result);
        
        return result;
    };
    
    // Add utility methods
    memoized.cache = cache;
    memoized.stats = () => ({ ...stats });
    memoized.clear = () => {
        cache.clear();
        stats.hits = 0;
        stats.misses = 0;
        stats.computations = 0;
    };
    memoized.size = () => cache.size;
    memoized.hitRate = () => {
        const total = stats.hits + stats.misses;
        return total > 0 ? (stats.hits / total) * 100 : 0;
    };
    
    return memoized;
}

// Example usage
const expensiveFunction = memoizeWithStats(function(x, y) {
    // Simulate expensive computation
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
        result += Math.sqrt(x * y + i);
    }
    return result;
});

// Test the function
console.log(expensiveFunction(5, 10)); // First call - computation
console.log(expensiveFunction(5, 10)); // Second call - cache hit
console.log(expensiveFunction(3, 7));  // Third call - computation
console.log(expensiveFunction(5, 10)); // Fourth call - cache hit

console.log('Cache statistics:', expensiveFunction.stats());
console.log('Cache hit rate:', expensiveFunction.hitRate().toFixed(2) + '%');
```

### Practical Memoization Applications
```javascript
// 1. DOM Query Memoization
const memoizedQuerySelector = memoize(function(selector) {
    console.log(`Querying DOM for: ${selector}`);
    return document.querySelector(selector);
});

const memoizedQuerySelectorAll = memoize(function(selector) {
    console.log(`Querying DOM for all: ${selector}`);
    return Array.from(document.querySelectorAll(selector));
});

// Usage
const header = memoizedQuerySelector('header'); // Queries DOM
const headerAgain = memoizedQuerySelector('header'); // Returns cached result

// 2. API Response Memoization
class APIClient {
    constructor(baseURL) {
        this.baseURL = baseURL;
        
        // Memoize GET requests with TTL
        this.get = memoizeWithTTL(this._get.bind(this), 60000); // 1 minute cache
        
        // Don't memoize POST/PUT/DELETE requests
        this.post = this._post.bind(this);
        this.put = this._put.bind(this);
        this.delete = this._delete.bind(this);
    }
    
    async _get(endpoint, params = {}) {
        const url = new URL(endpoint, this.baseURL);
        Object.keys(params).forEach(key => 
            url.searchParams.append(key, params[key])
        );
        
        console.log(`Making GET request to: ${url}`);
        
        // Simulate API call
        return new Promise(resolve => {
            setTimeout(() => {
                resolve({
                    data: `Response from ${endpoint}`,
                    timestamp: new Date().toISOString()
                });
            }, 500);
        });
    }
    
    async _post(endpoint, data) {
        console.log(`Making POST request to: ${endpoint}`);
        // Implementation for POST
        return { success: true, data };
    }
    
    async _put(endpoint, data) {
        console.log(`Making PUT request to: ${endpoint}`);
        // Implementation for PUT
        return { success: true, data };
    }
    
    async _delete(endpoint) {
        console.log(`Making DELETE request to: ${endpoint}`);
        // Implementation for DELETE
        return { success: true };
    }
}

const api = new APIClient('https://api.example.com');

// These will be cached
api.get('/users').then(response => console.log('First call:', response));
api.get('/users').then(response => console.log('Second call (cached):', response));

// 3. Computed Property Memoization
class DataProcessor {
    constructor(data) {
        this.data = data;
        this._cache = new Map();
    }
    
    // Memoized getter for expensive computations
    get expensiveComputation() {
        if (!this._cache.has('expensiveComputation')) {
            console.log('Computing expensive result...');
            
            // Simulate expensive computation
            const result = this.data.reduce((acc, item) => {
                return acc + Math.pow(item.value, 2);
            }, 0);
            
            this._cache.set('expensiveComputation', result);
        }
        
        return this._cache.get('expensiveComputation');
    }
    
    get averageValue() {
        if (!this._cache.has('averageValue')) {
            console.log('Computing average...');
            
            const sum = this.data.reduce((acc, item) => acc + item.value, 0);
            const avg = sum / this.data.length;
            
            this._cache.set('averageValue', avg);
        }
        
        return this._cache.get('averageValue');
    }
    
    // Clear cache when data changes
    updateData(newData) {
        this.data = newData;
        this._cache.clear();
    }
    
    // Selective cache invalidation
    invalidateCache(property) {
        if (property) {
            this._cache.delete(property);
        } else {
            this._cache.clear();
        }
    }
}

const processor = new DataProcessor([
    { value: 10 }, { value: 20 }, { value: 30 }
]);

console.log(processor.expensiveComputation); // Computes
console.log(processor.expensiveComputation); // Cached
console.log(processor.averageValue); // Computes
console.log(processor.averageValue); // Cached

// 4. Function Composition with Memoization
const memoizedCompose = (...functions) => {
    const cache = new Map();
    
    return function(value) {
        const key = JSON.stringify({ functions: functions.length, value });
        
        if (cache.has(key)) {
            return cache.get(key);
        }
        
        const result = functions.reduceRight((acc, fn) => fn(acc), value);
        cache.set(key, result);
        
        return result;
    };
};

// Create reusable memoized compositions
const processNumber = memoizedCompose(
    x => x * 2,
    x => x + 5,
    x => Math.sqrt(x)
);

console.log(processNumber(16)); // Computes: sqrt(16) = 4, 4 + 5 = 9, 9 * 2 = 18
console.log(processNumber(16)); // Cached result

// 5. Recursive Function Memoization with Shared Cache
function createMemoizedRecursive(fn) {
    const cache = new Map();
    
    function memoizedFn(...args) {
        const key = JSON.stringify(args);
        
        if (cache.has(key)) {
            return cache.get(key);
        }
        
        // Temporarily set a placeholder to detect circular dependencies
        cache.set(key, null);
        
        const result = fn.apply(this, args.concat(memoizedFn));
        cache.set(key, result);
        
        return result;
    }
    
    memoizedFn.cache = cache;
    memoizedFn.clearCache = () => cache.clear();
    
    return memoizedFn;
}

// Example: Factorial with memoization
const memoizedFactorial = createMemoizedRecursive(function(n, recursiveFn) {
    if (n <= 1) return 1;
    return n * recursiveFn(n - 1);
});

console.log(memoizedFactorial(10)); // Computes 10!
console.log(memoizedFactorial(8));  // Uses cached values for 1! through 8!
console.log(memoizedFactorial(12)); // Only computes 11! and 12!, uses cache for others

// Example: Fibonacci with shared cache
const memoizedFib = createMemoizedRecursive(function(n, recursiveFn) {
    if (n < 2) return n;
    return recursiveFn(n - 1) + recursiveFn(n - 2);
});

console.log(memoizedFib(50)); // Very fast due to memoization
console.log('Cache size:', memoizedFib.cache.size);
```

This comprehensive guide covers all the essential advanced function and scope concepts in JavaScript. Each topic builds upon the previous ones and includes practical examples that demonstrate real-world applications. The examples progress from basic concepts to more complex implementations that students might encounter in professional development environments.