/*
 File: MutableMap.d

 Originally written by Doug Lea and released into the public domain. 
 Thanks for the assistance and support of Sun Microsystems Labs, Agorics 
 Inc, Loral, and everyone contributing, testing, and using this code.

 History:
 Date     Who                What
 24Sep95  dl@cs.oswego.edu   Create from collections.d  working file

*/


module tango.store.model.MutableMap;

private import tango.store.model.Map;
private import tango.store.model.MutableCollection;


/**
 *
 *
 * MutableMap supports standard update operations on maps.
 *
 * 
        author: Doug Lea
 * @version 0.93
 *
 * <P> For an introduction to this package see <A HREF="index.html"> Overview </A>.
**/


public interface MutableMapT(K, T) : MutableCollectionT!(T), MapT!(K, T)
{
        /**
         * Include the indicated pair in the Map
         * If a different pair
         * with the same key was previously held, it is replaced by the
         * new pair.
         *
         * @param key the key for element to include
         * @param element the element to include
         * @return condition: 
         * <PRE>
         * has(key, element) &&
         * no spurious effects &&
         * Version change iff !PREV(this).contains(key, element))
         * </PRE>
        **/

        public void putAt(K key, T element);



        /**
         * Remove the pair with the given key
         * @param  key the key
         * @return condition: 
         * <PRE>
         * !containsKey(key)
         * foreach (k in keys()) at(k).equals(PREV(this).at(k)) &&
         * foreach (k in PREV(this).keys()) (!k.equals(key)) --> at(k).equals(PREV(this).at(k)) 
         * (version() != PREV(this).version()) == 
         * containsKey(key) !=  PREV(this).containsKey(key))
         * </PRE>
        **/

        public void remove(K key);


        /**
         * Replace old pair with new pair with same key.
         * No effect if pair not held. (This has the case of
         * having no effect if the key exists but is bound to a different value.)
         * @param key the key for the pair to remove
         * @param oldElement the existing element
         * @param newElement the value to replace it with
         * @return condition: 
         * <PRE>
         * !contains(key, oldElement) || contains(key, newElement);
         * no spurious effects &&
         * Version change iff PREV(this).contains(key, oldElement))
         * </PRE>
        **/

        public void replaceElement(K key, T oldElement, T newElement);
}


alias MutableMapT!(Object, Object) MutableMap;