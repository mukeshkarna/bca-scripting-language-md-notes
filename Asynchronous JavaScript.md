# Asynchronous JavaScript

## 1. Understanding the Event Loop

### What is the Event Loop?
The Event Loop is JavaScript's mechanism for handling asynchronous operations. JavaScript is single-threaded, meaning it can only execute one piece of code at a time, but the Event Loop allows it to handle asynchronous operations without blocking the main thread.

### Components of the Event Loop

**Call Stack**: Where function calls are stored and executed
**Web APIs**: Browser-provided APIs (setTimeout, DOM events, HTTP requests)
**Callback Queue**: Where callbacks wait to be executed
**Event Loop**: Monitors the call stack and callback queue

```javascript
// Understanding the call stack
function first() {
    console.log("First function");
    second();
}

function second() {
    console.log("Second function");
    third();
}

function third() {
    console.log("Third function");
}

first();
// Output:
// First function
// Second function
// Third function
```

### How the Event Loop Works

1. **Synchronous code** executes immediately on the call stack
2. **Asynchronous operations** are sent to Web APIs
3. When async operations complete, their **callbacks** go to the callback queue
4. The **Event Loop** checks if the call stack is empty
5. If empty, it moves callbacks from the queue to the call stack

```javascript
console.log("Start");

setTimeout(() => {
    console.log("Timeout callback");
}, 0);

console.log("End");

// Output:
// Start
// End
// Timeout callback
```

### Microtasks vs Macrotasks

**Macrotasks**: setTimeout, setInterval, DOM events, HTTP requests
**Microtasks**: Promises (.then, .catch, .finally), queueMicrotask()

Microtasks have higher priority than macrotasks:

```javascript
console.log("1");

setTimeout(() => console.log("2"), 0);

Promise.resolve().then(() => console.log("3"));

console.log("4");

// Output: 1, 4, 3, 2
```

### Visualizing the Event Loop

```javascript
function demonstrateEventLoop() {
    console.log("Start");
    
    // Macrotask
    setTimeout(() => {
        console.log("setTimeout 1");
    }, 0);
    
    // Microtask
    Promise.resolve().then(() => {
        console.log("Promise 1");
        return Promise.resolve();
    }).then(() => {
        console.log("Promise 2");
    });
    
    // Another macrotask
    setTimeout(() => {
        console.log("setTimeout 2");
    }, 0);
    
    console.log("End");
}

demonstrateEventLoop();
// Output:
// Start
// End
// Promise 1
// Promise 2
// setTimeout 1
// setTimeout 2
```

## 2. Callbacks and Callback Hell

### What are Callbacks?
A callback is a function passed as an argument to another function, to be executed after some operation has completed.

```javascript
// Simple callback example
function greet(name, callback) {
    console.log(`Hello, ${name}!`);
    callback();
}

function afterGreeting() {
    console.log("Nice to meet you!");
}

greet("John", afterGreeting);
// Output:
// Hello, John!
// Nice to meet you!
```

### Asynchronous Callbacks

```javascript
// Using callbacks with setTimeout
function fetchData(callback) {
    console.log("Fetching data...");
    
    setTimeout(() => {
        const data = { id: 1, name: "User Data" };
        callback(data);
    }, 2000);
}

function processData(data) {
    console.log("Processing:", data);
}

fetchData(processData);
```

### Error Handling with Callbacks

```javascript
// Error-first callback pattern (Node.js style)
function fetchUserData(userId, callback) {
    setTimeout(() => {
        if (userId <= 0) {
            callback(new Error("Invalid user ID"), null);
        } else {
            const userData = { id: userId, name: `User ${userId}` };
            callback(null, userData);
        }
    }, 1000);
}

// Usage
fetchUserData(1, (error, data) => {
    if (error) {
        console.error("Error:", error.message);
    } else {
        console.log("User data:", data);
    }
});

fetchUserData(-1, (error, data) => {
    if (error) {
        console.error("Error:", error.message); // Error: Invalid user ID
    } else {
        console.log("User data:", data);
    }
});
```

### Callback Hell (Pyramid of Doom)

When you have multiple nested asynchronous operations, callbacks can become deeply nested and hard to read:

```javascript
// Example of callback hell
function getUser(userId, callback) {
    setTimeout(() => {
        callback(null, { id: userId, name: `User ${userId}` });
    }, 1000);
}

function getPosts(userId, callback) {
    setTimeout(() => {
        callback(null, [`Post 1 by ${userId}`, `Post 2 by ${userId}`]);
    }, 1000);
}

function getComments(postId, callback) {
    setTimeout(() => {
        callback(null, [`Comment 1 on ${postId}`, `Comment 2 on ${postId}`]);
    }, 1000);
}

// Callback hell begins here
getUser(1, (userErr, user) => {
    if (userErr) {
        console.error(userErr);
        return;
    }
    
    console.log("Got user:", user);
    
    getPosts(user.id, (postsErr, posts) => {
        if (postsErr) {
            console.error(postsErr);
            return;
        }
        
        console.log("Got posts:", posts);
        
        getComments(posts[0], (commentsErr, comments) => {
            if (commentsErr) {
                console.error(commentsErr);
                return;
            }
            
            console.log("Got comments:", comments);
            
            // Imagine more nested operations...
            // This becomes unreadable and unmaintainable
        });
    });
});
```

### Problems with Callback Hell

1. **Readability**: Code becomes hard to read and understand
2. **Maintainability**: Difficult to modify or debug
3. **Error handling**: Error handling gets scattered and complex
4. **Testing**: Hard to write unit tests
5. **Inversion of control**: You lose control over when and how your callback is executed

### Solutions to Callback Hell

**1. Named Functions (instead of anonymous functions):**
```javascript
function handleUser(userErr, user) {
    if (userErr) {
        console.error(userErr);
        return;
    }
    
    console.log("Got user:", user);
    getPosts(user.id, handlePosts);
}

function handlePosts(postsErr, posts) {
    if (postsErr) {
        console.error(postsErr);
        return;
    }
    
    console.log("Got posts:", posts);
    getComments(posts[0], handleComments);
}

function handleComments(commentsErr, comments) {
    if (commentsErr) {
        console.error(commentsErr);
        return;
    }
    
    console.log("Got comments:", comments);
}

getUser(1, handleUser);
```

**2. Modularization:**
```javascript
// Break down into smaller, reusable functions
function fetchUserAndPosts(userId) {
    getUser(userId, (userErr, user) => {
        if (userErr) {
            handleError(userErr);
            return;
        }
        
        fetchPostsForUser(user);
    });
}

function fetchPostsForUser(user) {
    getPosts(user.id, (postsErr, posts) => {
        if (postsErr) {
            handleError(postsErr);
            return;
        }
        
        fetchCommentsForPost(posts[0]);
    });
}

function fetchCommentsForPost(post) {
    getComments(post, (commentsErr, comments) => {
        if (commentsErr) {
            handleError(commentsErr);
            return;
        }
        
        console.log("Final result:", comments);
    });
}

function handleError(error) {
    console.error("An error occurred:", error);
}

fetchUserAndPosts(1);
```

## 3. Promises (Creation, Chaining, Error Handling)

### What are Promises?
A Promise is an object representing the eventual completion or failure of an asynchronous operation. It provides a cleaner alternative to callbacks.

### Promise States
- **Pending**: Initial state, neither fulfilled nor rejected
- **Fulfilled**: Operation completed successfully
- **Rejected**: Operation failed

```javascript
// A promise can only change state once
const promise = new Promise((resolve, reject) => {
    // Async operation here
});
```

### Creating Promises

```javascript
// Basic Promise creation
function createPromise() {
    return new Promise((resolve, reject) => {
        // Simulate async operation
        setTimeout(() => {
            const success = Math.random() > 0.5;
            
            if (success) {
                resolve("Operation successful!");
            } else {
                reject(new Error("Operation failed!"));
            }
        }, 1000);
    });
}

// Using the promise
createPromise()
    .then(result => {
        console.log("Success:", result);
    })
    .catch(error => {
        console.error("Error:", error.message);
    });
```

