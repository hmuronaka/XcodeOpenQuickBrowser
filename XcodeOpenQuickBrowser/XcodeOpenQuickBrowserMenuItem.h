//
//  XcodeOpenQuickBrowserMenuItem.h
//  XcodeOpenQuickBrowser
//
//  Created by MuronakaHiroaki on 2015/09/16.
//  Copyright © 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* kXcodeOpenQuickBrowserMenuItemTitle;
extern NSString* kXcodeOpenQuickBrowserMenuItemURLPattern;
extern NSString* kXcodeOpenQuickBrowserMenuItemShortCutKey;
extern NSString* kXcodeOpenQuickBrowserMenuItemUseIssue;
extern NSString* kXcodeOpenQuickBrowserMenuItemIssuePattern;
extern NSString* kXcodeOpenQuickBrowserMenuItemIssueURLPattern;

@interface XcodeOpenQuickBrowserMenuItem : NSObject

@property(nonatomic, readonly) NSString* menuTitle;
@property(nonatomic, readonly) NSString* urlPattern;
@property(nonatomic, readonly) NSString* shortcutKey;
@property(nonatomic, assign)   BOOL      useIssue;
@property(nonatomic, readonly) NSString* issuePattern;
@property(nonatomic, readonly) NSString* issueURLPattern;

-(instancetype)initWithMenuTitle:(NSString*)menuTitle urlPattern:(NSString*)urlPattern shortcutKey:(NSString*)shortcutKey;
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)dictionary;

@end
