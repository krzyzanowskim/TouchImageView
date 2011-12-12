TouchImageView
==============

How to use it?
--------------

Create UIImageView with InterfaceBuilder and set Class to "TouchImageView"

Set *delegate* from created image to you delegate object. Delegate object should implement protocol <TouchImageViewDelegate>

Every time image is touched (clicked) this method is called on delegate object:

    - (void) didTouchImageView:(TouchImageView *) imageView;


Bonus
-----

Switch property editMode to TouchImageDrawMode or TouchImageEraseMode and you can draw on image with you finger.

Credits
-------

Created by [Marcin Krzyżanowski](http://www.hakore.com).

(c) 2011 by Marcin Krzyżanowski.
See License.txt for license. 