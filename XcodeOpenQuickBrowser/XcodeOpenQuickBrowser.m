//
//  XcodeOpenQuickBrowser.m
//  XcodeOpenQuickBrowser
//
//  Created by Muronaka Hiroaki on 2015/09/13.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "XcodeOpenQuickBrowser.h"

#define NSLog(format, ...) NSLog(@"%20s%5d: " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

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
    [self initMenu];
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark menu

-(void)initMenu {
    
}

@end
