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
@synthesize editingMode;

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
    if (delegate != nil && [delegate conformsToProtocol:@protocol(TouchImageViewDelegate)])
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
        
        if (self.editingMode == TouchImageDrawMode)
        {
            UIGraphicsBeginImageContext(self.frame.size);
            [self.image drawAtPoint:CGPointZero];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
            CGContextBeginPath(UIGraphicsGetCurrentContext());
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            self.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        else if (self.editingMode == TouchImageEraseMode)
        {                        
            UIGraphicsBeginImageContext(self.frame.size);
            CGMutablePathRef erasePath = CGPathCreateMutable();
            CGPathAddEllipseInRect(erasePath, NULL, CGRectMake(currentPoint.x-20, currentPoint.y-20, 40, 40));
            CGContextAddPath(UIGraphicsGetCurrentContext(),erasePath);
            CGContextAddRect(UIGraphicsGetCurrentContext(),CGRectMake(0,0,self.image.size.width,self.image.size.height));
            CGContextEOClip(UIGraphicsGetCurrentContext());
            [self.image drawAtPoint:CGPointZero];
            self.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            CGPathRelease(erasePath);
        }
        lastPoint = currentPoint;
        
        mouseMoved++;
        
        if (mouseMoved == 10) {
            mouseMoved = 0;
        }
    }
}


- (void)dealloc
{
    delegate = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}


@end
