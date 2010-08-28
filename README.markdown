Padrino and Riak Sample Application
=========================================

This is a sample application showing how to use [Padrino](http://padrinorb.com) with [Redis via Ohm](http://github.com/soveran/ohm)

Directions
----------
I'm going to assume you're using ['rvm'](http://rvm.beginrescueend.com). If not, *a pox on all your houses!*

Anyway. Ensure you have redis 2.0.0-rc3 running locally. Do the following:
	rvm create gemset padrino-ohm-demo
	git clone git://github.com/lusis/padrino-ohm-demo.git ohm-blog
	rvm gemset use padrino-ohm-demo
	gem install bundler --pre
	cd ohm-blog
	bundle install
	bundle exec padrino rake seed
	bundle exec padrino start

You should now be able to go to [here](http://localhost:3000/admin).

Unlike the other demos I've provided, this one has full admin support. Simply use the admin interface. The Account model is a model specific to the Padrino admin interface.
If you want to create a new model + admin page:
	bundle exec padrino g model <model_name> foo:string bar:string baz:string
	bundle exec padrino g admin_page <model_name>

TODO
----
Create a distinct controller/view for post display. This will demonstrate using the admin interface to create/manage posts while using another route to display the post contents.
