# opencellid-ruby
openceliid-ruby-cassandra for analytics

## Dependencies:

* [--> cassandra-driver](https://rubygems.org/gems/cassandra-driver/) (3.0.3)

### Project structure:
* [-> /]()
* [--> csv_class.rb](https://github.com/julianstafari/opencellid-ruby/blob/master/csv_class.rb)
* [--> database_class.rb](https://github.com/julianstafari/opencellid-ruby/blob/master/database_class.rb)
* [--> setup.rb](https://github.com/julianstafari/opencellid-ruby/blob/master/setup.rb)
* [--> updater.rb](https://github.com/julianstafari/opencellid-ruby/blob/master/updater.rb)



## Adding cron job in order to performe updates at every Monday 1am

```
$crontab
```
and add the following:

```
0 1 * * 1 /bin/bash -l -c 'ruby /path/to/opencellid/updater.rb'
```

Dont forget about cassandra & configuration...

ENJOY }:D


## FIRST USE:

### At: csv_class.rb

* [--> Add your opencellid API key] (http://opencellid.org/#action=database.requestForApiKey) - http://opencellid.org/#action=database.requestForApiKey



### At: database_class.rb

* [--> Add your cassandra User](https://docs.datastax.com/en/cql/3.3/cql/cql_reference/create_user_r.html)

* [--> Add your cassandra Password](https://docs.datastax.com/en/cql/3.3/cql/cql_reference/create_user_r.html)

* [--> Util info about cassandra auth](https://docs.datastax.com/en/cassandra/1.2/cassandra/security/security_config_native_authenticate_t.html)



Then, ready to go...
```
$ruby setup.rb
```
for manual update:
```
 $ruby updater.rb
```

## Author

* **[@julianstafari](https://github.com/julianstafari)** -> https://twitter.com/julianstafari
