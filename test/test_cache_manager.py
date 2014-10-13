from Routing import CacheManager
import Routing

c = CacheManager()

print "FD: " + str(c.get_fd())

def callback():
    print "Callback"

c.add_cache(Routing.ADDRESS_CACHE, callback, "data")
c.add_cache(Routing.ROUTE_CACHE, callback, "data")
c.add_cache(Routing.LINK_CACHE, callback, "data")

while True:
    c.__poll(1000)

