//
//  IconOverlayHandlers.m
//  LiferayFinderCore
//
//  Created by Vitaly Eremenko (vitaly.eremenko@teamdev.com) on 11/28/12.
//

#import "IconOverlayHandlers.h"
#import "Finder/Finder.h"
#import "ContentManager.h"
#import "IconCache.h"

@implementation NSObject(IconOverlayHandlers)

- (void)IconOverlayHandlers_drawImage:(id)arg1
{
 
    NSString *url = [self previewItemURL];
	NSRect rect = [(IKImageBrowserCell*)self frame];
    
    NSNumber* imageIndex = [[ContentManager sharedInstance] iconByPath: [url path]];
    
    // [url release];
    
	if ([imageIndex intValue] > 0)
    {
        NSImage *icon = [arg1 _nsImage];
        
		int x = [icon size].width;
        NSRect frame = NSMakeRect(x - 20, 0, 20, 20);
        
        [icon lockFocus];
        CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
        
        NSImage* iconimage = [[IconCache sharedInstance] getIcon:[NSNumber numberWithInt:[imageIndex intValue]]];
		
        if (iconimage != nil)
        {
            CGImageRef image;
            CGImageSourceRef source;
            NSData* data = [iconimage TIFFRepresentation];
            {
                
                source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
                CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
                CGContextDrawImage(myContext, CGRectMake (0, 0, [icon size].width, [icon size].height ), maskRef);
                CFRelease(source);
                CFRelease(maskRef);
            }
            //[data release];
        }
        [icon unlockFocus];
        //[self HOOK_drawImage:fp8];
        
        IKImageWrapper* imgWrapper = [[IKImageWrapper alloc] initWithNSImage:icon];
        
        [self IconOverlayHandlers_drawImage:imgWrapper];	
        [imgWrapper release];
    }
    else
    {
        [self IconOverlayHandlers_drawImage:arg1];
    }

}

- (void)IconOverlayHandlers_drawIconWithFrame:(struct CGRect)arg1
{
    NSString *title = [self objectValue];
    
    NSURL *url = [[NSClassFromString(@"FINode") nodeFromNodeRef: [(TNodeIconAndNameCell *)self node]->fNodeRef] previewItemURL];
    
    
    NSNumber* imageIndex = [[ContentManager sharedInstance] iconByPath: [url path]];
	
	if ([imageIndex intValue] > 0)
    {
		[self IconOverlayHandlers_drawIconWithFrame:arg1];
		
		NSImage* image = [[IconCache sharedInstance] getIcon:imageIndex];
		if (image == nil)
		{
		}
		else
        {
            struct CGRect arg2 = [(TIconViewCell*)self imageRectForBounds: arg1];
            int imageSize = arg2.size.height;// * 2 / 3;
			[image drawInRect:NSMakeRect(arg2.origin.x, arg2.origin.y, arg2.size.width, arg2.size.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:TRUE hints: nil];
        }
        
	}
	else
	{
		[self IconOverlayHandlers_drawIconWithFrame:arg1];
		
	}
}

@end