############################################################
#
# Code challenge : 25th July 2021
# 
# Program to process data across two json files and assist
#  user with search option
#
############################################################

BEGIN { unshift @INC, '.'; }
require search_modules;
require test_modules;


main ();

exit(0);

sub main
{
    search_modules::open_log_file_handle();
    
    my $data_hash = {};
    
    search_modules::get_inputs($data_hash, "inputopts");
    
    if ($data_hash->{inputopts}->{run_test}) {
        run_test_cases($data_hash);
    }
    
    search_modules::process_json_files_and_start_search($data_hash);
}

sub run_test_cases
{
    my $data_hash = {};
    print "running test_cases\n";
    test_modules::run_tests($data_hash);
    exit;
}