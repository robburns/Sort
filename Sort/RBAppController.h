//
//  RBAppController.h
//  Sort
//
//  Created by Robert Burns on 8/07/13.
//  Copyright (c) 2013 Robert Burns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBAppController : NSObject <NSTableViewDelegate, NSTableViewDataSource, NSMenuDelegate>
{
    NSWindow *window;
    NSView *view;
    IBOutlet NSArrayController *myTableArray;
    IBOutlet NSTableView *table;
    NSArray *wordArray;
    NSArray *sortedArray;
}

@property (assign) IBOutlet NSWindow *window;

@end