### Converting Callbacks to Promises

```javascript
// Original callback-based function
function fetchDataCallback(callback) {
    setTimeout(() => {
        const data = { id: 1, name: "Sample Data" };
        callback(null, data);
    }, 1000);
}

// Promise-based version
function fetchDataPromise() {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            const data = { id: 1, name: "Sample Data" };
            resolve(data);
        }, 1000);
    });
}

// Usage comparison
// Callback version
fetchDataCallback((err, data) => {
    if (err) {
        console.error(err);
    } else {
        console.log(data);
    }
});

// Promise version
fetchDataPromise()
    .then(data => console.log(data))
    .catch(err => console.error(err));
```

### Promise Chaining

Promises can be chained together to perform sequential asynchronous operations:

```javascript
function getUser(userId) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if (userId <= 0) {
                reject(new Error("Invalid user ID"));
            } else {
                resolve({ id: userId, name: `User ${userId}` });
            }
        }, 1000);
    });
}

function getPosts(user) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            const posts = [`Post 1 by ${user.name}`, `Post 2 by ${user.name}`];
            resolve({ user, posts });
        }, 1000);
    });
}

function getComments(data) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            const comments = [`Comment 1`, `Comment 2`];
            resolve({ ...data, comments });
        }, 1000);
    });
}

// Promise chaining - much cleaner than callback hell
getUser(1)
    .then(user => {
        console.log("Got user:", user);
        return getPosts(user);
    })
    .then(data => {
        console.log("Got posts:", data.posts);
        return getComments(data);
    })
    .then(finalData => {
        console.log("Final data:", finalData);
    })
    .catch(error => {
        console.error("Error occurred:", error.message);
    });
```

### Returning Values in Promise Chains

```javascript
// Different ways to return values in promise chains
Promise.resolve(10)
    .then(value => {
        console.log(value); // 10
        return value * 2;   // Return a regular value
    })
    .then(value => {
        console.log(value); // 20
        return Promise.resolve(value * 2); // Return a promise
    })
    .then(value => {
        console.log(value); // 40
        return new Promise(resolve => {
            setTimeout(() => resolve(value * 2), 1000);
        });
    })
    .then(value => {
        console.log(value); // 80 (after 1 second delay)
    });
```

### Error Handling in Promises

```javascript
// Error handling with .catch()
function riskyOperation() {
    return new Promise((resolve, reject) => {
        const success = Math.random() > 0.5;
        
        setTimeout(() => {
            if (success) {
                resolve("Success!");
            } else {
                reject(new Error("Something went wrong!"));
            }
        }, 1000);
    });
}

riskyOperation()
    .then(result => {
        console.log("Result:", result);
        return "Next step";
    })
    .then(result => {
        console.log("Next result:", result);
    })
    .catch(error => {
        console.error("Caught error:", error.message);
    })
    .finally(() => {
        console.log("This always runs");
    });
```

### Error Propagation in Promise Chains

```javascript
// Errors propagate down the chain until caught
Promise.resolve("Start")
    .then(value => {
        console.log(value);
        throw new Error("Error in step 1");
    })
    .then(value => {
        // This won't execute due to the error above
        console.log("This won't run");
        return "Step 2";
    })
    .then(value => {
        // This won't execute either
        console.log("This won't run either");
        return "Step 3";
    })
    .catch(error => {
        console.error("Caught:", error.message); // Caught: Error in step 1
        return "Recovered"; // Recover from error
    })
    .then(value => {
        console.log("After recovery:", value); // After recovery: Recovered
    });
```

### Multiple Catch Blocks

```javascript
// You can have multiple catch blocks for different error handling
function stepOne() {
    return Promise.reject(new Error("Step 1 failed"));
}

function stepTwo() {
    return Promise.resolve("Step 2 success");
}

stepOne()
    .catch(error => {
        console.error("Step 1 error:", error.message);
        return "Step 1 recovered"; // Recover and continue
    })
    .then(result => {
        console.log("Continuing with:", result);
        return stepTwo();
    })
    .then(result => {
        console.log("Final result:", result);
    })
    .catch(error => {
        console.error("Final error:", error.message);
    });
```

### Promise.finally()

```javascript
// finally() runs regardless of promise outcome
function cleanup() {
    console.log("Cleaning up resources...");
}

riskyOperation()
    .then(result => {
        console.log("Success:", result);
    })
    .catch(error => {
        console.error("Error:", error.message);
    })
    .finally(() => {
        cleanup(); // Always runs
    });
```

## 4. async/await Syntax

### Introduction to async/await
`async/await` is syntactic sugar built on top of Promises, making asynchronous code look and behave more like synchronous code.

### Basic async/await Syntax

```javascript
// Function declaration with async
async function fetchData() {
    return "Hello, World!";
}

// Arrow function with async
const fetchDataArrow = async () => {
    return "Hello, World!";
};

// async functions always return a Promise
console.log(fetchData()); // Promise { 'Hello, World!' }

// To get the value, use await or .then()
fetchData().then(result => console.log(result)); // Hello, World!
```

### Using await

```javascript
// await can only be used inside async functions
async function example() {
    const result = await fetchData();
    console.log(result); // Hello, World!
}

example();

// This would cause an error:
// const result = await fetchData(); // SyntaxError: await is only valid in async functions
```

### Converting Promise Chains to async/await

```javascript
// Promise chain version
function getUserDataPromise(userId) {
    return getUser(userId)
        .then(user => {
            console.log("Got user:", user);
            return getPosts(user);
        })
        .then(data => {
            console.log("Got posts:", data.posts);
            return getComments(data);
        })
        .then(finalData => {
            console.log("Final data:", finalData);
            return finalData;
        })
        .catch(error => {
            console.error("Error:", error.message);
            throw error;
        });
}

// async/await version
async function getUserDataAsync(userId) {
    try {
        const user = await getUser(userId);
        console.log("Got user:", user);
        
        const data = await getPosts(user);
        console.log("Got posts:", data.posts);
        
        const finalData = await getComments(data);
        console.log("Final data:", finalData);
        
        return finalData;
    } catch (error) {
        console.error("Error:", error.message);
        throw error;
    }
}

// Both functions can be used the same way
getUserDataAsync(1)
    .then(result => console.log("Success:", result))
    .catch(error => console.error("Failed:", error.message));
```

### Error Handling with try/catch

```javascript
async function handleErrors() {
    try {
        const result1 = await riskyOperation();
        console.log("Result 1:", result1);
        
        const result2 = await anotherRiskyOperation();
        console.log("Result 2:", result2);
        
        return "All operations successful";
    } catch (error) {
        console.error("Something went wrong:", error.message);
        
        // You can handle specific errors
        if (error.message.includes("network")) {
            console.log("Network error - retrying...");
            // Retry logic here
        }
        
        throw error; // Re-throw if you want the caller to handle it
    } finally {
        console.log("Cleanup operations");
    }
}
```

### Parallel vs Sequential Execution

```javascript
// Sequential execution (slower)
async function sequentialExecution() {
    console.time("Sequential");
    
    const result1 = await delay(1000, "First");
    const result2 = await delay(1000, "Second");
    const result3 = await delay(1000, "Third");
    
    console.timeEnd("Sequential"); // ~3000ms
    return [result1, result2, result3];
}

// Parallel execution (faster)
async function parallelExecution() {
    console.time("Parallel");
    
    const promise1 = delay(1000, "First");
    const promise2 = delay(1000, "Second");
    const promise3 = delay(1000, "Third");
    
    const result1 = await promise1;
    const result2 = await promise2;
    const result3 = await promise3;
    
    console.timeEnd("Parallel"); // ~1000ms
    return [result1, result2, result3];
}

// Helper function for demonstration
function delay(ms, value) {
    return new Promise(resolve => {
        setTimeout(() => resolve(value), ms);
    });
}

// Test both approaches
async function test() {
    await sequentialExecution();
    await parallelExecution();
}

test();
```

