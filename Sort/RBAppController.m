//
//  RBAppController.m
//  Sort
//
//  Created by Robert Burns on 8/07/13.
//  Copyright (c) 2013 Robert Burns. All rights reserved.
//
//  The user opens the file that needs to be sorted. The programme reads the file into an array. Each
//  line of the file is an element in the array. Sort then reorders the array alphabetically
//  and displays the results in a 2-column table.

#import "RBAppController.h"

@implementation RBAppController

-(void)openPanelDidEnd:(NSOpenPanel *)openPanel returnCode:(int)returnCode contextInfo:(void *)x
{
	if (returnCode == NSOKButton) {
		NSURL *pathurl = [openPanel URL];
		if (pathurl) {
            NSString *contentOfFile = [NSString stringWithContentsOfFile:[pathurl path] encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"contentoffile = %@", contentOfFile);
            wordArray = [contentOfFile componentsSeparatedByString:@"\n"];
        } else{
            NSLog(@"unable to find file %@\n", pathurl);
        }
	}
    NSLog(@"wordArray = %@\n", wordArray);
    
    static NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch |
    NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSComparator finderSortBlock = ^(id string1, id string2) {
        
        NSRange string1Range = NSMakeRange(0, [string1 length]);
        return [string1 compare:string2 options:comparisonOptions range:string1Range locale:currentLocale];
    };
    
    sortedArray = [wordArray sortedArrayUsingComparator:finderSortBlock];
    [table reloadData];
}

-(IBAction)showOpenPanel:(id)sender
{
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	
	[panel beginSheetForDirectory:nil file:nil modalForWindow:window
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:NULL];
}

#pragma mark Table view data source methods
// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
//    NSLog(@"[wordArray count] = %lu\n", [wordArray count]);
    return [wordArray count];
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    NSLog(@"tableView willDisplayCell, tableColumn = %@ and row = %lu", [tableColumn identifier], row);
    
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
//        NSLog(@"tableView objectvalue for tableColumn = %@ and row = %lu", [tableColumn identifier], row);
        
    if ([[tableColumn identifier] isEqualToString:@"word"]) {
//        NSLog(@"returning %@\n", [wordArray objectAtIndex:row]);
        return [wordArray objectAtIndex:row];
    }
    
    if ([[tableColumn identifier] isEqualToString:@"sorted"]) {
//        NSLog(@"returning %@\n", [sortedArray objectAtIndex:row]);
        return [sortedArray objectAtIndex:row];
    }
    return nil;
}

@end
