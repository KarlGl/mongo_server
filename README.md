Sms your needy girlfriend every hour on the hour.

A node server that will randomly select a love message to send to any number via SMS broadcast.

to run:
```
npm install gulp -g
npm install
gulp server
````

now ajust settings  
setup your settings at this endpoint  
enabled # is it going to actually send? t for yes  
url # url to post sms to (smsbroadcast by default)  
to # number to send to  
from # number to appear to be from  
pass # sms broadcast password  
user # sms broadcast user  
```
curl -X POST -d 'enabled=t&user=foo' http://0.0.0.0:3000/settings
```

set messages to pick from (will clear existing)
```
curl -X POST -d '[]=my soul&[1]=You are my love' http://0.0.0.0:3000/messages
```

Now it will send sms every hour.
```
curl 0.0.0.0:3000 to get a csv of sent smss and times.
```

dist/app.js is the compiled main file
