# 🎯 Mini Project Assignments

This document contains practical assignments to practice PHP, MySQL, and OOP concepts. Complete these projects to strengthen your understanding of web development fundamentals.

---

## 📋 Assignment Instructions

### Prerequisites:
- Basic PHP knowledge
- MySQL database setup
- Understanding of HTML/CSS
- Web server (XAMPP/WAMP/MAMP or PHP built-in server)

### Submission Guidelines:
- Create separate folders for each project
- Include complete source code
- Document your code with comments
- Follow proper naming conventions

---

## 🎪 Project 1: Personal Expense Tracker (Basic PHP + MySQL)

### 📖 Project Description
Create a simple web application to track personal daily expenses. This project focuses on basic CRUD operations, form handling, and database interactions without advanced OOP concepts.

### 🎯 Learning Objectives
- Form handling and validation
- MySQL database operations
- Basic PHP programming
- Session management
- Data sanitization and security

### ✅ Requirements

#### Core Features:
1. **Add Expense**
   - Form to add new expense with: Date, Category, Amount, Description
   - Categories: Food, Transport, Entertainment, Shopping, Bills, Others
   - Input validation and error handling

2. **View Expenses**
   - Display all expenses in a table format
   - Show: Date, Category, Amount, Description, Actions
   - Pagination (10 records per page)

3. **Edit/Update Expense**
   - Edit existing expense records
   - Pre-populate form with existing data
   - Update confirmation

4. **Delete Expense**
   - Delete individual expenses
   - Confirmation before deletion

5. **Dashboard**
   - Total expenses this month
   - Total expenses this year
   - Category-wise expense breakdown
   - Recent 5 expenses

#### Additional Features:
6. **Search & Filter**
   - Search by description
   - Filter by category
   - Filter by date range

7. **Reports**
   - Monthly expense report
   - Category-wise expense chart (simple HTML/CSS chart)
   - Export to CSV

### 🗄️ Database Schema

```sql
CREATE DATABASE expense_tracker;

USE expense_tracker;

CREATE TABLE expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    category VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO expenses (date, category, amount, description) VALUES
('2024-01-15', 'Food', 250.00, 'Lunch at restaurant'),
('2024-01-15', 'Transport', 50.00, 'Bus fare'),
('2024-01-16', 'Shopping', 1200.00, 'Groceries'),
('2024-01-17', 'Entertainment', 300.00, 'Movie tickets'),
('2024-01-18', 'Bills', 2500.00, 'Electricity bill');
```

### 📁 Suggested File Structure

```
expense_tracker/
├── config/
│   └── database.php          # Database connection
├── includes/
│   ├── header.php            # Common header
│   ├── footer.php            # Common footer
│   └── functions.php         # Helper functions
├── css/
│   └── style.css             # Styling
├── js/
│   └── script.js             # JavaScript (optional)
├── index.php                 # Dashboard/Home page
├── add_expense.php           # Add new expense
├── view_expenses.php         # List all expenses
├── edit_expense.php          # Edit expense
├── delete_expense.php        # Delete expense
├── search.php                # Search and filter
├── reports.php               # Reports page
├── export_csv.php            # CSV export
└── README.md                 # Project documentation
```

### 🎨 UI/UX Requirements
- Clean and responsive design
- User-friendly forms with proper validation
- Visual feedback for actions (success/error messages)
- Simple dashboard with summary cards
- Mobile-friendly layout

### 💡 Technical Tips
- Use prepared statements for database queries
- Implement proper input validation and sanitization
- Use sessions for user feedback messages
- Handle errors gracefully
- Add proper comments to your code

### 🏆 Bonus Features (Optional)
- **Budget Planning**: Set monthly budget and track progress
- **Recurring Expenses**: Add support for recurring monthly expenses
- **Multiple Users**: Simple login system for multiple users
- **Email Alerts**: Send email when monthly budget is exceeded
- **Backup/Restore**: Export/import all data

---

## 🏪 Project 2: Library Management System (Advanced OOP + MySQL)

### 📖 Project Description
Develop a comprehensive library management system using advanced OOP concepts including interfaces, abstract classes, inheritance, and design patterns. This project demonstrates real-world application of object-oriented programming principles.

### 🎯 Learning Objectives
- Advanced OOP concepts (Abstract classes, Interfaces, Inheritance)
- Design patterns (Singleton, Factory, Repository)
- Code organization and architecture
- Database abstraction
- User authentication and authorization

### ✅ Requirements

#### Core Features:

1. **User Management**
   - Admin, Librarian, and Member user types
   - User registration and authentication
   - Role-based access control
   - Profile management

2. **Book Management**
   - Add/Edit/Delete books
   - Book categories and authors
   - Book search and filtering
   - ISBN validation
   - Book availability tracking

3. **Member Management**
   - Member registration
   - Member profile management
   - Membership status tracking
   - Member search functionality

4. **Book Issue/Return System**
   - Issue books to members
   - Return book functionality
   - Due date tracking
   - Fine calculation for overdue books
   - Issue history tracking

5. **Reports & Analytics**
   - Most popular books
   - Member activity reports
   - Overdue books report
   - Fine collection reports

#### Advanced Features:

6. **Reservation System**
   - Book reservation when not available
   - Reservation queue management
   - Automatic notifications

7. **Digital Library**
   - Upload and manage e-books (PDF)
   - Online reading interface
   - Download tracking

### 🗄️ Database Schema

