# zen_search_user_ticket
Perl command line application to read user and ticket json files and then allow search operations


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
    
    
==================

8. Improvements

a. The test_modules.pm can be improved. Due to lack of time could not improve it much

b. The way the output text is printed can be improved

c. The application prints the UTF-8 characters correctly, but while accepting input there is 
    some issue. Needs more debugging.
    
d. Not have had time to add more comments.    

==================
END    
