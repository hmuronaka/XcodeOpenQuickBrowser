//
//  XcodeOpenQuickBrowserMenuItem.m
//  XcodeOpenQuickBrowser
//
//  Created by MuronakaHiroaki on 2015/09/16.
//  Copyright © 2015年 Muronaka Hiroaki. All rights reserved.
//

#import "XcodeOpenQuickBrowserMenuItem.h"

#define NSLog(format, ...) NSLog(@"%20s%5d: " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

NSString* kXcodeOpenQuickBrowserMenuItemTitle = @"kXcodeOpenQuickBrowserMenuItemTitle";
NSString* kXcodeOpenQuickBrowserMenuItemURLPattern = @"kXcodeOpenQuickBrowserMenuItemURLPattern";
NSString* kXcodeOpenQuickBrowserMenuItemShortCutKey = @"kXcodeOpenQuickBrowserMenuItemShortCutKey";
NSString* kXcodeOpenQuickBrowserMenuItemUseIssue = @"kXcodeOpenQuickBrowserMenuItemUseIssue";
NSString* kXcodeOpenQuickBrowserMenuItemIssuePattern = @"kXcodeOpenQuickBrowserMenuItemIssuePattern";
NSString* kXcodeOpenQuickBrowserMenuItemIssueURLPattern = @"kXcodeOpenQuickBrowserMenuItemIssueURLPattern";

@implementation XcodeOpenQuickBrowserMenuItem

-(instancetype)initWithMenuTitle:(NSString*)menuTitle urlPattern:(NSString*)urlPattern shortcutKey:(NSString*)shortcutKey {
    self = [super init];
    
    if( self ) {
        _menuTitle = menuTitle;
        _urlPattern = urlPattern;
        _shortcutKey = shortcutKey;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if( self ) {
        _menuTitle = dictionary[kXcodeOpenQuickBrowserMenuItemTitle];
        _urlPattern = dictionary[kXcodeOpenQuickBrowserMenuItemURLPattern];
        _shortcutKey = dictionary[kXcodeOpenQuickBrowserMenuItemShortCutKey];
        if( dictionary[kXcodeOpenQuickBrowserMenuItemUseIssue] ) {
            _useIssue = [dictionary[kXcodeOpenQuickBrowserMenuItemUseIssue] boolValue];
            _issuePattern = dictionary[kXcodeOpenQuickBrowserMenuItemIssuePattern];
            _issueURLPattern = dictionary[kXcodeOpenQuickBrowserMenuItemIssueURLPattern];
        } else {
            _useIssue = NO;
        }
    }
    return self;
}

-(NSDictionary*)dictionary {
    return @{
             kXcodeOpenQuickBrowserMenuItemTitle: _menuTitle,
             kXcodeOpenQuickBrowserMenuItemURLPattern: _urlPattern,
             kXcodeOpenQuickBrowserMenuItemShortCutKey: _shortcutKey
             };
}

@end
