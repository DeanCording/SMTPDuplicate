#!/usr/bin/perl

use Carp;
use Net::SMTP::Server;
use Net::SMTP::Server::Client;
use Net::SMTP;
use threads;

$server = new Net::SMTP::Server('',9025) ||
  croak("Unable to handle client connection: $!\n");

while(my $conn = $server->accept()) {
  async {
    # Handle the client's connection and spawn off a new parser.
    my $client = new Net::SMTP::Server::Client($conn) ||
        croak("Unable to handle client connection: $!\n");

    # Process the client.  This command will block until
    # the connecting client completes the SMTP transaction.
    $client->process || croak("Client process failed: $!\n");
    $conn->close; 
    my $server = new Net::SMTP('mail', Debug => 1);
    $server->mail($client->{FROM});
    # Loop through the recipient list.
    foreach $target (@{$client->{TO}}) {
      $server->to($target);
    }
    $server->data($client->{MSG});
    $server->quit;

    my $server = new Net::SMTP('localhost', Debug => 1);                                                                        
    $server->mail($client->{FROM});                                                                                             
    # Loop through the recipient list.                                                                                          
    foreach $target (@{$client->{TO}}) {
      $server->to($target); 
    }
    $server->data($client->{MSG});
    $server->quit;

  }->detach;
}
