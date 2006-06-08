/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. All rights reserved

        license:        BSD style: see doc/license.txt for details
      
        version:        Initial release: May 2004
        
        author:         Kris

*******************************************************************************/

module tango.log.XmlLayout;

private import  tango.log.Event,
                tango.log.Layout;

/*******************************************************************************

        A layout with XML output conforming to Log4J specs.
       
*******************************************************************************/

public class XmlLayout : Layout
{
        /***********************************************************************
                
                Format message attributes into an output buffer and return
                the populated portion.

        ***********************************************************************/

        char[] header (Event event)
        {
                char[20] tmp;

                event.append ("<log4j:event logger=\"")
                     .append (event.getName)
                     .append ("\" timestamp=\"")
                     .append (ultoa (tmp, event.getEpochTime))
                     .append ("\" level=\"")
                     .append (event.getLevelName [0..length-1])
                     .append ("\" thread=\"unknown\">\r\n<log4j:message><![CDATA[");

                return event.getContent;
        }


        /***********************************************************************
                
                Format message attributes into an output buffer and return
                the populated portion.

        ***********************************************************************/

        char[] footer (Event event)
        {       
                event.scratch.length = 0;
                event.append ("]]></log4j:message>\r\n<log4j:properties><log4j:data name=\"application\" value=\"")
                     .append (event.getHierarchy.getName)
                     .append ("\"/><log4j:data name=\"hostname\" value=\"")
                     .append (event.getHierarchy.getAddress)
                     .append ("\"/></log4j:properties></log4j:event>\r\n");

                return event.getContent;
        }
}


