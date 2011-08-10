//
//  TouchImageView.m
//
//  Created by Marcin Krzyzanowski on 7/22/11.
//  Copyright 2011 HAKORE. All rights reserved.
//

#import "TouchImageView.h"

@implementation TouchImageView


@synthesize delegate;
@synthesize editMode;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image])
    {
        //init here
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (delegate != nil && [delegate conformsToProtocol:@protocol(PostCardImageViewDelegate)])
    {
        NSObject *obj = delegate;
        [obj performSelectorOnMainThread:@selector(didTouchImageView:) withObject:self waitUntilDone:NO];
    }
    
    if (editMode)
    {
        mouseSwiped = NO;
        UITouch *touch = [touches anyObject];        
        lastPoint = [touch locationInView:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (editMode)
    {
        mouseSwiped = YES;
        
        UITouch *touch = [touches anyObject];	
        CGPoint currentPoint = [touch locationInView:self];
        
        UIGraphicsBeginImageContext(self.frame.size);
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        lastPoint = currentPoint;
        
        mouseMoved++;
        
        if (mouseMoved == 10) {
            mouseMoved = 0;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (editMode)
    {
        if(!mouseSwiped) {
            UIGraphicsBeginImageContext(self.frame.size);
            [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            self.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
}

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}


@end
