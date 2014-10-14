# This software was developed by employees of the National Institute of
# Standards and Technology (NIST), and others.
# This software has been contributed to the public domain.
# Pursuant to title 15 Untied States Code Section 105, works of NIST
# employees are not subject to copyright protection in the United States
# and are considered to be in the public domain.
# As a result, a formal license is not needed to use this software.
# 
# This software is provided "AS IS."
# NIST MAKES NO WARRANTY OF ANY KIND, EXPRESS, IMPLIED
# OR STATUTORY, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTY OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT
# AND DATA ACCURACY.  NIST does not warrant or make any representations
# regarding the use of the software or the results thereof, including but
# not limited to the correctness, accuracy, reliability or usefulness of
# this software.

from NLTypes cimport *
from GeNLTypes cimport *

cdef extern from "netlink/genl/genl.h":
    int genl_connect(nl_sock * sk)
    void * genlmsg_put(nl_msg * msg,
                       int	port,
                       int	seq,
                       int family,
                       int hdrlen,
                       int flags,
                       int cmd,
                       int version)		
    
cdef extern from "netlink/genl/mngt.h":    
    int genl_register_family(genl_ops *ops)
    int genl_unregister_family(genl_ops *ops)
    int genl_register(nl_cache_ops *ops)
    void genl_unregister(nl_cache_ops *ops)

cdef extern from "netlink/genl/ctrl.h":
    int genl_ctrl_resolve(nl_sock * sk, char * name)	    
    int genl_ctrl_resolve_grp(nl_sock * sock, char *family_name, char* group_name)
