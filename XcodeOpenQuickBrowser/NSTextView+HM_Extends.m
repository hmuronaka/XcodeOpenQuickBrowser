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
    
    NSRange range = [string ex_rangeOfIncludingCharacterSet:alphaNumUnderScoreSet position:pos];
    if( range.location == NSNotFound || range.length == 0 ) {
        return @"";
    }
    return [string substringWithRange:range];
}

-(NSString*)ex_currentIssue  {
    NSString* string = self.textStorage.string;
    
    NSInteger pos = [self ex_cursolPosition];
    
    NSMutableCharacterSet* charaSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [charaSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"_"]];
    [charaSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    [charaSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    NSRange range = [string ex_rangeOfIncludingCharacterSet:charaSet position:pos];
    
    if( range.location == NSNotFound || range.length == 0 ) {
        return @"";
    }
    
    NSString* word = [string substringWithRange:range];
    if( [word ex_findWithPattern:@"PS-[\\d]+"].location == NSNotFound ) {
        return @"";
    }
    return word;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private

@end