### Common Patterns with async/await

**1. Conditional await:**
```javascript
async function conditionalAwait(shouldWait) {
    let result;
    
    if (shouldWait) {
        result = await longRunningOperation();
    } else {
        result = quickOperation();
    }
    
    return result;
}
```

**2. await in loops:**
```javascript
// Sequential processing
async function processItemsSequentially(items) {
    const results = [];
    
    for (const item of items) {
        const result = await processItem(item);
        results.push(result);
    }
    
    return results;
}

// Parallel processing
async function processItemsInParallel(items) {
    const promises = items.map(item => processItem(item));
    return await Promise.all(promises);
}
```

**3. Timeout with async/await:**
```javascript
function timeout(ms) {
    return new Promise((_, reject) => {
        setTimeout(() => reject(new Error("Timeout")), ms);
    });
}

async function operationWithTimeout() {
    try {
        const result = await Promise.race([
            longRunningOperation(),
            timeout(5000) // 5 second timeout
        ]);
        
        return result;
    } catch (error) {
        if (error.message === "Timeout") {
            console.log("Operation timed out");
        }
        throw error;
    }
}
```

## 5. Promise.all(), Promise.race(), Promise.allSettled()

### Promise.all()
Waits for all promises to resolve, or fails fast if any promise rejects.

```javascript
// Basic Promise.all usage
const promise1 = delay(1000, "First");
const promise2 = delay(2000, "Second");
const promise3 = delay(1500, "Third");

Promise.all([promise1, promise2, promise3])
    .then(results => {
        console.log("All results:", results);
        // Output: ["First", "Second", "Third"]
        // Takes ~2000ms (longest promise duration)
    })
    .catch(error => {
        console.error("One of the promises failed:", error);
    });

// With async/await
async function usePromiseAll() {
    try {
        const results = await Promise.all([
            fetchUser(1),
            fetchUser(2),
            fetchUser(3)
        ]);
        
        console.log("All users:", results);
    } catch (error) {
        console.error("Failed to fetch users:", error);
    }
}
```

**Fail-fast behavior:**
```javascript
const promiseSuccess = delay(1000, "Success");
const promiseFailure = Promise.reject(new Error("Failed"));
const promiseSuccess2 = delay(2000, "Success 2");

Promise.all([promiseSuccess, promiseFailure, promiseSuccess2])
    .then(results => {
        console.log("This won't run");
    })
    .catch(error => {
        console.error("Promise.all failed:", error.message);
        // Fails immediately when promiseFailure rejects
    });
```

### Promise.race()
Returns the result of the first promise to settle (either resolve or reject).

```javascript
// Basic Promise.race usage
const fast = delay(1000, "Fast");
const slow = delay(3000, "Slow");

Promise.race([fast, slow])
    .then(result => {
        console.log("Winner:", result); // "Fast"
    });

// Timeout implementation using Promise.race
async function fetchWithTimeout(url, timeoutMs) {
    const fetchPromise = fetch(url);
    const timeoutPromise = new Promise((_, reject) => {
        setTimeout(() => reject(new Error("Request timeout")), timeoutMs);
    });
    
    try {
        const response = await Promise.race([fetchPromise, timeoutPromise]);
        return await response.json();
    } catch (error) {
        if (error.message === "Request timeout") {
            console.log("Request timed out");
        }
        throw error;
    }
}

// Usage
fetchWithTimeout("https://api.example.com/data", 5000)
    .then(data => console.log("Data:", data))
    .catch(error => console.error("Error:", error.message));
```

**First to fail wins too:**
```javascript
const promiseSlow = delay(3000, "Slow success");
const promiseFastFail = Promise.reject(new Error("Fast failure"));

Promise.race([promiseSlow, promiseFastFail])
    .then(result => {
        console.log("This won't run");
    })
    .catch(error => {
        console.error("Race failed:", error.message); // "Fast failure"
    });
```

### Promise.allSettled()
Waits for all promises to settle (either resolve or reject) and returns an array of result objects.

```javascript
// Basic Promise.allSettled usage
const promise1 = delay(1000, "Success 1");
const promise2 = Promise.reject(new Error("Failure"));
const promise3 = delay(1500, "Success 2");

Promise.allSettled([promise1, promise2, promise3])
    .then(results => {
        console.log("All settled:", results);
        
        results.forEach((result, index) => {
            if (result.status === "fulfilled") {
                console.log(`Promise ${index + 1} succeeded:`, result.value);
            } else {
                console.log(`Promise ${index + 1} failed:`, result.reason.message);
            }
        });
    });

// Output:
// Promise 1 succeeded: Success 1
// Promise 2 failed: Failure
// Promise 3 succeeded: Success 2
```

**Practical example - Multiple API calls:**
```javascript
async function fetchMultipleApis() {
    const apiCalls = [
        fetch("/api/users"),
        fetch("/api/posts"),
        fetch("/api/comments")
    ];
    
    const results = await Promise.allSettled(apiCalls);
    
    const processedResults = {};
    
    results.forEach((result, index) => {
        const apiName = ['users', 'posts', 'comments'][index];
        
        if (result.status === 'fulfilled') {
            processedResults[apiName] = result.value;
            console.log(`${apiName} API: Success`);
        } else {
            processedResults[apiName] = null;
            console.error(`${apiName} API failed:`, result.reason);
        }
    });
    
    return processedResults;
}
```

### Promise.any() (ES2021)
Returns the first fulfilled promise, ignoring rejections unless all promises reject.

```javascript
// Promise.any usage
const promise1 = Promise.reject(new Error("Error 1"));
const promise2 = delay(2000, "Success 2");
const promise3 = Promise.reject(new Error("Error 3"));

Promise.any([promise1, promise2, promise3])
    .then(result => {
        console.log("First success:", result); // "Success 2"
    })
    .catch(error => {
        console.error("All promises failed:", error);
    });

// If all promises reject, you get an AggregateError
const allRejected = [
    Promise.reject(new Error("Error 1")),
    Promise.reject(new Error("Error 2")),
    Promise.reject(new Error("Error 3"))
];

Promise.any(allRejected)
    .catch(error => {
        console.log("Error type:", error.constructor.name); // AggregateError
        console.log("All errors:", error.errors);
    });
```

### Comparison of Promise Methods

```javascript
// Comparison function to demonstrate differences
async function comparePromiseMethods() {
    const promises = [
        delay(1000, "Fast success"),
        delay(2000, "Slow success"),
        Promise.reject(new Error("Failure"))
    ];
    
    console.log("--- Promise.all ---");
    try {
        const allResults = await Promise.all(promises);
        console.log("Results:", allResults);
    } catch (error) {
        console.log("Failed:", error.message); // Fails fast
    }
    
    console.log("--- Promise.allSettled ---");
    const settledResults = await Promise.allSettled(promises);
    console.log("Results:", settledResults); // All results, success and failure
    
    console.log("--- Promise.race ---");
    try {
        const raceResult = await Promise.race(promises);
        console.log("Winner:", raceResult); // First to complete
    } catch (error) {
        console.log("First failure:", error.message);
    }
    
    console.log("--- Promise.any ---");
    try {
        const anyResult = await Promise.any(promises);
        console.log("First success:", anyResult); // First successful
    } catch (error) {
        console.log("All failed:", error.message);
    }
}

comparePromiseMethods();
```

## 6. Error Handling in Async Code

### Types of Errors in Async Code

**1. Syntax Errors:**
```javascript
// These are caught at parse time
async function syntaxError() {
    // return await "hello"; // This is valid
    // await return "hello"; // SyntaxError
}
```

