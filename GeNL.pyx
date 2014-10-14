
from NLTypes cimport nl_sock
from NLUtils cimport *
from GeNLTypes cimport *
from GeNLUtils cimport *
from libc.stdio cimport stdout
from libc.stdlib cimport free
from libc.string cimport memset

from libc.stdint cimport uint32_t, uint16_t, uint8_t

import cython

#    p_hdr = (struct proxy_hdr*)genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, family, sizeof(struct proxy_hdr), 0, TMPP_CMD_REGISTER, TMPP_VERSION);

cdef class genl_message(object):

    cdef nl_msg *message
    cdef nlhdr *header
    cdef int family
    cdef int command
    
    def __cinit__(self, family, command, version):
        
        self.user_header = genlmsg_put(self.message,
                             NL_AUTO_PORT, 
                             NL_AUTO_SEQ, 
                             family,
                             0, 
                             0, 
                             command, 
                             version);
                                
    reserve = lambda self, _len, pad: nlmsg_reserve(self, _len, pad)
    put_string = lambda self, attrtype, string: nla_put_string(self, attrtype, string)
    put_u8 = lambda self, attrtype, value: nla_put_u8(self, attrtype, value)
    put_u16 = lambda self, attrtype, value: nla_put_u16(self, attrtype, value)
    put_u32 = lambda self, attrtype, value: nla_put_u32(self, attrtype, value)

    def __dealloc__(self):
        if self.message is not NULL:
            nl_free(self.message)

cdef class genl(object):
    cdef nl_sock * sock
    cdef int family

    def __cinit__(self, family_name):
        self.sock = nl_socket_alloc()
        
        genl_connect(self.sock)
        
        self.family = genl_ctrl_resolve(self.sock, family_name)
        
        if self.family < 0:
            raise RuntimeError("Could not resolve family: %s"
                                 % nl_geterror(self.family))      
        
    def __modify_callback(self):
        pass
        
    
        
    def put()

        
        
    def disable_sequence_check(self):
        nl_socket_disable_seq_check(self.sock)
            
    def __dealloc__(self):
        if self.sock is not NULL:
            nl_close(self.sock)
            nl_socket_free(self.sock)
