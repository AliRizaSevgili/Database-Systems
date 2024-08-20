/*  
    -Student Name   :Ali Riza Sevgili
    -Student ID     :135200228
    -Email          :arsevgili@myseneca.ca
    -Date           :11/08/2023
    -Subject        :DBS LAB-07

*/

#include <iostream>
#include <occi.h>
#include <iomanip> // for std::setw and std::setfill


// Using the namespaces to avoid typing "std::" and "oracle::occi::" every time
using oracle::occi::Environment;
using oracle::occi::Connection;
using oracle::occi::Statement;
using oracle::occi::ResultSet;
using namespace oracle::occi;
using namespace std;



int main() {
    // Initialize pointers for environment, connection, and statement
    Environment* env = nullptr;
    Connection* conn = nullptr;
    Statement* stmt = nullptr;
    ResultSet* rs1 = nullptr;   // Result set for the first query
    ResultSet* rs2 = nullptr;  // Result set for the second query

    // User credentials and Oracle server info
    string usr = "dbs211_233nhh30";
    string pass = "14753224";
    string srv = "myoracle12c.senecacollege.ca:1521/oracle12c";

    // Create the environment and connection
    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(usr, pass, srv);

        // Prepare and execute the first query for the Employee Report
        stmt = conn->createStatement(
            "SELECT e.EMPLOYEENUMBER, e.FIRSTNAME, e.LASTNAME, o.PHONE, e.EXTENSION "
            "FROM RETAILEMPLOYEES e "
            "JOIN RETAILOFFICES o ON e.OFFICECODE = o.OFFICECODE "
            "WHERE o.CITY = 'San Francisco' "
            "ORDER BY e.EMPLOYEENUMBER"
        );

        rs1 = stmt->executeQuery();
       
        // Check if the result set is empty
        if (!rs1->next()) {
            cout << "ResultSet is empty." << endl;
        }
       
        // Print the headers for the Employee Report
        else {
            cout << "-------------------------- Report 1 (Employee Report) -----------------------------------" << endl;
            // Use iomanip library functions to format output
            cout.width(14); cout.setf(ios::left); cout << "Employee ID";
            cout.width(20); cout << "First Name";
            cout.width(19); cout << "Last Name";
            cout.width(17); cout << "Phone";
            cout.width(8);  cout << "Extension" << endl;
            cout << "-----------   -----------------   -----------------  ---------------  ---------  " << endl;
            
            // Loop through and print each row of the result set
            do {
                int empId = rs1->getInt(1);
                string firstN = rs1->getString(2);
                string lastN = rs1->getString(3);
                string phone = rs1->getString(4);
                string extension = rs1->getString(5);

                cout.width(14); cout.setf(ios::left); cout << empId;
                cout.width(20); cout << firstN;
                cout.width(19); cout << lastN;
                cout.width(17); cout << phone;
                cout.width(8);  cout << extension << endl;
            } while (rs1->next());
        }


        cout << endl;

        // Prepare and execute the second query for the Manager Report
        stmt = conn->createStatement(
            "SELECT DISTINCT m.EMPLOYEENUMBER, m.FIRSTNAME, m.LASTNAME, o.PHONE, m.EXTENSION "
            "FROM RETAILEMPLOYEES m "
            "JOIN RETAILOFFICES o ON o.OFFICECODE = m.OFFICECODE "
            "WHERE m.EMPLOYEENUMBER IN (SELECT DISTINCT REPORTSTO FROM RETAILEMPLOYEES WHERE REPORTSTO IS NOT NULL) "
            "ORDER BY m.EMPLOYEENUMBER"

        );

        rs2 = stmt->executeQuery();

        // Check if the result set is empty
        if (!rs2->next()) {
            cout << "ResultSet is empty." << endl;
        }
        else {
            // Print the headers for the Manager Report
            cout << "-------------------------- Report 2 (Manager Report) -----------------------------------" << endl;
            
            // Use iomanip library functions to format output
            cout.width(14); cout.setf(ios::left); cout << "Employee ID";
            cout.width(20); cout << "First Name";
            cout.width(19); cout << "Last Name";
            cout.width(17); cout << "Phone";
            cout.width(8);  cout << "Extension" << endl;
            cout << "-----------   -----------------   -----------------  ---------------  ---------  " << endl;

            // Loop through and print each row of the result set
            do {
                int empId = rs2->getInt(1);
                string firstN = rs2->getString(2);
                string lastN = rs2->getString(3);
                string phone = rs2->getString(4);
                string extension = rs2->getString(5);

                cout.width(14); cout.setf(ios::left); cout << empId;
                cout.width(20); cout << firstN;
                cout.width(19); cout << lastN;
                cout.width(17); cout << phone;
                cout.width(8);  cout << extension << endl;
            } while (rs2->next());
        }

        // Clean up the statement and connection objects
        conn->terminateStatement(stmt);
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }
    catch (SQLException& sqlExcp) {

        // Catch any SQL exceptions and print the error code and message
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }

    return 0;
}