```sql
CREATE DATABASE library_management;

USE library_management;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'librarian', 'member') NOT NULL,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    member_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    membership_date DATE NOT NULL,
    membership_expiry DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    biography TEXT,
    birth_date DATE,
    nationality VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    publisher VARCHAR(100),
    publication_year YEAR,
    pages INT,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    description TEXT,
    cover_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE book_issues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('issued', 'returned', 'overdue') DEFAULT 'issued',
    issued_by INT NOT NULL,
    returned_to INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (issued_by) REFERENCES users(id),
    FOREIGN KEY (returned_to) REFERENCES users(id)
);

CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    status ENUM('active', 'fulfilled', 'cancelled') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);
```

### 📁 Required OOP Structure

```
library_management/
├── config/
│   └── Database.php              # Singleton Database connection
├── interfaces/
│   ├── UserInterface.php         # User contract
│   ├── BookInterface.php         # Book operations contract
│   ├── Searchable.php           # Search functionality
│   ├── Exportable.php           # Export functionality
│   └── Authenticatable.php      # Authentication contract
├── abstract/
│   ├── AbstractUser.php          # Base user class
│   ├── AbstractRepository.php    # Base repository pattern
│   └── AbstractModel.php         # Base model class
├── classes/
│   ├── User.php                  # Base user class
│   ├── Admin.php                 # Admin user (extends User)
│   ├── Librarian.php            # Librarian user (extends User)
│   ├── Member.php               # Member user (extends User)
│   ├── Book.php                 # Book model
│   ├── Author.php               # Author model
│   ├── Category.php             # Category model
│   ├── BookIssue.php           # Book issue model
│   └── Reservation.php          # Reservation model
├── repositories/
│   ├── UserRepository.php        # User data operations
│   ├── BookRepository.php        # Book data operations
│   ├── MemberRepository.php      # Member data operations
│   └── IssueRepository.php       # Issue data operations
├── factories/
│   ├── UserFactory.php          # User creation factory
│   └── BookFactory.php          # Book creation factory
├── services/
│   ├── AuthService.php          # Authentication service
│   ├── BookService.php          # Book business logic
│   ├── IssueService.php         # Issue management service
│   └── ReportService.php        # Report generation service
├── final/
│   ├── Config.php               # Configuration management
│   ├── Logger.php               # Logging system
│   └── Validator.php            # Input validation
├── views/
│   ├── dashboard/               # Dashboard views
│   ├── books/                   # Book management views
│   ├── members/                 # Member management views
│   ├── issues/                  # Issue management views
│   └── reports/                 # Report views
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
├── index.php                    # Main application
├── login.php                    # Login page
├── logout.php                   # Logout handler
└── README.md                    # Project documentation
```

### 🎨 Required OOP Concepts

#### 1. Abstract Classes
```php
abstract class AbstractUser {
    abstract public function getRole();
    abstract public function getPermissions();
    abstract public function getDashboardData();

    // Concrete methods
    final public function getAccountInfo() { ... }
}
```

#### 2. Interfaces
```php
interface Searchable {
    public function search($criteria);
    public function getSearchableFields();
}

interface Exportable {
    public function exportToJson();
    public function exportToCsv();
    public function exportToPdf();
}
```

#### 3. Final Classes
```php
final class Config {
    private static $instance = null;

    public static function get($key) { ... }
    final public static function getDatabaseConfig() { ... }
}
```

#### 4. Static Methods
```php
class Validator {
    public static function validateISBN($isbn) { ... }
    public static function validateEmail($email) { ... }
    public static function sanitizeInput($input) { ... }
}
```

#### 5. Multiple Interface Implementation
```php
class Book extends AbstractModel implements Searchable, Exportable {
    // Implement all interface methods
}
```

## 📚 Learning Resources

### PHP & MySQL Basics
- [PHP Official Documentation](https://www.php.net/docs.php)
- [MySQL Tutorial](https://dev.mysql.com/doc/)
- [W3Schools PHP Tutorial](https://www.w3schools.com/php/)

### OOP in PHP
- [PHP OOP Tutorial](https://www.php.net/manual/en/language.oop5.php)
- [OOP Design Patterns](https://designpatternsphp.readthedocs.io/)
- [SOLID Principles in PHP](https://laracasts.com/series/solid-principles-in-php)

### Web Development
- [Bootstrap Documentation](https://getbootstrap.com/docs/)
- [MDN Web Docs](https://developer.mozilla.org/)
- [JavaScript Tutorial](https://javascript.info/)

---

## 📝 Submission Format

### Required Files:
1. **Complete source code** in organized folders
2. **Database SQL file** with sample data
3. **README.md** with:
   - Setup instructions
   - Feature list
   - Screenshots
   - Challenges faced
   - Future improvements
4. **Documentation** explaining OOP concepts used (Project 2)

### Submission Method:
- Create a ZIP file with project folder
- Include both projects in separate folders
- Name format: `StudentName_PHPProjects.zip`
- Submit via email or learning management system

---

## 🎉 Good Luck!

These projects will give you hands-on experience with:
- **Real-world application development**
- **Database design and operations**
- **Object-oriented programming concepts**
- **Web security best practices**
- **User interface design**
- **Problem-solving skills**

Remember: The goal is to learn and understand the concepts, not just to complete the assignments. Take time to experiment, ask questions, and explore beyond the basic requirements!

**Happy Coding! 🚀**