**2. Runtime Errors:**
```javascript
async function runtimeError() {
    try {
        const data = await fetch("/api/data");
        return data.json(); // Might throw if response isn't JSON
    } catch (error) {
        console.error("Runtime error:", error.message);
        throw error;
    }
}
```

**3. Promise Rejection Errors:**
```javascript
async function promiseRejectionError() {
    try {
        const result = await Promise.reject(new Error("Promise rejected"));
        return result;
    } catch (error) {
        console.error("Promise rejection:", error.message);
        throw error;
    }
}
```

### Error Handling Strategies

**1. Try-Catch Blocks:**
```javascript
async function handleWithTryCatch() {
    try {
        const user = await fetchUser(1);
        const posts = await fetchPosts(user.id);
        const comments = await fetchComments(posts[0].id);
        
        return { user, posts, comments };
    } catch (error) {
        // Handle any error that occurred in the try block
        console.error("Error in handleWithTryCatch:", error.message);
        
        // You can provide fallback values
        return {
            user: null,
            posts: [],
            comments: [],
            error: error.message
        };
    }
}
```

**2. Multiple Try-Catch for Granular Error Handling:**
```javascript
async function granularErrorHandling() {
    let user, posts, comments;
    
    try {
        user = await fetchUser(1);
    } catch (error) {
        console.error("Failed to fetch user:", error.message);
        return { error: "User fetch failed" };
    }
    
    try {
        posts = await fetchPosts(user.id);
    } catch (error) {
        console.error("Failed to fetch posts:", error.message);
        posts = []; // Provide default value
    }
    
    try {
        comments = await fetchComments(posts[0]?.id);
    } catch (error) {
        console.error("Failed to fetch comments:", error.message);
        comments = []; // Provide default value
    }
    
    return { user, posts, comments };
}
```

**3. Error Handling with Promise.catch():**
```javascript
async function mixedErrorHandling() {
    const user = await fetchUser(1).catch(error => {
        console.error("User fetch failed:", error.message);
        return null; // Provide fallback
    });
    
    if (!user) {
        return { error: "Cannot proceed without user" };
    }
    
    const posts = await fetchPosts(user.id).catch(error => {
        console.error("Posts fetch failed:", error.message);
        return []; // Provide fallback
    });
    
    return { user, posts };
}
```

### Custom Error Classes

```javascript
// Custom error classes for better error handling
class NetworkError extends Error {
    constructor(message, status) {
        super(message);
        this.name = "NetworkError";
        this.status = status;
    }
}

class ValidationError extends Error {
    constructor(message, field) {
        super(message);
        this.name = "ValidationError";
        this.field = field;
    }
}

class AuthenticationError extends Error {
    constructor(message) {
        super(message);
        this.name = "AuthenticationError";
    }
}

// Usage with custom errors
async function fetchUserWithCustomErrors(userId) {
    try {
        if (!userId || userId <= 0) {
            throw new ValidationError("Invalid user ID", "userId");
        }
        
        const response = await fetch(`/api/users/${userId}`);
        
        if (response.status === 401) {
            throw new AuthenticationError("User not authenticated");
        }
        
        if (response.status === 404) {
            throw new NetworkError("User not found", 404);
        }
        
        if (!response.ok) {
            throw new NetworkError(`HTTP ${response.status}`, response.status);
        }
        
        return await response.json();
    } catch (error) {
        // Handle different error types
        if (error instanceof ValidationError) {
            console.error(`Validation error in ${error.field}:`, error.message);
        } else if (error instanceof AuthenticationError) {
            console.error("Auth error:", error.message);
            // Redirect to login
        } else if (error instanceof NetworkError) {
            console.error(`Network error (${error.status}):`, error.message);
        } else {
            console.error("Unexpected error:", error.message);
        }
        
        throw error;
    }
}
```

### Global Error Handling

**1. Unhandled Promise Rejections:**
```javascript
// Global handler for unhandled promise rejections
window.addEventListener('unhandledrejection', event => {
    console.error('Unhandled promise rejection:', event.reason);
    
    // Prevent the default behavior (logging to console)
    event.preventDefault();
    
    // You can send error to logging service
    // logErrorToService(event.reason);
});

// Example of unhandled rejection
async function createUnhandledRejection() {
    // This promise rejection won't be caught
    Promise.reject(new Error("This will trigger unhandledrejection event"));
}

createUnhandledRejection();
```

**2. Global Error Handler:**
```javascript
// Global error handler for synchronous errors
window.addEventListener('error', event => {
    console.error('Global error:', event.error);
    
    // Send to logging service
    // logErrorToService(event.error);
});

// Example usage
function createError() {
    throw new Error("This will trigger global error handler");
}

// This will be caught by global handler
setTimeout(createError, 1000);
```

### Error Recovery Patterns

**1. Retry with Exponential Backoff:**
```javascript
async function retry(operation, maxRetries = 3, baseDelay = 1000) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            return await operation();
        } catch (error) {
            if (attempt === maxRetries) {
                throw error; // Last attempt failed
            }
            
            const delay = baseDelay * Math.pow(2, attempt - 1);
            console.log(`Attempt ${attempt} failed, retrying in ${delay}ms...`);
            
            await new Promise(resolve => setTimeout(resolve, delay));
        }
    }
}

// Usage
async function unreliableOperation() {
    const success = Math.random() > 0.7; // 30% success rate
    
    if (success) {
        return "Success!";
    } else {
        throw new Error("Operation failed");
    }
}

retry(() => unreliableOperation())
    .then(result => console.log("Final result:", result))
    .catch(error => console.error("All retries failed:", error.message));
```

**2. Circuit Breaker Pattern:**
```javascript
class CircuitBreaker {
    constructor(threshold = 5, timeout = 60000) {
        this.threshold = threshold;
        this.timeout = timeout;
        this.failureCount = 0;
        this.lastFailureTime = null;
        this.state = 'CLOSED'; // CLOSED, OPEN, HALF_OPEN
    }
    
    async execute(operation) {
        if (this.state === 'OPEN') {
            if (Date.now() - this.lastFailureTime >= this.timeout) {
                this.state = 'HALF_OPEN';
            } else {
                throw new Error('Circuit breaker is OPEN');
            }
        }
        
        try {
            const result = await operation();
            this.onSuccess();
            return result;
        } catch (error) {
            this.onFailure();
            throw error;
        }
    }
    
    onSuccess() {
        this.failureCount = 0;
        this.state = 'CLOSED';
    }
    
    onFailure() {
        this.failureCount++;
        this.lastFailureTime = Date.now();
        
        if (this.failureCount >= this.threshold) {
            this.state = 'OPEN';
        }
    }
}

// Usage
const circuitBreaker = new CircuitBreaker(3, 5000); // 3 failures, 5s timeout

async function callExternalAPI() {
    try {
        return await circuitBreaker.execute(async () => {
            const response = await fetch('/api/external');
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}`);
            }
            return response.json();
        });
    } catch (error) {
        console.error("API call failed:", error.message);
        return { error: "Service unavailable" };
    }
}
```

## 7. Fetch API for HTTP Requests

### Basic Fetch Usage

```javascript
// Simple GET request
async function basicFetch() {
    try {
        const response = await fetch('https://jsonplaceholder.typicode.com/posts/1');
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        console.log(data);
    } catch (error) {
        console.error('Fetch error:', error.message);
    }
}

basicFetch();
```

### Fetch with Different HTTP Methods

```javascript
// GET request with query parameters
async function fetchWithParams() {
    const params = new URLSearchParams({
        userId: 1,
        limit: 10
    });
    
    const response = await fetch(`/api/posts?${params}`);
    return response.json();
}

