from Routing import CacheManager
import Routing

c = CacheManager()

print "FD: " + str(c.get_fd())

c.add_cache(Routing.ADDRESS_CACHE)
