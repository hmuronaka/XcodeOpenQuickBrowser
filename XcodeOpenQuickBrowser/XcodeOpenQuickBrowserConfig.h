//
//  XcodeOpenQuickBrowserConfig.h
//  XcodeOpenQuickBrowser
//
//  Created by MuronakaHiroaki on 2015/09/16.
//  Copyright © 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeOpenQuickBrowserMenuItem.h"

@interface XcodeOpenQuickBrowserConfig : NSObject

@property(nonatomic, copy) NSString* filename;
@property(nonatomic, readonly) NSString* fullPath;
@property(nonatomic, readonly) NSArray* menuItems;

-(instancetype)initWithFilename:(NSString*)filename;
-(void)load;
-(void)save;
-(XcodeOpenQuickBrowserMenuItem*)menuItemAtIndex:(NSUInteger)index;
+(instancetype)loadWithFilename:(NSString*)filename;

@end
