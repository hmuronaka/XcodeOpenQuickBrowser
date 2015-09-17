//
//  XcodeOpenQuickBrowser.m
//  XcodeOpenQuickBrowser
//
//  Created by Muronaka Hiroaki on 2015/09/13.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "XcodeOpenQuickBrowser.h"
#import "XcodeHelper.h"
#import "NSTextView+HM_Extends.h"
#import "XcodeOpenQuickBrowserConfig.h"
#import "XcodeOpenQuickBrowserMenuItem.h"

#define NSLog(format, ...) NSLog(@"XOQB %20s%5d: " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// メニューのショートカットキー
// 必要に応じて変更してください.
// CTRL + DEFAULT_KEY
#define DEFAULT_KEY (@";")

static XcodeOpenQuickBrowser* _sharedInstance = nil;
static NSString* configFilename = @".xopenbrowser.json";


@interface XcodeOpenQuickBrowser()

@property(nonatomic, strong) XcodeOpenQuickBrowserConfig* config;

@end



@implementation XcodeOpenQuickBrowser

+(void)pluginDidLoad:(NSBundle*)plugin {
    [self sharedInstance];
}

#pragma mark class methods.

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark instance methods.

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification object:nil];
        
        self.config = [XcodeOpenQuickBrowserConfig loadWithFilename:configFilename];
    }
    return self;
}

-(void)applicationDidFinishLaunching:(NSNotification*)noti {
    NSLog(@"@@@@@");
    [self initMenu];
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark menu

-(void)initMenu {
    
    [_config.menuItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XcodeOpenQuickBrowserMenuItem* menuItem = obj;
        [self createMenuItem:menuItem parent:@"Edit" tag:(idx + 1)];
    }];
    
}

-(NSMenuItem*)createMenuItem:(XcodeOpenQuickBrowserMenuItem*)menuItem parent:(NSString*)parent tag:(NSUInteger)tag {
    NSMenu* mainMenu = [NSApp mainMenu];
    
    NSMenuItem* parentItem = [mainMenu itemWithTitle:parent];
    NSLog(@"parentItem=%@", parentItem);
    NSMenuItem* childItem = [[NSMenuItem alloc] initWithTitle:menuItem.menuTitle action:@selector(clickMenu:) keyEquivalent:menuItem.shortcutKey];
    childItem.tag = tag;
    [childItem setKeyEquivalentModifierMask:NSControlKeyMask];
    [childItem setTarget:self];
    [[parentItem submenu] addItem:childItem];
    return childItem;
}

-(void)clickMenu:(id)sender {
    
    NSMenuItem* menuItem = sender;
    NSTextView* textView = [XcodeHelper currentSourceCodeView];
    
    
    NSString* urlStr = nil;
    NSString* issue = [textView ex_currentIssue];
    if( [issue isEqualToString:@""] ) {
        NSString* currentWord = [textView ex_currentWord];
        NSLog(@"current word=%@", currentWord);
        
        XcodeOpenQuickBrowserMenuItem* xcodeOpenQuickBrowserMenuItem = [self.config menuItemAtIndex:menuItem.tag - 1];
        NSString* urlPattern = xcodeOpenQuickBrowserMenuItem.urlPattern;
        urlStr = [NSString stringWithFormat:urlPattern, [textView ex_currentWord]];
    } else {
        // github, bitbucket issue.
        urlStr = [NSString stringWithFormat:@"https://your.domain/%@", issue];
    }
    
    // As recommended for OS X >= 10.6.
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlStr]];
    
}

@end
