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
    id <TouchImageViewDelegate> delegate;
    
    @private
    CGPoint lastPoint;
	BOOL mouseSwiped;
	int mouseMoved;
}


@property (nonatomic, assign) BOOL editMode;
@property (nonatomic, assign) TouchImageEditingMode editingMode;
@property (nonatomic, assign) IBOutlet id <TouchImageViewDelegate> delegate;

@end

