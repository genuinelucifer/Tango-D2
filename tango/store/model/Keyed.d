/*
 File: Keyed.d

 Originally written by Doug Lea and released into the public domain. 
 Thanks for the assistance and support of Sun Microsystems Labs, Agorics 
 Inc, Loral, and everyone contributing, testing, and using this code.

 History:
 Date     Who                What
 24Sep95  dl@cs.oswego.edu   Create from collections.d  working file
 9Apr97   dl                 made Serializable

*/


module tango.store.model.Keyed;


/**
 *
 *
 * Keyed is an interface most useful in association with SortedCollections.
 * Any class implementing Keyed contains method key, that returns
 * an object serving as a sorting key for the rest of the object.
 * <P>
 * The DefaultComparator class checks to see if its arguments
 * are Keyed, and if so uses the keys as the basis for comparison.
 * 
        author: Doug Lea
 * @version 0.93
 *
 * <P> For an introduction to this package see <A HREF="index.html"> Overview </A>.
**/

public interface KeyedT(T)
{

        /**
         * Return an object serving as a comparison key
        **/

        public T key();
}

alias KeyedT!(Object) Keyed;