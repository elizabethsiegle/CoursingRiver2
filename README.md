# Generate a Song by Training a Markov model on a Song in Swift
## Then generate another song via SMS with server-side Swift, [Perfect](perfect.org), and [Twilio](twilio.com).

###  you should have the following:
A [Twilio account](https://www.twilio.com/try-twilio) to buy a Twilio number
[Ngrok](http://ngrok.io)
[Xcode](https://developer.apple.com/xcode/)
[MarkovModel library](https://github.com/db-in/MarkovModel)

After making a Twilio account, you must [buy a phone number](https://www.twilio.com/console/phone-numbers/search) and configure it with your ngrok URL with "/sms" appended to it under `Messaging` where it says `A Message Comes in` after running `ngrok http 8181` on the command line.
