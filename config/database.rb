# Ohm does not have the concept of namespaces
# This means that you will not be able to have
# a distinct test,development or production database
#
# You can, however, run multiple redis servers on the same host
# and point to them based on the environment:
#
# case Padrino.env
#  when :development then Ohm.connect(:port => 6379)
#  when :production then Ohm.connect(:port => 6380)
#  when :test then Ohm.connect(:port => 6381)
# end

# Alternatively, you can try specifying a difference :db
# which, outside of confirmation, appears to provide distinct
# namespaces from testing
# case Padrino.env
#  when :development then Ohm.connect(:db => 0)
#  when :production then Ohm.connect(:db => 1)
#  when :test then Ohm.connect(:db => 2)
# end
