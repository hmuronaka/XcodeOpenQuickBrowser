//
//  XcodeOpenQuickBrowserConfig.m
//  XcodeOpenQuickBrowser
//
//  Created by MuronakaHiroaki on 2015/09/16.
//  Copyright © 2015年 Muronaka Hiroaki. All rights reserved.
//

#import "XcodeOpenQuickBrowserConfig.h"
#import "XcodeOpenQuickBrowserMenuItem.h"

#define NSLog(format, ...) NSLog(@"%20s%5d: " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

@interface XcodeOpenQuickBrowserConfig()

@property(nonatomic, strong) NSArray* menuItems;

@end

@implementation XcodeOpenQuickBrowserConfig

-(instancetype)initWithFilename:(NSString*)filename {
    
    self = [super init];
    
    if( self ) {
        self.filename = filename;
    }
    
    return self;
}

-(NSString*)fullPath {
    NSString* homePath = NSHomeDirectory();
    return [homePath stringByAppendingPathComponent:self.filename];
}

-(XcodeOpenQuickBrowserMenuItem*)menuItemAtIndex:(NSUInteger)index {
    return self.menuItems[index];
}

-(void)load {
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:self.fullPath] ) {
        NSError* error = nil;
        NSString* str = [NSString stringWithContentsOfFile:self.fullPath encoding:NSUTF8StringEncoding error:&error];
        
        if( error ) {
            NSLog(@"error=%@", error);
            return;
        }
        
        NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if( json == nil || error ) {
            NSLog(@"error=%@", error);
            return;
        }
        
        [self hm_parseJSON:json];
    } else {
        self.menuItems = @[
                           [[XcodeOpenQuickBrowserMenuItem alloc] initWithMenuTitle:@"browse current word"
                               urlPattern:@"https://www.google.co.jp/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=%@+reference"
                           shortcutKey:@";"]];
        [self save];
    }
}

-(void)save {
    
    NSMutableArray* menuItemsJSON = [NSMutableArray array];
    
    [self.menuItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XcodeOpenQuickBrowserMenuItem* menuItem = obj;
        [menuItemsJSON addObject:[menuItem dictionary]];
    }];
    
    NSDictionary* json = @{
                           @"menuItems": menuItemsJSON
                           };
    NSOutputStream *os = [[NSOutputStream alloc] initToFileAtPath:self.fullPath append:NO];
    [os open];
    NSError* error = nil;
    [NSJSONSerialization writeJSONObject:json toStream:os options:NSJSONWritingPrettyPrinted error:&error];
    [os close];
    
    if( error ) {
        NSLog(@"error = %@", error);
    }
}

-(void)test {
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private

-(void)hm_parseJSON:(NSDictionary*)json {
    
    NSMutableArray* menuItemsResult = [NSMutableArray array];
    
    NSArray* menuItemsJSON = json[@"menuItems"];
    [menuItemsJSON enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary* menuItemJSON = obj;
        XcodeOpenQuickBrowserMenuItem* menuItem = [[XcodeOpenQuickBrowserMenuItem alloc] initWithDictionary:menuItemJSON];
        [menuItemsResult addObject:menuItem];
    }];
    self.menuItems = menuItemsResult;
    
}

+(instancetype)loadWithFilename:(NSString*)filename {
    
    XcodeOpenQuickBrowserConfig* config = [[XcodeOpenQuickBrowserConfig alloc] initWithFilename:filename];
    [config load];
    return config;
}

@end