// POST request
async function createPost(postData) {
    try {
        const response = await fetch('/api/posts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + getAuthToken()
            },
            body: JSON.stringify(postData)
        });
        
        if (!response.ok) {
            throw new Error(`Failed to create post: ${response.status}`);
        }
        
        return await response.json();
    } catch (error) {
        console.error('Error creating post:', error.message);
        throw error;
    }
}

// PUT request
async function updatePost(postId, postData) {
    const response = await fetch(`/api/posts/${postId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(postData)
    });
    
    return response.json();
}

// DELETE request
async function deletePost(postId) {
    const response = await fetch(`/api/posts/${postId}`, {
        method: 'DELETE'
    });
    
    if (response.ok) {
        console.log('Post deleted successfully');
    } else {
        throw new Error('Failed to delete post');
    }
}

// Usage examples
async function examples() {
    // Create a new post
    const newPost = await createPost({
        title: 'My New Post',
        body: 'This is the content of my post',
        userId: 1
    });
    
    // Update the post
    const updatedPost = await updatePost(newPost.id, {
        title: 'Updated Post Title',
        body: 'Updated content',
        userId: 1
    });
    
    // Delete the post
    await deletePost(newPost.id);
}
```

### Handling Different Response Types

```javascript
// JSON response
async function fetchJSON(url) {
    const response = await fetch(url);
    return response.json();
}

// Text response
async function fetchText(url) {
    const response = await fetch(url);
    return response.text();
}

// Blob response (for files)
async function fetchBlob(url) {
    const response = await fetch(url);
    return response.blob();
}

// ArrayBuffer response (for binary data)
async function fetchArrayBuffer(url) {
    const response = await fetch(url);
    return response.arrayBuffer();
}

// FormData response
async function fetchFormData(url) {
    const response = await fetch(url);
    return response.formData();
}

// Example: Download and display an image
async function displayImage(imageUrl, imgElement) {
    try {
        const response = await fetch(imageUrl);
        const blob = await response.blob();
        const imageObjectURL = URL.createObjectURL(blob);
        
        imgElement.src = imageObjectURL;
        
        // Clean up the object URL when done
        imgElement.onload = () => URL.revokeObjectURL(imageObjectURL);
    } catch (error) {
        console.error('Error loading image:', error);
    }
}
```

### File Upload with Fetch

```javascript
// Upload single file
async function uploadFile(file) {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('description', 'My uploaded file');
    
    try {
        const response = await fetch('/api/upload', {
            method: 'POST',
            body: formData // Don't set Content-Type header, let browser set it
        });
        
        if (!response.ok) {
            throw new Error(`Upload failed: ${response.status}`);
        }
        
        return await response.json();
    } catch (error) {
        console.error('Upload error:', error.message);
        throw error;
    }
}

// Upload multiple files
async function uploadMultipleFiles(files) {
    const formData = new FormData();
    
    for (let i = 0; i < files.length; i++) {
        formData.append('files', files[i]);
    }
    
    const response = await fetch('/api/upload-multiple', {
        method: 'POST',
        body: formData
    });
    
    return response.json();
}

// Upload with progress tracking
async function uploadWithProgress(file, onProgress) {
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        const formData = new FormData();
        formData.append('file', file);
        
        xhr.upload.addEventListener('progress', (event) => {
            if (event.lengthComputable) {
                const percentComplete = (event.loaded / event.total) * 100;
                onProgress(percentComplete);
            }
        });
        
        xhr.addEventListener('load', () => {
            if (xhr.status === 200) {
                resolve(JSON.parse(xhr.responseText));
            } else {
                reject(new Error(`Upload failed: ${xhr.status}`));
            }
        });
        
        xhr.addEventListener('error', () => {
            reject(new Error('Upload failed'));
        });
        
        xhr.open('POST', '/api/upload');
        xhr.send(formData);
    });
}

// Usage
document.getElementById('fileInput').addEventListener('change', async (event) => {
    const file = event.target.files[0];
    if (file) {
        try {
            const result = await uploadWithProgress(file, (progress) => {
                console.log(`Upload progress: ${progress.toFixed(2)}%`);
            });
            console.log('Upload successful:', result);
        } catch (error) {
            console.error('Upload failed:', error.message);
        }
    }
});
```

### Advanced Fetch Configuration

```javascript
// Fetch with timeout
async function fetchWithTimeout(url, timeout = 8000) {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);
    
    try {
        const response = await fetch(url, {
            signal: controller.signal
        });
        clearTimeout(timeoutId);
        return response;
    } catch (error) {
        if (error.name === 'AbortError') {
            throw new Error('Request timeout');
        }
        throw error;
    }
}

// Fetch with retry and exponential backoff
async function fetchWithRetry(url, options = {}, maxRetries = 3) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            const response = await fetch(url, options);
            
            // Retry on 5xx errors
            if (response.status >= 500 && attempt < maxRetries) {
                const delay = Math.pow(2, attempt - 1) * 1000;
                await new Promise(resolve => setTimeout(resolve, delay));
                continue;
            }
            
            return response;
        } catch (error) {
            if (attempt === maxRetries) {
                throw error;
            }
            
            const delay = Math.pow(2, attempt - 1) * 1000;
            await new Promise(resolve => setTimeout(resolve, delay));
        }
    }
}

// Fetch with caching
class FetchCache {
    constructor(maxAge = 300000) { // 5 minutes default
        this.cache = new Map();
        this.maxAge = maxAge;
    }
    
    async fetch(url, options = {}) {
        const key = JSON.stringify({ url, options });
        const cached = this.cache.get(key);
        
        if (cached && Date.now() - cached.timestamp < this.maxAge) {
            return cached.response.clone();
        }
        
        const response = await fetch(url, options);
        
        if (response.ok) {
            this.cache.set(key, {
                response: response.clone(),
                timestamp: Date.now()
            });
        }
        
        return response;
    }
    
    clear() {
        this.cache.clear();
    }
}

const cachedFetch = new FetchCache();

// Usage
async function getCachedData(url) {
    const response = await cachedFetch.fetch(url);
    return response.json();
}
```

### Request and Response Interceptors

```javascript
// Custom fetch wrapper with interceptors
class FetchInterceptor {
    constructor() {
        this.requestInterceptors = [];
        this.responseInterceptors = [];
    }
    
    addRequestInterceptor(interceptor) {
        this.requestInterceptors.push(interceptor);
    }
    
    addResponseInterceptor(interceptor) {
        this.responseInterceptors.push(interceptor);
    }
    
    async fetch(url, options = {}) {
        // Apply request interceptors
        let processedOptions = { ...options };
        for (const interceptor of this.requestInterceptors) {
            processedOptions = await interceptor(url, processedOptions);
        }
        
        // Make the request
        let response = await fetch(url, processedOptions);
        
        // Apply response interceptors
        for (const interceptor of this.responseInterceptors) {
            response = await interceptor(response);
        }
        
        return response;
    }
}

// Create instance and add interceptors
const api = new FetchInterceptor();

// Add authentication header to all requests
api.addRequestInterceptor(async (url, options) => {
    const token = localStorage.getItem('authToken');
    if (token) {
        options.headers = {
            ...options.headers,
            'Authorization': `Bearer ${token}`
        };
    }
    return options;
});

// Log all requests
api.addRequestInterceptor(async (url, options) => {
    console.log(`Making ${options.method || 'GET'} request to:`, url);
    return options;
});

// Handle 401 responses globally
api.addResponseInterceptor(async (response) => {
    if (response.status === 401) {
        console.log('Unauthorized, redirecting to login...');
        localStorage.removeItem('authToken');
        window.location.href = '/login';
    }
    return response;
});

// Log all responses
api.addResponseInterceptor(async (response) => {
    console.log(`Response ${response.status} from:`, response.url);
    return response;
});

// Usage
async function apiCall() {
    const response = await api.fetch('/api/protected-data');
    return response.json();
}
```

## 8. Working with Multiple Async Operations

### Concurrent vs Sequential Operations

```javascript
// Sequential operations (slower)
async function sequentialOperations() {
    console.time('Sequential');
    
    const user = await fetchUser(1);
    const posts = await fetchPosts(user.id);
    const comments = await fetchComments(posts[0].id);
    
    console.timeEnd('Sequential'); // ~3 seconds if each call takes 1 second
    
    return { user, posts, comments };
}

// Concurrent operations (faster)
async function concurrentOperations() {
    console.time('Concurrent');
    
    // Start all operations at the same time
    const userPromise = fetchUser(1);
    const postsPromise = userPromise.then(user => fetchPosts(user.id));
    const commentsPromise = postsPromise.then(posts => fetchComments(posts[0].id));
    
    // Wait for all to complete
    const [user, posts, comments] = await Promise.all([
        userPromise,
        postsPromise,
        commentsPromise
    ]);
    
    console.timeEnd('Concurrent'); // Still ~3 seconds due to dependencies
    
    return { user, posts, comments };
}

// Independent concurrent operations (fastest)
async function independentConcurrentOperations() {
    console.time('Independent Concurrent');
    
    // These operations don't depend on each other
    const [users, categories, settings] = await Promise.all([
        fetchUsers(),
        fetchCategories(),
        fetchSettings()
    ]);
    
    console.timeEnd('Independent Concurrent'); // ~1 second if all calls take 1 second each
    
    return { users, categories, settings };
}
```

### Batching Operations

```javascript
// Batch processing function
async function batchProcess(items, batchSize, processor) {
    const results = [];
    
    for (let i = 0; i < items.length; i += batchSize) {
        const batch = items.slice(i, i + batchSize);
        const batchPromises = batch.map(processor);
        const batchResults = await Promise.all(batchPromises);
        results.push(...batchResults);
        
        // Optional: Add delay between batches to avoid overwhelming the server
        if (i + batchSize < items.length) {
            await new Promise(resolve => setTimeout(resolve, 100));
        }
    }
    
    return results;
}

// Usage example
async function processUserBatch() {
    const userIds = Array.from({ length: 100 }, (_, i) => i + 1);
    
    const users = await batchProcess(
        userIds,
        10, // Process 10 users at a time
        async (userId) => {
            return await fetchUser(userId);
        }
    );
    
    console.log(`Processed ${users.length} users`);
    return users;
}
```

### Rate Limiting

```javascript
// Rate limiter class
class RateLimiter {
    constructor(maxConcurrent, minInterval = 0) {
        this.maxConcurrent = maxConcurrent;
        this.minInterval = minInterval;
        this.running = 0;
        this.queue = [];
        this.lastRun = 0;
    }
    
    async execute(fn) {
        return new Promise((resolve, reject) => {
            this.queue.push({ fn, resolve, reject });
            this.process();
        });
    }
    
    async process() {
        if (this.running >= this.maxConcurrent || this.queue.length === 0) {
            return;
        }
        
        const now = Date.now();
        const timeSinceLastRun = now - this.lastRun;
        
        if (timeSinceLastRun < this.minInterval) {
            setTimeout(() => this.process(), this.minInterval - timeSinceLastRun);
            return;
        }
        
        const { fn, resolve, reject } = this.queue.shift();
        this.running++;
        this.lastRun = Date.now();
        
        try {
            const result = await fn();
            resolve(result);
        } catch (error) {
            reject(error);
        } finally {
            this.running--;
            this.process(); // Process next item in queue
        }
    }
}

// Usage
const rateLimiter = new RateLimiter(3, 1000); // Max 3 concurrent, min 1 second between requests

async function rateLimitedApiCalls() {
    const userIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    
    const promises = userIds.map(id => 
        rateLimiter.execute(() => fetchUser(id))
    );
    
    const users = await Promise.all(promises);
    return users;
}
```

### Progress Tracking for Multiple Operations

```javascript
// Progress tracker for multiple async operations
class ProgressTracker {
    constructor(total, onProgress) {
        this.total = total;
        this.completed = 0;
        this.onProgress = onProgress;
    }
    
    increment() {
        this.completed++;
        const percentage = (this.completed / this.total) * 100;
        this.onProgress(this.completed, this.total, percentage);
    }
    
    async trackPromise(promise) {
        try {
            const result = await promise;
            this.increment();
            return result;
        } catch (error) {
            this.increment();
            throw error;
        }
    }
}

// Usage example
async function downloadMultipleFiles(urls) {
    const tracker = new ProgressTracker(urls.length, (completed, total, percentage) => {
        console.log(`Progress: ${completed}/${total} (${percentage.toFixed(1)}%)`);
        
        // Update UI progress bar
        const progressBar = document.getElementById('progressBar');
        if (progressBar) {
            progressBar.style.width = percentage + '%';
        }
    });
    
    const downloadPromises = urls.map(url => 
        tracker.trackPromise(downloadFile(url))
    );
    
    try {
        const results = await Promise.allSettled(downloadPromises);
        
        const successful = results.filter(r => r.status === 'fulfilled');
        const failed = results.filter(r => r.status === 'rejected');
        
        console.log(`Download complete: ${successful.length} successful, ${failed.length} failed`);
        
        return {
            successful: successful.map(r => r.value),
            failed: failed.map(r => r.reason)
        };
    } catch (error) {
        console.error('Unexpected error:', error);
        throw error;
    }
}

async function downloadFile(url) {
    const response = await fetch(url);
    if (!response.ok) {
        throw new Error(`Failed to download ${url}: ${response.status}`);
    }
    return await response.blob();
}
```

### Worker Threads for CPU-Intensive Tasks

```javascript
// Using Web Workers for CPU-intensive tasks
class WorkerPool {
    constructor(workerScript, poolSize = navigator.hardwareConcurrency || 4) {
        this.workers = [];
        this.queue = [];
        this.busyWorkers = new Set();
        
        for (let i = 0; i < poolSize; i++) {
            const worker = new Worker(workerScript);
            this.workers.push(worker);
        }
    }
    
    async execute(data) {
        return new Promise((resolve, reject) => {
            this.queue.push({ data, resolve, reject });
            this.processQueue();
        });
    }
    
    processQueue() {
        if (this.queue.length === 0) {
            return;
        }
        
        const availableWorker = this.workers.find(w => !this.busyWorkers.has(w));
        if (!availableWorker) {
            return;
        }
        
        const { data, resolve, reject } = this.queue.shift();
        this.busyWorkers.add(availableWorker);
        
        const handleMessage = (event) => {
            availableWorker.removeEventListener('message', handleMessage);
            availableWorker.removeEventListener('error', handleError);
            this.busyWorkers.delete(availableWorker);
            resolve(event.data);
            this.processQueue();
        };
        
        const handleError = (error) => {
            availableWorker.removeEventListener('message', handleMessage);
            availableWorker.removeEventListener('error', handleError);
            this.busyWorkers.delete(availableWorker);
            reject(error);
            this.processQueue();
        };
        
        availableWorker.addEventListener('message', handleMessage);
        availableWorker.addEventListener('error', handleError);
        availableWorker.postMessage(data);
    }
    
    terminate() {
        this.workers.forEach(worker => worker.terminate());
    }
}

// worker.js file content:
/*
self.addEventListener('message', function(event) {
    const data = event.data;
    
    // Simulate CPU-intensive work
    const result = heavyComputation(data);
    
    self.postMessage(result);
});

function heavyComputation(input) {
    // Perform heavy computation here
    let result = 0;
    for (let i = 0; i < input.iterations; i++) {
        result += Math.sqrt(i) * Math.sin(i);
    }
    return result;
}
*/

// Usage
async function processLargeDataset() {
    const workerPool = new WorkerPool('worker.js', 4);
    
    const tasks = Array.from({ length: 100 }, (_, i) => ({
        iterations: 1000000,
        id: i
    }));
    
    try {
        console.time('Worker Pool Processing');
        
        const results = await Promise.all(
            tasks.map(task => workerPool.execute(task))
        );
        
        console.timeEnd('Worker Pool Processing');
        console.log('All tasks completed:', results.length);
        
        return results;
    } finally {
        workerPool.terminate();
    }
}
```

## 9. Performance Considerations

### Optimizing Async Operations

**1. Avoid Unnecessary await:**
```javascript
// Inefficient: waiting unnecessarily
async function inefficient() {
    const data1 = await fetchData1();
    const data2 = await fetchData2(); // This doesn't depend on data1
    const data3 = await fetchData3(); // This doesn't depend on data1 or data2
    
    return [data1, data2, data3];
}

// Efficient: start all operations concurrently
async function efficient() {
    const [data1, data2, data3] = await Promise.all([
        fetchData1(),
        fetchData2(),
        fetchData3()
    ]);
    
    return [data1, data2, data3];
}
```

**2. Early Return Patterns:**
```javascript
// Return early when possible
async function earlyReturn(userId) {
    // Check cache first
    const cachedUser = getFromCache(userId);
    if (cachedUser) {
        return cachedUser; // Early return avoids unnecessary async operations
    }
    
    // Only fetch if not in cache
    const user = await fetchUser(userId);
    setCache(userId, user);
    return user;
}

// Conditional async operations
async function conditionalAsync(condition, data) {
    if (!condition) {
        return data; // No async operation needed
    }
    
    return await processData(data);
}
```

**3. Streaming and Progressive Loading:**
```javascript
// Progressive data loading
async function* progressiveDataLoader(dataSource) {
    let page = 1;
    const pageSize = 20;
    
    while (true) {
        const data = await fetchPage(dataSource, page, pageSize);
        
        if (data.length === 0) {
            break; // No more data
        }
        
        yield data; // Yield each page as it's loaded
        page++;
    }
}

// Usage with progressive loading
async function displayProgressiveData() {
    const dataLoader = progressiveDataLoader('users');
    
    for await (const batch of dataLoader) {
        displayBatch(batch);
        
        // Give the UI time to update
        await new Promise(resolve => setTimeout(resolve, 0));
    }
}

// Streaming JSON processing
async function processLargeJSONStream(response) {
    const reader = response.body.getReader();
    const decoder = new TextDecoder();
    let buffer = '';
    
    while (true) {
        const { done, value } = await reader.read();
        
        if (done) {
            break;
        }
        
        buffer += decoder.decode(value, { stream: true });
        
        // Process complete JSON objects as they arrive
        let boundaryIndex;
        while ((boundaryIndex = buffer.indexOf('\n')) !== -1) {
            const line = buffer.slice(0, boundaryIndex);
            buffer = buffer.slice(boundaryIndex + 1);
            
            if (line.trim()) {
                try {
                    const obj = JSON.parse(line);
                    await processObject(obj);
                } catch (error) {
                    console.error('Failed to parse JSON:', error);
                }
            }
        }
    }
}
```

### Memory Management

**1. Avoiding Memory Leaks:**
```javascript
// Bad: Creates memory leak with listeners
class BadAsyncComponent {
    constructor() {
        this.listeners = [];
    }
    
    async init() {
        const data = await fetchData();
        
        // Memory leak: listener is never removed
        window.addEventListener('resize', this.handleResize.bind(this));
        
        this.processData(data);
    }
    
    handleResize() {
        // Handler logic
    }
}

// Good: Proper cleanup
class GoodAsyncComponent {
    constructor() {
        this.abortController = new AbortController();
        this.cleanupFunctions = [];
    }
    
    async init() {
        try {
            const data = await fetchData({
                signal: this.abortController.signal
            });
            
            // Use AbortController signal for event listeners
            const handleResize = this.handleResize.bind(this);
            window.addEventListener('resize', handleResize, {
                signal: this.abortController.signal
            });
            
            this.processData(data);
        } catch (error) {
            if (error.name !== 'AbortError') {
                console.error('Init failed:', error);
            }
        }
    }
    
    destroy() {
        // Cleanup all async operations
        this.abortController.abort();
        
        // Run custom cleanup functions
        this.cleanupFunctions.forEach(cleanup => cleanup());
        this.cleanupFunctions = [];
    }
    
    handleResize() {
        // Handler logic
    }
}
```

**2. Canceling Async Operations:**
```javascript
// Using AbortController for cancellation
class CancellableOperations {
    constructor() {
        this.activeOperations = new Map();
    }
    
    async startOperation(operationId, operation) {
        // Cancel existing operation with same ID
        this.cancelOperation(operationId);
        
        const controller = new AbortController();
        this.activeOperations.set(operationId, controller);
        
        try {
            const result = await operation(controller.signal);
            this.activeOperations.delete(operationId);
            return result;
        } catch (error) {
            this.activeOperations.delete(operationId);
            if (error.name === 'AbortError') {
                console.log(`Operation ${operationId} was cancelled`);
                return null;
            }
            throw error;
        }
    }
    
    cancelOperation(operationId) {
        const controller = this.activeOperations.get(operationId);
        if (controller) {
            controller.abort();
            this.activeOperations.delete(operationId);
        }
    }
    
    cancelAllOperations() {
        for (const [id, controller] of this.activeOperations) {
            controller.abort();
        }
        this.activeOperations.clear();
    }
}

// Usage example
const operations = new CancellableOperations();

async function searchWithCancellation(query) {
    return operations.startOperation('search', async (signal) => {
        const response = await fetch(`/api/search?q=${query}`, { signal });
        return response.json();
    });
}

// Search input handler with debouncing and cancellation
let searchTimeout;
document.getElementById('searchInput').addEventListener('input', (event) => {
    clearTimeout(searchTimeout);
    
    searchTimeout = setTimeout(async () => {
        const query = event.target.value.trim();
        if (query) {
            try {
                const results = await searchWithCancellation(query);
                if (results) {
                    displaySearchResults(results);
                }
            } catch (error) {
                console.error('Search failed:', error);
            }
        }
    }, 300); // 300ms debounce
});
```

### Caching Strategies

**1. In-Memory Caching:**
```javascript
class AsyncCache {
    constructor(maxSize = 100, ttl = 300000) { // 5 minutes TTL
        this.cache = new Map();
        this.maxSize = maxSize;
        this.ttl = ttl;
        this.timers = new Map();
    }
    
    async get(key, factory) {
        // Check if we have a cached value
        if (this.cache.has(key)) {
            return this.cache.get(key);
        }
        
        // Generate the value using the factory function
        const value = await factory();
        
        // Store in cache
        this.set(key, value);
        
        return value;
    }
    
    set(key, value) {
        // Remove oldest entries if cache is full
        if (this.cache.size >= this.maxSize) {
            const firstKey = this.cache.keys().next().value;
            this.delete(firstKey);
        }
        
        this.cache.set(key, value);
        
        // Set TTL timer
        const timer = setTimeout(() => {
            this.delete(key);
        }, this.ttl);
        
        this.timers.set(key, timer);
    }
    
    delete(key) {
        this.cache.delete(key);
        
        const timer = this.timers.get(key);
        if (timer) {
            clearTimeout(timer);
            this.timers.delete(key);
        }
    }
    
    clear() {
        this.cache.clear();
        this.timers.forEach(timer => clearTimeout(timer));
        this.timers.clear();
    }
}

// Usage
const cache = new AsyncCache(50, 600000); // 50 items, 10 minutes TTL

async function getCachedUser(userId) {
    return cache.get(`user:${userId}`, async () => {
        console.log(`Fetching user ${userId} from API`);
        return await fetchUser(userId);
    });
}
```

**2. Browser Storage Caching:**
```javascript
class PersistentAsyncCache {
    constructor(prefix = 'cache:', ttl = 3600000) { // 1 hour TTL
        this.prefix = prefix;
        this.ttl = ttl;
    }
    
    async get(key, factory) {
        const cacheKey = this.prefix + key;
        
        try {
            const cached = localStorage.getItem(cacheKey);
            if (cached) {
                const { data, timestamp } = JSON.parse(cached);
                
                // Check if cache is still valid
                if (Date.now() - timestamp < this.ttl) {
                    return data;
                }
                
                // Cache expired, remove it
                localStorage.removeItem(cacheKey);
            }
        } catch (error) {
            console.warn('Failed to read from cache:', error);
        }
        
        // Generate new value
        const value = await factory();
        
        // Store in cache
        try {
            localStorage.setItem(cacheKey, JSON.stringify({
                data: value,
                timestamp: Date.now()
            }));
        } catch (error) {
            console.warn('Failed to write to cache:', error);
        }
        
        return value;
    }
    
    clear(pattern) {
        const keys = Object.keys(localStorage);
        const prefixToMatch = this.prefix + (pattern || '');
        
        keys.forEach(key => {
            if (key.startsWith(prefixToMatch)) {
                localStorage.removeItem(key);
            }
        });
    }
}
```

### Performance Monitoring

**1. Timing Async Operations:**
```javascript
class PerformanceMonitor {
    constructor() {
        this.metrics = new Map();
    }
    
    async measure(name, operation) {
        const startTime = performance.now();
        
        try {
            const result = await operation();
            const duration = performance.now() - startTime;
            
            this.recordMetric(name, duration, 'success');
            console.log(`${name} completed in ${duration.toFixed(2)}ms`);
            
            return result;
        } catch (error) {
            const duration = performance.now() - startTime;
            
            this.recordMetric(name, duration, 'error');
            console.error(`${name} failed after ${duration.toFixed(2)}ms:`, error);
            
            throw error;
        }
    }
    
    recordMetric(name, duration, status) {
        if (!this.metrics.has(name)) {
            this.metrics.set(name, {
                calls: 0,
                totalTime: 0,
                errors: 0,
                minTime: Infinity,
                maxTime: 0
            });
        }
        
        const metric = this.metrics.get(name);
        metric.calls++;
        metric.totalTime += duration;
        metric.minTime = Math.min(metric.minTime, duration);
        metric.maxTime = Math.max(metric.maxTime, duration);
        
        if (status === 'error') {
            metric.errors++;
        }
    }
    
    getMetrics(name) {
        const metric = this.metrics.get(name);
        if (!metric) return null;
        
        return {
            ...metric,
            averageTime: metric.totalTime / metric.calls,
            errorRate: metric.errors / metric.calls
        };
    }
    
    getAllMetrics() {
        const result = {};
        for (const [name, metric] of this.metrics) {
            result[name] = this.getMetrics(name);
        }
        return result;
    }
}

// Usage
const monitor = new PerformanceMonitor();

async function monitoredFetch(url) {
    return monitor.measure(`fetch:${url}`, async () => {
        const response = await fetch(url);
        return response.json();
    });
}

// Generate performance report
setInterval(() => {
    const metrics = monitor.getAllMetrics();
    console.table(metrics);
}, 30000); // Log metrics every 30 seconds
```

**2. Resource Usage Monitoring:**
```javascript
class ResourceMonitor {
    constructor() {
        this.startTime = performance.now();
        this.startMemory = this.getMemoryUsage();
    }
    
    getMemoryUsage() {
        if ('memory' in performance) {
            return {
                used: performance.memory.usedJSHeapSize,
                total: performance.memory.totalJSHeapSize,
                limit: performance.memory.jsHeapSizeLimit
            };
        }
        return null;
    }
    
    getNetworkInfo() {
        if ('connection' in navigator) {
            return {
                effectiveType: navigator.connection.effectiveType,
                downlink: navigator.connection.downlink,
                rtt: navigator.connection.rtt
            };
        }
        return null;
    }
    
    async measureResourceUsage(operation) {
        const beforeMemory = this.getMemoryUsage();
        const beforeTime = performance.now();
        
        const result = await operation();
        
        const afterTime = performance.now();
        const afterMemory = this.getMemoryUsage();
        
        const report = {
            duration: afterTime - beforeTime,
            memory: afterMemory && beforeMemory ? {
                delta: afterMemory.used - beforeMemory.used,
                before: beforeMemory.used,
                after: afterMemory.used
            } : null,
            network: this.getNetworkInfo()
        };
        
        console.log('Resource usage report:', report);
        return { result, report };
    }
}

// Usage
const resourceMonitor = new ResourceMonitor();

async function heavyOperation() {
    const { result, report } = await resourceMonitor.measureResourceUsage(async () => {
        // Simulate heavy operation
        const data = await Promise.all(
            Array.from({ length: 1000 }, () => fetch('/api/data'))
        );
        return data;
    });
    
    if (report.memory && report.memory.delta > 10 * 1024 * 1024) { // 10MB
        console.warn('Operation used significant memory:', report.memory.delta);
    }
    
    return result;
}
```

### Optimizing Promise Chains

**1. Efficient Promise Composition:**
```javascript
// Inefficient: Creating unnecessary intermediate promises
async function inefficientChain(userId) {
    return await Promise.resolve(userId)
        .then(id => fetchUser(id))
        .then(user => Promise.resolve(user))
        .then(user => fetchPosts(user.id))
        .then(posts => Promise.resolve(posts));
}

// Efficient: Direct async/await
async function efficientChain(userId) {
    const user = await fetchUser(userId);
    const posts = await fetchPosts(user.id);
    return posts;
}

// Efficient: When you need promise composition
function efficientPromiseChain(userId) {
    return fetchUser(userId)
        .then(user => fetchPosts(user.id));
}
```

**2. Avoiding Promise Constructor Anti-pattern:**
```javascript
// Anti-pattern: Wrapping async functions in Promise constructor
function antiPattern() {
    return new Promise(async (resolve, reject) => {
        try {
            const result = await someAsyncOperation();
            resolve(result);
        } catch (error) {
            reject(error);
        }
    });
}

// Correct: Just return the async function result
async function correctPattern() {
    return await someAsyncOperation();
}

// Or even simpler:
function correctPattern2() {
    return someAsyncOperation();
}
```

**3. Promise Pool for Controlled Concurrency:**
```javascript
class PromisePool {
    constructor(concurrency = 3) {
        this.concurrency = concurrency;
        this.running = 0;
        this.queue = [];
    }
    
    async add(promiseFactory) {
        return new Promise((resolve, reject) => {
            this.queue.push({
                promiseFactory,
                resolve,
                reject
            });
            
            this.process();
        });
    }
    
    async process() {
        if (this.running >= this.concurrency || this.queue.length === 0) {
            return;
        }
        
        this.running++;
        const { promiseFactory, resolve, reject } = this.queue.shift();
        
        try {
            const result = await promiseFactory();
            resolve(result);
        } catch (error) {
            reject(error);
        } finally {
            this.running--;
            this.process(); // Process next item in queue
        }
    }
    
    async all(promiseFactories) {
        const promises = promiseFactories.map(factory => this.add(factory));
        return Promise.all(promises);
    }
}

// Usage
const pool = new PromisePool(5); // Max 5 concurrent operations

async function processLargeList(items) {
    const promiseFactories = items.map(item => 
        () => processItem(item)
    );
    
    return pool.all(promiseFactories);
}
```

### Best Practices Summary

1. **Use Promise.all() for independent concurrent operations**
2. **Implement proper error handling with try-catch**
3. **Use AbortController for cancellable operations**
4. **Cache results to avoid redundant API calls**
5. **Monitor performance and resource usage**
6. **Use rate limiting for API calls**
7. **Implement timeouts for long-running operations**
8. **Clean up resources and event listeners**
9. **Use streaming for large data sets**
10. **Prefer async/await over promise chains for readability**

These concepts form the foundation of effective asynchronous JavaScript programming and will help build robust, performant web applications.