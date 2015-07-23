# SMTPDuplicate
A simple Perl based SMTP proxy that duplicates incoming SMTP messages to two mail servers.  This proxy was developed to allow testing of a new server side by side with the current production server using the same message stream.

Note: Rejections from the destination mail servers (address not known, spam) are essentially ignored and not passed back to the sender.

Warning: This proxy accepts all incoming mail.  In some circumstances it can cause your mail system to operate as an open relay. 


Requires [Net:SMTP:Server](http://search.cpan.org/~macgyver/SMTP-Server-1.1/Server.pm) module


Usage:

    SMTPDuplicate.pl server1 server2 listen_port

    server1 - first mail server
    server2 - second mail server
    listen_port - port to listen for incoming connections
    
    
