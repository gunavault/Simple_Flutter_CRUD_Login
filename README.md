# Flutter CRUD with Login

This is a Flutter project that demonstrates a basic CRUD (Create, Read, Update, Delete) application with login functionality. The app interacts with a simple PHP API to perform CRUD operations on a database.

## Features

- User authentication: Allows users to log in and access CRUD functionality.
- Create: Users can add new data to the database.
- Read: Displays the existing data from the database.
- Update: Users can edit and update the data.
- Delete: Users can delete specific data entries.

## Technologies Used

- Flutter: A popular cross-platform framework for building mobile applications.
- PHP: Used to create a simple API for interacting with the database.

## API

The API for this project is implemented using PHP. You can find the API code in the [SIMPLE API ](https://github.com/Gunarchive/simple_api) directory. The API consists of several PHP files that handle different CRUD operations:

- `conn.php`: Establishes the database connection and also get data.
- `login.php`: Handles user authentication and login.
- `Register.php`:  user Registration
- `post.php`: Handles the creation of new data entries.
- `update.php`: Handles updating the data.
- `delete.php`: Handles deleting specific data entries.

## Installation

1. Clone the repository:
   shell
   ```git clone https://github.com/Gunarchive/Simple_Flutter_CRUD_Login.git```
2. Open the project in your preferred Flutter development environment (e.g., Android Studio, Visual Studio Code).

3. Install the dependencies by running the following command in the project root:
```flutter pub get```
4. Update the API endpoint URLs:
    In the Flutter project, locate the files where API requests are made (e.g., login.dart, editdata.dart). Replace the API endpoint URLs (e.g., http://yourip/api/login.php) with the appropriate URLs for your PHP server.


Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

License
This project is licensed under the MIT License.

```
Feel free to customize the content as per your requirements and provide the appropriate API endpoint URLs in the installation instructions.
```
