/*******************************************************************************

        Shows how to create a basic socket client, and how to converse with
        a remote server. 

*******************************************************************************/

private import  tango.io.Console;

private import  tango.net.SocketConduit, 
                tango.net.InternetAddress;

/*******************************************************************************

*******************************************************************************/

void main()
{
        // make a connection request to the server
        auto request = new SocketConduit;
        request.connect (new InternetAddress ("localhost", 8080));
        request.write ("hello\n");

        // wait for response (there is an optional timeout supported)
        char[64] response;
        request.read (response);

        // close socket
        request.close;

        // display server response
        Cout (response).newline;
}
