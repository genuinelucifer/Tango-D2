module tango.stdc.constants.linux.socket;
    import tango.stdc.constants.linux.fcntl: F_GETFL, F_SETFL,O_NONBLOCK;
    enum {SOCKET_ERROR = -1}
    enum SocketOption: int
    {
        SO_DEBUG = 1 , /* turn on debugging info recording */
        SO_BROADCAST = 6 , /* permit sending of broadcast msgs */
        SO_REUSEADDR = 2 , /* allow local address reuse */
        SO_LINGER = 13 , /* linger on close if data present */
        SO_DONTLINGER = ~(13),
        SO_OOBINLINE = 10 , /* leave received OOB data in line */
        SO_ACCEPTCONN = 30, /* socket has had listen() */
        SO_KEEPALIVE = 9 , /* keep connections alive */
        SO_DONTROUTE = 5 , /* just use interface addresses */
        SO_TYPE = 3 , /* get socket type */
        /*
         * Additional options, not kept in so_options.
         */
        SO_SNDBUF = 7, /* send buffer size */
        SO_RCVBUF = 8, /* receive buffer size */
        SO_ERROR = 4 , /* get error status and clear */
        // OptionLevel.IP settings
        IP_MULTICAST_TTL = 33 ,
        IP_MULTICAST_LOOP = 34 ,
        IP_ADD_MEMBERSHIP = 35 ,
        IP_DROP_MEMBERSHIP = 36,
        // OptionLevel.TCP settings
        TCP_NODELAY = 1 ,
    }
    /* Standard well-defined IP protocols.  */
    private enum
      {
        IPPROTO_IP = 0, /* Dummy protocol for TCP.  */
        IPPROTO_HOPOPTS = 0, /* IPv6 Hop-by-Hop options.  */
        IPPROTO_ICMP = 1, /* Internet Control Message Protocol.  */
        IPPROTO_IGMP = 2, /* Internet Group Management Protocol. */
        IPPROTO_IPIP = 4, /* IPIP tunnels (older KA9Q tunnels use 94).  */
        IPPROTO_TCP = 6, /* Transmission Control Protocol.  */
        IPPROTO_EGP = 8, /* Exterior Gateway Protocol.  */
        IPPROTO_PUP = 12, /* PUP protocol.  */
        IPPROTO_UDP = 17, /* User Datagram Protocol.  */
        IPPROTO_IDP = 22, /* XNS IDP protocol.  */
        IPPROTO_TP = 29, /* SO Transport Protocol Class 4.  */
        IPPROTO_IPV6 = 41, /* IPv6 header.  */
        IPPROTO_ROUTING = 43, /* IPv6 routing header.  */
        IPPROTO_FRAGMENT = 44, /* IPv6 fragmentation header.  */
        IPPROTO_RSVP = 46, /* Reservation Protocol.  */
        IPPROTO_GRE = 47, /* General Routing Encapsulation.  */
        IPPROTO_ESP = 50, /* encapsulating security payload.  */
        IPPROTO_AH = 51, /* authentication header.  */
        IPPROTO_ICMPV6 = 58, /* ICMPv6.  */
        IPPROTO_NONE = 59, /* IPv6 no next header.  */
        IPPROTO_DSTOPTS = 60, /* IPv6 destination options.  */
        IPPROTO_MTP = 92, /* Multicast Transport Protocol.  */
        IPPROTO_ENCAP = 98, /* Encapsulation Header.  */
        IPPROTO_PIM = 103, /* Protocol Independent Multicast.  */
        IPPROTO_COMP = 108, /* Compression Header Protocol.  */
        IPPROTO_SCTP = 132, /* Stream Control Transmission Protocol.  */
        IPPROTO_RAW = 255, /* Raw IP packets.  */
        IPPROTO_MAX
      }
    
    enum SocketOptionLevel
    {
        SOCKET = 1,
        IP = IPPROTO_IP ,
        TCP = IPPROTO_TCP ,
        UDP = IPPROTO_UDP ,
    }
    enum SocketType{
        STREAM = 1 , /++ sequential, reliable +/
        DGRAM = 2 , /++ connectionless unreliable, max length +/
        SEQPACKET = 5, /++ sequential, reliable, max length +/
        RAW = 3 , /++ raw protocol +/
        RDM = 4 , /++ reliable messages +/
        PACKET = 10, /++ linux specific packets at dev level +/
    }
    enum ProtocolType: int
    {
        IP = IPPROTO_IP , /// default internet protocol (probably 4 for compatibility)
        IPV6 = IPPROTO_IPV6 , /// internet protocol version 6
        ICMP = IPPROTO_ICMP , /// internet control message protocol
        IGMP = IPPROTO_IGMP , /// internet group management protocol
        //GGP = IPPROTO_GGP , /// gateway to gateway protocol, deprecated
        TCP = IPPROTO_TCP , /// transmission control protocol
        PUP = IPPROTO_PUP , /// PARC universal packet protocol
        UDP = IPPROTO_UDP , /// user datagram protocol
        IDP = IPPROTO_IDP , /// Xerox NS protocol
    }
    enum AddressFamily: int
    {
        UNSPEC = 0 ,
        UNIX = 1 ,
        INET = 2 ,
        IPX = 4 ,
        APPLETALK = 5 ,
        INET6 = 10 ,
    }

    /+
    /* Bits in the FLAGS argument to `send', `recv', et al.  */
    enum
      {
        MSG_OOB = 0x01, /* Process out-of-band data.  */
        MSG_PEEK = 0x02, /* Peek at incoming messages.  */
        MSG_DONTROUTE = 0x04, /* Don't use local routing.  */
        MSG_CTRUNC = 0x08, /* Control data lost before delivery.  */
        MSG_PROXY = 0x10, /* Supply or ask second address.  */
        MSG_TRUNC = 0x20,
        MSG_DONTWAIT = 0x40, /* Nonblocking IO.  */
        MSG_EOR = 0x80, /* End of record.  */
        MSG_WAITALL = 0x100, /* Wait for a full request.  */
        MSG_FIN = 0x200,
        MSG_SYN = 0x400,
        MSG_CONFIRM = 0x800, /* Confirm path validity.  */
        MSG_RST = 0x1000,
        MSG_ERRQUEUE = 0x2000, /* Fetch message from error queue.  */
        MSG_NOSIGNAL = 0x4000, /* Do not generate SIGPIPE.  */
        MSG_MORE = 0x8000, /* Sender will send more.  */
        MSG_CMSG_CLOEXEC = 0x40000000 /* Set close_on_exit for file
                                               descriptor received through
                                               SCM_RIGHTS.  */
      }
    /* The following constants should be used for the second parameter of
       `shutdown'.  */
    enum
    {
      SHUT_RD = 0, /* No more receptions.  */
      SHUT_WR, /* No more transmissions.  */
      SHUT_RDWR /* No more receptions or transmissions.  */
    }
    /* Standard well-known ports.  */
    enum
      {
        IPPORT_ECHO = 7, /* Echo service.  */
        IPPORT_DISCARD = 9, /* Discard transmissions service.  */
        IPPORT_SYSTAT = 11, /* System status service.  */
        IPPORT_DAYTIME = 13, /* Time of day service.  */
        IPPORT_NETSTAT = 15, /* Network status service.  */
        IPPORT_FTP = 21, /* File Transfer Protocol.  */
        IPPORT_TELNET = 23, /* Telnet protocol.  */
        IPPORT_SMTP = 25, /* Simple Mail Transfer Protocol.  */
        IPPORT_TIMESERVER = 37, /* Timeserver service.  */
        IPPORT_NAMESERVER = 42, /* Domain Name Service.  */
        IPPORT_WHOIS = 43, /* Internet Whois service.  */
        IPPORT_MTP = 57,
        IPPORT_TFTP = 69, /* Trivial File Transfer Protocol.  */
        IPPORT_RJE = 77,
        IPPORT_FINGER = 79, /* Finger service.  */
        IPPORT_TTYLINK = 87,
        IPPORT_SUPDUP = 95, /* SUPDUP protocol.  */
        IPPORT_EXECSERVER = 512, /* execd service.  */
        IPPORT_LOGINSERVER = 513, /* rlogind service.  */
        IPPORT_CMDSERVER = 514,
        IPPORT_EFSSERVER = 520,
        /* UDP ports.  */
        IPPORT_BIFFUDP = 512,
        IPPORT_WHOSERVER = 513,
        IPPORT_ROUTESERVER = 520,
        /* Ports less than this value are reserved for privileged processes.  */
        IPPORT_RESERVED = 1024,
        /* Ports greater this value are reserved for (non-privileged) servers.  */
        IPPORT_USERRESERVED = 5000
      }
    enum
    {
      TCP_ESTABLISHED = 1,
      TCP_SYN_SENT,
      TCP_SYN_RECV,
      TCP_FIN_WAIT1,
      TCP_FIN_WAIT2,
      TCP_TIME_WAIT,
      TCP_CLOSE,
      TCP_CLOSE_WAIT,
      TCP_LAST_ACK,
      TCP_LISTEN,
      TCP_CLOSING /* now a valid state */
    } +/
