==================

Readme

==================

This readme has the following details :

1. Perl Installation instructions
2. Extract zip 
3. How to execute the search application
4. Enable UTF-8 in windows command prompt
5. Log file details
6. Support for Other operating system
7. Performance
8. Improvements
9. Test Coverage
10. Assumptions
11. Sample execution output


==================
1. Windows 10 Perl Installation instructions

a. Open the below link 
https://www.perl.org/get.html

b. Download Strawberry Perl (64 bit)
File downloaded : strawberry-perl-5.32.1.1-64bit.msi

c. Run the Perl installer and default installation path
    of C:\Strawberry is fine.
    
d. Open a command prompt as administrator and execute 'perl -v'
    this should print the following output:
    
This is perl 5, version 32, subversion 1 (v5.32.1) built for MSWin32-x64-multi-thread

e. The above output confirms the perl is ready on your server    


==================
2. Extract zip

a. Create a test folder and extract the zip search_module.zip

b. The following files should be available
    i. main_search.pl
    ii. search_modules.pm
    iii. This Readme.txt
    iv. test_modules.pm
    v. test_tickets.json
    vi. test_users.json
    vii. testing_input.json
    
c. Open a command prompt as administrator. If you do not want to open the command prompt
    as administrator, then make sure you are in a folder where the logged in user has 
    permissions to create files (as this search application creates log file) during execution.
    
d. In the command prompt, cd to the same directory as the perl files and execute 

perl main_search.pl --help
    
e. This should print the usage of the application without any error. When done, you are
    ready to use the application.
    
    
==================
3. How to execute the search application

When you execute the search application with --help option, below usage is printed.
The usage below explains how to run the application.


Usage: perl main_search.pl <OPTIONS>

OPTIONS :

   --tickets_json ......... [Optional] The full file path for tickets json file
                   ........   If not specified, the tickets.json file should exists
                   ........   in the current directory

   --users_json ........... [Optional] The full file path for users json file
                  .........   If not specified, the users.json file should exists
                  .........   in the current directory

   --run_test ............. [Optional] Run the test cases
   --help ................. [Optional] Prints this usage


   Examples:
     To run the script with both the json files in the current directory
        The json file names should match tickets.json and users.json
     # perl main_search.pl


     To run the script with the inputs from command line
     # perl main_search.pl --tickets_json="c:\Users\tmp\test\tickets_small.json" --users_json="C:\Users\tmp\test\users_small.json"


     To run the script with the file path of tickets_json from command line
           and users.json exists in current directory
     # perl main_search.pl --tickets_json="c:\Users\tmp\test\tickets_small.json"


     To run the script with the file path of users_json from command line
           and tickets.json exists in current directory
     # perl main_search.pl --users_json="C:\Users\tmp\test\users_small.json"

     To run the script from a different folder, when all files are 
           extracted in c:\Users\xyz\test folder
     # perl -I c:\Users\xyz\test\ c:\Users\xyz\test\main_search.pl

     To run test coverage when all perl files and test_* perl modules and json files
           are extracted in c:\Users\xyz\test folder and json files are in current folder
     # perl main_search.pl --run_test --tickets_json="c:\Users\tmp\test\test_tickets.json"
           --users_json="C:\Users\tmp\test\test_users.json"
     
==================
4. Enable UTF-8 in windows command prompt

a. The json files contain certain text in UTF-8 format. 

b. By default windows command prompt does not UTF-8

c. Search for options to enable UTF-8 and enable it.


==================
5. Log file details

a. During the execution of the search application, a log file search_user_ticket.log gets
    created in the directory where the perl command is executed.
    
b. This log file is for debugging purpose.


==================
6. Support for Other operating system

a. The application should run on other operating systems as long as 
    the perl on the system has the following modules available
    - warnings
    - strict
    - Getopt::Long
    - JSON
    - Cwd
    - utf8
    - Encode

b. The only clear screen command that is used in the code is specific
    to windows, but there is a check for OS, so it should not fail on 
    other operating systems
    
    
==================
7. Performance

a. The specific search based on ID should be the fastest and the response
    time should not increase linearly
    
b. The generic search option will be the slowest, but provides the only
    way to do an extensive search
    
c. The logging is minimal, but on extensive search, can cause increase
    in time response, but if need be, logging can be disabled.
    
d. Hash and array pointers are passed around the modules/functions, this is to avoid
    passing full data across and have better performance
    
e. Only one primary hash/array that stores users and tickets is used while reading the
    json and this is used during search. Few additional hash/arrays are created for
    quick search, but does not copy data, these structures only hold pointers.
    
==================
8. Improvements

a. The test_modules.pm can be improved. Due to lack of time could not improve it much

b. The way the output text is printed can be improved

c. The application prints the UTF-8 characters correctly, but while accepting input there is 
    some issue. Needs more debugging.
    
d. Not have had time to add more comments.    

==================
9. Test Coverage

a. Testing is dependent on the json input files test_tickets.json, test_users.json and testing_input.json

b. testing_input.json and test_modules.pm have to be in the same directory as the other perl scripts.
    Execution has to be done from the same folder.
    
c. Do not change test_tickets.json and test_users.json file. As the testing_input runs all test cases based on
    these two files.

==================
10. Assumptions

a. The json files (users and ticket) get read only at the start of the execution. Any changes to the json
    files during the execution will not be picked up.
    
