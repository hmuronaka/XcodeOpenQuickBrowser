//
//  NSTextView+Extends.m
//  Rakufun
//
//  Created by Muronaka Hiroaki on 2014/11/01.
//  Copyright (c) 2014年 Muronaka Hiroaki. All rights reserved.
//

#import "NSTextView+HM_Extends.h"
#import "NSString+HM_Extends.h"

@implementation NSTextView (HM_Extends)


-(NSInteger)ex_cursolPosition {
    return [[[self selectedRanges] objectAtIndex:0] rangeValue].location;
}

// カーソル行を返す
-(NSString*)ex_currentLine {
    NSString* line = [self.textStorage.string ex_getLineFromPos:[self ex_cursolPosition]];
    return line;
}

-(NSString*)ex_currentWord  {
    NSString* string = self.textStorage.string;
    
    NSInteger pos = [self ex_cursolPosition];
    
    NSMutableCharacterSet* alphaNumUnderScoreSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [alphaNumUnderScoreSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"_"]];
    
    if( [[alphaNumUnderScoreSet invertedSet] characterIsMember:[string characterAtIndex:pos]] ) {
        return @"";
    }
    
    
    // 前方探索
    NSInteger begin = pos;
    while( begin - 1 >= 0 ) {
        if( ![alphaNumUnderScoreSet characterIsMember:[string characterAtIndex:begin - 1]] ) {
            break;
        }
        --begin;
    }
    
    NSInteger end = pos + 1;
    while( end < string.length ) {
        if( ![alphaNumUnderScoreSet characterIsMember:[string characterAtIndex:end]] ) {
            break;
        }
        ++end;
    }
    
    NSRange range = NSMakeRange(begin, end - begin);
    return [string substringWithRange:range];
}

@end