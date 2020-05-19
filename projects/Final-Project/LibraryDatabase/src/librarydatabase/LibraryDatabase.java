/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package librarydatabase;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mesomaesonwune
 */
public class LibraryDatabase
{

    // Hostname
    private static final String dbHost = "127.0.0.1";
// Port -- Standard: 3306
    private static final String dbPort = "3306";
// Database name
    private static String database = "LibrarySystemFinal"; //
// Database user
    private static final String dbUser = "root";
// Datenbankpassword
    private static final String dbPassword = "Meghan909!";

    private Statement state;
    private File createSQLScript;
    private File insertSQLScript;
    private Scanner reader = new Scanner(System.in);

    /**
     * @param args the command line arguments
     */
    public void Connect()
    {
        createSQLScript = new File("../LibraryDatabase/src/librarydatabase/Resources/Dump20200516.sql");
        insertSQLScript = new File("../LibraryDatabase/src/librarydatabase/Resources/beginningInserts.sql");

        try {
            Class.forName("java.sql.Driver"); // load driver

            //first we need to make the database
            System.out.println("Connecting to database...");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/", dbUser, dbPassword);
            System.out.println("Database Connection Successful\n");

            System.out.println("Creating database...");
            state = conn.createStatement();

            //drop the schema if it exists already
            String sql = "DROP SCHEMA IF EXISTS LibrarySystemFinal";
            state.executeUpdate(sql);

            //create the database
            sql = "CREATE DATABASE LibrarySystemFinal";
            state.executeUpdate(sql);
            System.out.println("Database created successfully...");

            //then connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://" + dbHost + ":"
                    + dbPort + "/" + database + "?" + "user=" + dbUser + "&"
                    + "password=" + dbPassword); // try to connect with your attributes 
            System.out.println("Library Database Connection Successful\n");

            //run the creation of the tables 
            try {
                executeScript(conn, createSQLScript);
                System.out.println("Tables Connection Successful\n");
            } catch (Error e) {
                System.out.println("Create Tables for LibrarySystemFinal Not Possible" + e);
            }

            //run the creation of the data in the tables
            try {
                //this will give a syntas error but will still insert data
                executeInsertScript(conn, insertSQLScript);
                System.out.println("Insert Statements Successful\n");
            } catch (Error e) {
                System.out.println("Insert Statements Not Successful" + e);
            }

        } catch (ClassNotFoundException e) { // 
            System.out.println("Error: Driver not found!");
            Logger.getLogger(LibraryDatabase.class.getName()).log(Level.SEVERE, null, e);
        } catch (SQLException e) {
            System.out.println("Error: SQL Connect not possible");
            Logger.getLogger(LibraryDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public boolean userCreate()
    {
        boolean done = false;
        String query = "INSERT INTO User (" + " firstName," + " lastName," + " DOB ) VALUES (" + "?, ?, ?)";
        //String query2 = "INSERT INTO Registered (" + " firstName," + " lastName," + " DOB ) VALUES (" + "?, ?, ?)";
        boolean input = false;
        System.out.println("Welcome to the Library! Please insert your information to create an account!\n");

        System.out.print("What is your first and last name? ");
        String fullName = reader.nextLine();
        String[] nameSplit = fullName.split("\\s+"); //if namesplit.size == 1 error
        //for (String word : nameSplit) {System.out.println(word);}

        System.out.print("What is your birthdate (Format YYYY-MM-DD)?  ");
        String DOB = reader.nextLine();

        System.out.print("What is your email address?  ");
        String emailAdd = reader.next();

        System.out.print("What is your password?  ");
        String password = reader.next();

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://" + dbHost + ":"
                    + dbPort + "/" + database + "?" + "user=" + dbUser + "&"
                    + "password=" + dbPassword);
            PreparedStatement st = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, nameSplit[0]);
            st.setString(2, nameSplit[1]);
            st.setString(3, DOB);

            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected");
            }

            int userID = 0;
            ResultSet generatedKeys = st.getGeneratedKeys();
            if (generatedKeys.next()) {
                userID = (generatedKeys.getInt(1));
            }
            generatedKeys.close();
            st.close();

            query = "INSERT INTO Registered (" + " email," + " pswd," + " fk_userID) VALUES (" + "?, ?, ?)";
            st = conn.prepareStatement(query);
            st.setString(1, emailAdd);
            st.setString(2, password);
            st.setInt(3, userID);

            affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating Registered failed, no rows affected");
            }

            st.close();

            System.out.println("Your account has been successfuly made.\nYour login information is your email and password.\n\n");
        } catch (SQLException e) {
            Logger.getLogger(LibraryDatabase.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } catch (ArrayIndexOutOfBoundsException e) {
            Logger.getLogger(LibraryDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return true;
    }

    public void userLogin()
    {
        System.out.println("Welcome to the Library login page! Please insert your information to login!\n");

        System.out.print("What is your email address?  ");
        String emailAdd = reader.next();

        System.out.print("What is your password?  ");
        String password = reader.next();
        System.out.println("");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://" + dbHost + ":"
                    + dbPort + "/" + database + "?" + "user=" + dbUser + "&"
                    + "password=" + dbPassword);
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stmt.executeUpdate("USE " + database);

            String st = ("SELECT * FROM Registered WHERE email='" + emailAdd + "' AND pswd='" + password + "'");

            ResultSet rs = stmt.executeQuery(st);

            if (rs.next() == false) {
                System.out.print("No user");
            } else {
                rs.beforeFirst();
                while (rs.next()) {
                    //System.out.println("here");
                    int uID = rs.getInt("fk_userID");
                    System.out.println();
                    userMenu(uID, conn);
                }
            }
            rs.close();
            stmt.close();
            stmt.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            Logger.getLogger(LibraryDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void userMenuText()
    {
        System.out.println("********************* User Menu **************************");

        System.out.println("1. View All Media"); //Works
        System.out.println("2. Search Media"); //Works
        System.out.println("3. Check Out Media");
        System.out.println("4. View Your Checked Out Media"); //Works
        System.out.println("5. Update Email"); //Works
        System.out.println("6. Update Password"); //Works
        System.out.println("7. Log Out\n"); //Works
    }

    public void userMenu(int id, Connection conn)
    {
        System.out.println("Login Successful!\n\n");

        userMenuText();

        System.out.print("Choose From Menu by the number: ");
        int choice = reader.nextInt();
        reader.nextLine();

        try {
            while (choice != 7) {

                Scanner text = new Scanner(System.in);
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                PreparedStatement ps = null;
                String search = "";
                String st = "";
                String query = "";
                int columnsNum = 0;
                int affectedRows = 0;
                ResultSetMetaData rsmd = null;
                ResultSet rs = null;

                switch (choice) {
                    case 1: //view all media
                        st = "SELECT Title FROM Media";
                        rs = stmt.executeQuery(st);
                        rsmd = rs.getMetaData();
                        columnsNum = rsmd.getColumnCount();
                        while (rs.next()) {
                            for (int i = 1; i <= columnsNum; i++) {
                                if (i > 1) {
                                    System.out.print(", ");
                                }
                                String columnValue = rs.getString(i);
                                System.out.print(rsmd.getColumnName(i) + ":\t" + columnValue);
                            }
                            System.out.println("\n");
                        }
                        rs.close();
                        stmt.close();
                        break;
                    case 2: //search media
                        System.out.print("Search for Media Name: \t");
                        search = text.nextLine();

                        st = "SELECT Title FROM Media WHERE Title = '" + search + "'";
                        rs = stmt.executeQuery(st);

                        if (rs.next() == false) {
                            System.out.println("Sorry we don't have that media.\n\n");
                        } else {
                            rs.beforeFirst();
                            rsmd = rs.getMetaData();
                            columnsNum = rsmd.getColumnCount();
                            while (rs.next()) {
                                for (int i = 1; i <= columnsNum; i++) {
                                    if (i > 1) {
                                        System.out.print(", ");
                                    }
                                    String columnValue = rs.getString(i);
                                    System.out.print(rsmd.getColumnName(i) + ":\t" + columnValue);
                                }
                                System.out.println("\n");
                            }
                        }
                        rs.close();
                        stmt.close();
                        break;
                    case 3: //check out media
                        System.out.print("What would you like to check out? \t");
                        search = text.nextLine();
                        st = "SELECT * FROM Media WHERE Title = '" + search + "' LIMIT 1";
                        rs = stmt.executeQuery(st);

                        if (rs.next() == false) {
                            System.out.println("Sorry we don't have that media.\n\n");
                        } else {
                            rs.beforeFirst();
                            int mediaID = 0;
                            byte available = 0;
                            String title = "";

                            while (rs.next()) {
                                mediaID = rs.getInt("mediaID");
                                available = rs.getByte("availability");
                                title = rs.getString("Title");
                            }
                            rs.close();
                            stmt.close();

                            boolean mybool = (available != 0);
                            int regID = 0;
                            int fk_userID = 0;

                            if (mybool == false) {
                                System.out.println("Sorry! This book is already checked out.\n\n");
                            } else {
                                st = "SELECT regID, fk_userID FROM Registered WHERE fk_userID = '" + id + "'";
                                stmt = conn.prepareStatement(st);
                                rs = stmt.executeQuery(st);

                                while (rs.next()) {
                                    mediaID = rs.getInt("regID");
                                    fk_userID = rs.getInt("fk_userID");
                                }

                                rs.close();
                                stmt.close();
                            }

                            query = "INSERT INTO Registered_Has_Media (" + " Registered_regID," + " Registered_fk_userID," + " Media_mediaID) VALUES (" + "?, ?, ?)";
                            ps = conn.prepareStatement(query);
                            ps.setInt(1, regID);
                            ps.setInt(2, fk_userID);
                            ps.setInt(3, mediaID);

                            affectedRows = ps.executeUpdate();
                            if (affectedRows == 0) {
                                throw new SQLException("Wasn't able to check out media at this time. Please try again later.");
                            }

                            ps.close();
                            System.out.println("The media " + title + " was successfully checked out.\n\n");
                        }

                        break;
                    case 4: //view your checked out media

                        //WHERE Registered_Has_Media.Registered_fk_userID = User.userID AND Media.mediaID = Registered_has_Media.Registered_regID AND User.userID = 2; 
                        st = "SELECT Title FROM Media,Registered_Has_Media, User WHERE Media.mediaID = Registered_has_Media.Registered_regID "
                                + "AND Registered_Has_Media.Registered_fk_userID = '" + id + "' AND User.userID = '" + id + "'";
                        rs = stmt.executeQuery(st);

                        if (rs.next() == false) {
                            System.out.print("You have no checked out media.\n\n");
                        } else {
                            System.out.println("----Media Checked Out----");
                            rs.beforeFirst();
                            rsmd = rs.getMetaData();
                            columnsNum = rsmd.getColumnCount();
                            while (rs.next()) {
                                for (int i = 1; i <= columnsNum; i++) {
                                    if (i > 1) {
                                        System.out.print(", ");
                                    }
                                    String columnValue = rs.getString(i);
                                    System.out.print(rsmd.getColumnName(i) + ":\t" + columnValue);
                                }
                                System.out.println("\n");
                            }
                        }

                        rs.close();
                        stmt.close();
                        break;
                    case 5: //update email
                        System.out.print("What's your new email? \t");
                        search = text.next();

                        query = "UPDATE Registered SET email='" + search + "' WHERE fk_userID='" + id + "'";
                        ps = conn.prepareStatement(query);
                       
                        
                        affectedRows = ps.executeUpdate();
                        if (affectedRows == 0) {throw new SQLException("Updating email failed. Try again later"); }
                        
                        ps.close();
                        break;
                    case 6: //update password
                        System.out.print("What's your new password? \t");
                        search = text.next();
                        
                        query = "UPDATE Registered SET password='" + search + "' WHERE fk_userID='" + id + "'";
                        ps = conn.prepareStatement(query);
                       
                        
                        affectedRows = ps.executeUpdate();
                        if (affectedRows == 0) {throw new SQLException("Updating password failed. Try again later"); }
                        
                        ps.close();

                        break;
                    default:
                        System.out.println("Invalid Choice.\n\n");
                        break;
                }

                userMenuText();
                System.out.print("Choose From Menu by the number: ");
                choice = reader.nextInt();
            }

        } catch (SQLException e) {
            Logger.getLogger(LibraryDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        System.out.println("Thanks for using the Library User System. Heading back to the Library Menu...");
    }

    public static void executeScript(Connection conn, File inputFile)
    {

        // Delimiter
        String delimiter = ";";

        // Create scanner
        Scanner scanner;
        try {
            scanner = new Scanner(inputFile).useDelimiter(delimiter);
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
            return;
        }

        // Loop through the SQL file statements 
        Statement currentStatement = null;
        while (scanner.hasNext()) {

            // Get statement 
            String rawStatement = scanner.next() + delimiter;
            try {
                // Execute statement
                currentStatement = conn.createStatement();
                currentStatement.execute(rawStatement);
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Release resources
                if (currentStatement != null) {
                    try {
                        currentStatement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                currentStatement = null;
            }
        }
        scanner.close();
    }

    public static void executeInsertScript(Connection conn, File inputFile)
    {

        // Delimiter
        String delimiter = ";";

        // Create scanner
        Scanner scanner;
        try {
            scanner = new Scanner(inputFile).useDelimiter(delimiter);
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
            return;
        }

        // Loop through the SQL file statements 
        Statement currentStatement = null;
        while (scanner.hasNext()) {

            // Get statement 
            String rawStatement = scanner.next() + delimiter;
            try {
                // Execute statement
                currentStatement = conn.createStatement();
                currentStatement.execute(rawStatement);
            } catch (SQLSyntaxErrorException e) {
                // e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Release resources
                if (currentStatement != null) {
                    try {
                        currentStatement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                currentStatement = null;
            }
        }
        scanner.close();
    }
}