b. If an updated json is to be used, exit from the execution and start it again.

c. All the data read from the json is kept in the memory and used during the execution.    

==================
11. Sample execution output

:::::::::::::::::::::::::::::::::::::::::::::
Output as seen for Generic search ::::

======  Search users or tickets  ======

 Search Options:
  1. Generic Search
  2. Specific Search
  3. Exit

Enter an option : 1

Generic Search : Search is case in-sensitive, but spaces between words will be matched as is
Enter a search string :lee


===========================
Printing Search Result:
===========================

===========================
User with Matching details:


User name is : Lee Davidson
   User has ID: 20, verified is as : "false"
   and created at value is : "2016-04-07T11:08:24-10:00"

User has following ticket/s:

Found ticket with following details :
 Ticket type : problem   and subject as : "A Problem in Barbados"
  Ticket ID: 54f60187-6064-492a-9a4c-37fc21b4e300    and created at : 2016-02-11T05:36:16-11:00
  With tags : "Texas, Nevada, Oregon, Arizona"


===========================
User with Matching details:


User name is : Lee Dotson
   User has ID: 32, verified is as : "true"
   and created at value is : "2016-07-17T02:09:22-10:00"

User has following ticket/s:

Found ticket with following details :
 Ticket type : incident   and subject as : "A Problem in Mozambique"
  Ticket ID: cb3b726e-9ba0-4e35-b4d6-ee41c29a7185    and created at : 2016-05-03T02:44:43-10:00
  With tags : "Iowa, North Dakota, California, Palau"

Found ticket with following details :
 Ticket type : task   and subject as : "A Drama in Venezuela"
  Ticket ID: 0e74f193-cd11-4803-93e1-807eb0e37874    and created at : 2016-02-26T03:42:42-11:00
  With tags : "South Dakota, Montana, District Of Columbia, Wisconsin"

Found ticket with following details :
 Ticket type : task   and subject as : "A Catastrophe in Bouvet Island"
  Ticket ID: 3d5ec1b4-509c-45de-8338-4934531d48f3    and created at : 2016-06-02T06:02:55-10:00
  With tags : "California, Palau, Kentucky, North Carolina"

Found ticket with following details :
 Ticket type : task   and subject as : "A Drama in Guinea"
  Ticket ID: 945ce2d3-3edc-4936-8d51-e59e74cf917a    and created at : 2016-04-23T05:47:03-10:00
  With tags : "American Samoa, Northern Mariana Islands, Puerto Rico, Idaho"




Press enter to continue

:::::::::::::::::::::::::::::::::::::::::::::
Output as seen for Specific search ::::

======  Search users or tickets  ======

 Search Options:
  1. Generic Search
  2. Specific Search
  3. Exit

Enter an option : 2

Specific Search : Following options available :-
  1. Search based on User ID
  2. Search based on any User name
  3. Search based on any Ticket field
  4. Unassigned tickets
  5. Users without IDs
  6. Check for anamolies (users missing fields or tickets with extra fields)
  7. Go to main menu
  8. Exit

Enter an option (1-8) :3

Specific Search : Search is case in-sensitive, but spaces between words will be matched as is
Fields from Tickets json are :
  1. tags
  2. type
  3. created_at
  4. assignee_id
  5. subject
  6. _id

Enter an option :5

Enter a value to search for the selected field :polan


===========================
Printing Search Result:
===========================

=====================================
Tickets with Matching the search string:


Found ticket with following details :
 Ticket type : incident   and subject as : "A Nuisance in Poland"
  Ticket ID: 31e7f6d7-f6cb-4781-b4e7-2f552941e1f5    and created at : 2016-04-25T02:22:03-10:00
  With tags : "Connecticut, Arkansas, Missouri, Alabama"


=================================
User that has this ticket:

User name is : Lynnette Dunlap
   User has ID: 63, verified is as : "false"
   and created at value is : "2016-01-05T09:15:41-11:00"




Press enter to continue



:::::::::::::::::::::::::::::::::::::::::::::
Output as seen during test-cases execution ::::

C:\Users\sumeetp\test>perl main_search.pl --run_test
running test_cases
in run_tests

Test [1] for module [generic_search]      ..... passed

Test [2] for module [generic_search]      ..... passed

Test [3] for module [specific_user_id_search]      ..... passed

Test [4] for module [generic_search]      ..... passed

Test [5] for module [generic_search]      ..... passed

Test [6] for module [generic_search]      ..... passed

Test [7] for module [generic_search]      ..... passed

Test [8] for module [specific_user_id_search]      ..... passed

Test [9] for module [specific_user_id_search]      ..... passed

Test [10] for module [specific_user_id_search]      ..... passed

Test [11] for module [specific_user_id_search]      ..... passed

Test [12] for module [specific_user_name_search]      ..... passed

Test [13] for module [specific_user_name_search]      ..... passed

Test [14] for module [specific_user_name_search]      ..... passed

Test [15] for module [specific_user_name_search]      ..... passed

Test [16] for module [specific_ticket_sub_search]      ..... passed

Test [17] for module [specific_ticket_sub_search]      ..... passed

Test [18] for module [specific_ticket_sub_search]      ..... passed

Test [19] for module [specific_ticket_id_search]      ..... passed

Test [20] for module [specific_ticket_id_search]      ..... passed

C:\Users\sumeetp\test>

==================

END    
