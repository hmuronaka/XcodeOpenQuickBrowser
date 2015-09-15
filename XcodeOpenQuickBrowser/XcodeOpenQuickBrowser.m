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

#define NSLog(format, ...) NSLog(@"XOQB %20s%5d: " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// メニューのショートカットキー
// 必要に応じて変更してください.
// CTRL + DEFAULT_KEY
#define DEFAULT_KEY (@";")

@implementation XcodeOpenQuickBrowser

static XcodeOpenQuickBrowser* _sharedInstance = nil;

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
    [self createMenuItemWithName:@"OpenBrowser" action:@selector(clickMenu:) parentMenuName:@"Edit"];
}

-(NSMenuItem*)createMenuItemWithName:(NSString*)name action:(SEL)action parentMenuName:(NSString*)parent {
    NSMenu* mainMenu = [NSApp mainMenu];
    
    NSMenuItem* parentItem = [mainMenu itemWithTitle:parent];
    NSLog(@"parentItem=%@", parentItem);
    NSMenuItem* childItem = [[NSMenuItem alloc] initWithTitle:name action:action keyEquivalent:DEFAULT_KEY];
    [childItem setKeyEquivalentModifierMask:NSControlKeyMask];
    [childItem setTarget:self];
    [[parentItem submenu] addItem:childItem];
    return childItem;
}

-(void)clickMenu:(id)sender {
    NSTextView* textView = [XcodeHelper currentSourceCodeView];
    NSLog(@"current word=%@", [textView ex_currentWord]);
   
    // As recommended for OS X >= 10.6.
    NSString* url = [NSString stringWithFormat:@"https://www.google.co.jp/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=%@+reference", [textView ex_currentWord]];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    
}

@end
