#include <errno.h>
#include <netlink/route/link.h>
#include <netlink/route/route.h>
#include <netlink/route/rtnl.h>
#include <netlink/route/addr.h>
#include <netlink/route/nexthop.h>
#include <netlink/route/rule.h>
#include <netlink/netlink.h>
#include <netlink/utils.h>
#include <netlink/data.h>
#include <netlink/netlink.h>
#include <netlink/cache.h>
#include <netlink/cache-api.h>
#include <netlink/addr.h>
#include <netlink/object.h>
#include <netlink/object-api.h>


void cache_update(struct nl_cache *cache, struct nl_object *obj, int action, void *arg);


void cache_update(struct nl_cache *cache, struct nl_object *obj, int action, void *arg)
{
    printf("Cache Update\n");
}

void main(int argc, char *argv[])
{
	fd_set fds;
	int sk = 0; 
    struct nl_sock *sock = nl_socket_alloc();
    struct nl_cache_mngr *mngr = 0;
    
    struct nl_cache *route_cache = 0;
    struct nl_cache *link_cache = 0;
    struct nl_cache *addr_cache = 0;

    if((ret = nl_cache_mngr_alloc (sock, NETLINK_ROUTE, NL_AUTO_PROVIDE, &mngr))){
        nl_perror(ret, 0);
        return -1;
    }
    
    if((ret = nl_cache_mngr_add(mngr, "route/link", (change_func_t)&cache_update, mon, &link_cache))){
        nl_perror(ret, 0);
        return -1;
    }
    
    if((ret = nl_cache_mngr_add(mngr, "route/addr", (change_func_t)&cache_update, mon, &addr_cache))){
        nl_perror(ret, 0);
        return -1;
    }

    if((ret = nl_cache_mngr_add(mngr, "route/route", (change_func_t)&cache_update, mon, &route_cache))){
        nl_perror(ret, 0);
        return -1;
    }
}

