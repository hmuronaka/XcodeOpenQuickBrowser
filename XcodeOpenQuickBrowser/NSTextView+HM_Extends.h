//
//  NSTextView+Extends.h
//  Rakufun
//
//  Created by Muronaka Hiroaki on 2014/11/01.
//  Copyright (c) 2014年 Muronaka Hiroaki. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextView (HM_Extends)

-(NSInteger)ex_cursolPosition;
-(NSString*)ex_currentLine;
-(NSString*)ex_currentWord;
-(NSString*)ex_currentIssue:(NSString*)issuePattern;

@end
