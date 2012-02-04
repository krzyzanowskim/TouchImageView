//
//  TouchImageView.h
//
//  Created by Marcin Krzyzanowski on 7/22/11.
//  Copyright 2011 HAKORE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TouchImageView;

@protocol TouchImageViewDelegate <NSObject>
- (void) didTouchImageView:(TouchImageView *) imageView;
@end

typedef enum { TouchImageDrawMode = 0, TouchImageEraseMode} TouchImageEditingMode;

@interface TouchImageView : UIImageView {
#if __has_feature(objc_arc)
    __weak id <TouchImageViewDelegate> delegate;
#else
    id <TouchImageViewDelegate> delegate;
#endif
    
    @private
    CGPoint lastPoint;
	BOOL mouseSwiped;
	int mouseMoved;
}


@property (nonatomic, assign) BOOL editMode;
@property (nonatomic, assign) TouchImageEditingMode editingMode;
#if __has_feature(objc_arc)
@property (nonatomic, weak) IBOutlet id <TouchImageViewDelegate> delegate;
#else
@property (nonatomic, assign) IBOutlet id <TouchImageViewDelegate> delegate;
#endif
@end

