/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. All rights reserved

        license:        BSD style: see doc/license.txt for details
        
        version:        Initial release: April 2004      
        
        author:         Kris

*******************************************************************************/

module mango.net.util.ServerThread;

private import  tango.core.thread;

private import  tango.io.Conduit,
                tango.io.Exception;

private import  tango.net.ServerSocket,
                tango.net.SocketConduit;

private import  mango.net.util.AbstractServer;

/******************************************************************************

        Subclasses Thread to provide the basic server-thread loop. This
        functionality could also be implemented as a delegate, however, 
        we also wish to subclass in order to add thread-local data (see
        HttpThread).

******************************************************************************/

class ServerThread : Thread
{
        ServerSocket    socket;
        AbstractServer  server;

        /**********************************************************************

                Construct a ServerThread for the given Server, upon the 
                specified socket
                 
        **********************************************************************/

        this (AbstractServer server, ServerSocket socket)
        {
                this.server = server;
                this.socket = socket;
        }

        /**********************************************************************

                Execute this thread until the Server says to halt. Each
                thread waits in the socket.accept() state, waiting for
                a connection request to arrive. Upon selection, a thread
                dispatches the request via the request service-handler
                and, upon completion, enters the socket.accept() state
                once more.

        **********************************************************************/

        override void run ()
        {
                while (true)
                       try {
                           // should we bail out?
                           if (SocketConduit.isHalting)
                               return 0;

                           // wait for a socket connection
                           SocketConduit sc = socket.accept ();

                           // did we get a valid response?
                           if (sc)
                               // yep: process this request
                               server.service (this, sc);
                           else
                              // server may be halting ...
//                              if (! SocketConduit.isHalting)
                              if (socket.isAlive)
                                  server.getLogger.error ("Socket accept() failed");

                           } catch (IOException x)
                                   {
                                   server.getLogger.error ("IOException: "~x.toString);
                                   }
                            catch (Object x)
                                   {
                                   server.getLogger.fatal ("Exception: "~x.toString);
                                   }
        }
}
