
package test_modules;

use strict;
use warnings;

use Cwd 'getcwd';

require search_modules;

sub run_tests 
{
    my ($data_hash) = @_;
    print "in run_tests\n";
    search_modules::process_json_files($data_hash);
    
    my $cwd_dir = getcwd();
    _logmsg("run_tests: cwd is [$cwd_dir]");

    my $test_json_file = $cwd_dir . "\/testing_input.json";
    
    _logmsg("run_tests: test json file is [$test_json_file]");
    
    search_modules::read_json_file($data_hash, $test_json_file, "testing_data");
    
    foreach my $test (@{$data_hash->{"testing_data"}}) {
        my $test_module = $test->{"mod"};
        my $test_num = $test->{"test_num"};
        my $to_search = $test->{"search_text"} if (exists $test->{"search_text"});
        #print "string to search [$to_search] mod is [$test_module]\n";

        my $test_res = 0;
        my $passed = "failed";
        if ($test_module eq "generic_search") {
            #next;
            my $user_result_key = "user_results";
            
            search_modules::generic_hash_search($data_hash, "user_file_data", $to_search, $user_result_key)
                if (exists $test->{"return_users"});
            
            my $ticket_result_key = "tickets_results";
            search_modules::generic_hash_search($data_hash, "ticket_file_data", $to_search, $ticket_result_key)
                if (exists $test->{"return_tickets"});
            
            if (exists $test->{"return_users"}) {
                $test_res = check_user_result($data_hash, $data_hash->{$user_result_key}, $test->{"return_users"});
                #print "test result for users [$test_res]\n";
            }
            
            if (exists $test->{"return_tickets"}) {
                $test_res = check_ticket_result($data_hash, $data_hash->{$ticket_result_key}, $test->{"return_tickets"});
                #print "test result for ticket [$test_res]\n";
            }
        }
        elsif ($test_module eq "specific_user_id_search") {
            #next;
            my $id = $test->{"search_id"};
            #print "id is [$id]\n";
            $test_res = check_user_result($data_hash, $data_hash->{"user_id_hash"}->{$id}, $test->{"return_users"});
        }
        elsif ($test_module eq "specific_user_name_search") {
            my $key_user_result = "user_results";
            search_modules::specific_hash_search_for_a_field($data_hash, "user_file_data", $to_search, "name", $key_user_result);
            $test_res = check_user_result($data_hash, $data_hash->{$key_user_result}, $test->{"return_users"});
        }
        elsif ($test_module eq "specific_ticket_sub_search") {
            my $key_tic_result = "ticket_results";
            search_modules::specific_hash_search_for_a_field($data_hash, "ticket_file_data", $to_search, "subject", $key_tic_result);
            $test_res = check_ticket_result($data_hash, $data_hash->{$key_tic_result}, $test->{"return_tickets"});            
        }
        elsif ($test_module eq "specific_ticket_id_search") {
            my $key_tic_result = "ticket_results";
            search_modules::specific_hash_search_for_a_field($data_hash, "ticket_file_data", $to_search, "_id", $key_tic_result);
            $test_res = check_ticket_result($data_hash, $data_hash->{$key_tic_result}, $test->{"return_tickets"});            
        }        
        $passed = "passed" if ($test_res == 1);
            
        print "\nTest [$test_num] for module [$test_module]      ..... $passed\n";
    }
}

sub check_user_result
{
    my ($dh, $result, $expected_users) = @_;
    
    my $match = 1;
    foreach my $res (@{$result}) {
        my $n = $res->{"name"};
        #print "got n as [$n]\n";
        $match = 0;
        foreach my $exp (@{$expected_users}) {
            #print "comparing [$exp] with [$n]\n";
            if ($n eq $exp) {
                $match = 1;
                last;
            }
        }
        return 0 if ($match == 0);
    }
    return $match;
}

sub check_ticket_result
{
    my ($dh, $result, $expected_tickets) = @_;
    
    my $match = 1;
    foreach my $res (@{$result}) {
        my $n = $res->{"_id"};
        $match = 0;
        foreach my $exp (@{$expected_tickets}) {
            #print "comparing [$exp] with [$n]\n";
            if ($n eq $exp) {
                $match = 1;
                last;
            }
        }
        return 0 if ($match == 0);
    }
    return $match;    
}

sub _logmsg
{
    my ($msg) = @_;
    search_modules::_logmsg($msg);
}

1;