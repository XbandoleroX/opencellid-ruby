# opencellid-ruby
openceliid-ruby-cassandra for analytics

==>Dependencies:

->GEM:
--> cassandra-driver (3.0.3)

->Project structure:

--> csv_class.rb
--> database_class.rb
--> setup.rb
--> updater.rb




==>Adding cron job in order to performe updates at every Monday 1am


$crontab
0 1 * * 1 /bin/bash -l -c 'ruby /path/to/opencellid/updater.rb'



Dont forget about cassandra & configuration...

ENJOY }:D



==>FIRST USE:

At: csv_class.rb

--> Add your opencellid API key (http://opencellid.org/#action=database.requestForApiKey)



At: database_class.rb

--> Add your cassandra User

--> Add your cassandra Password



Then, ready to go...

$ruby setup.rb

for manual update:

$ruby updater.rb
