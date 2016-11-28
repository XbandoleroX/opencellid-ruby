# opencellid-ruby
openceliid-ruby-cassandra for analytics

Dependencies:

->GEM:
--> cassandra-driver (3.0.3)

Project structure:

--> csv_class.rb
--> database_class.rb
--> setup.rb
--> updater.rb

->Adding cron job in order to performe updates at every Monday 1am

$crontab
0 1 * * 1 /bin/bash -l -c 'ruby /path/to/opencellid/updater.rb'

Dont forget about cassandra & configuration...

ENJOY }:D

