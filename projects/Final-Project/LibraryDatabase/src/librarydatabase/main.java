package librarydatabase;

//import java.sql.Connection;

import java.util.Scanner;

/**
 *
 * @author mesomaesonwune
 */
public class main
{

    public static void main(String[] args)
    {
        //Connection dbConnection = null;
        Scanner reader = new Scanner(System.in);

        LibraryDatabase project = new LibraryDatabase();
        project.Connect();

        System.out.println("Welcome to the Library!\n");
        libraryMenu();
        System.out.print("Choose From Menu by the number: ");
        int choice = reader.nextInt();

        while (choice != 3) {
            if (choice == 1) {
                project.userCreate();
                System.out.println("\n");
            } else if (choice == 2) {
                project.userLogin();
                System.out.println("\n");
            } else {
                System.out.println("Invalid Choice.\n");
            }
            libraryMenu();
            System.out.print("Choose From Menu by the number: ");
            choice = reader.nextInt();
        }
         System.out.println("Thanks for using the Library System. Have a great day!");

    }

    public static void libraryMenu()
    {
        System.out.println("********************* Library Menu **************************");

        System.out.println("1. Create an Account");
        System.out.println("2. Login");
        System.out.println("3. Exit\n");
    }
}
