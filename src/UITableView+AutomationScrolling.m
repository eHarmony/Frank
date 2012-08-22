//
//  UITableView+AutomationScrolling.m
//  Frank
//
//  Created by Olivier Larivain on 8/21/12.
//
//

#import "UITableView+AutomationScrolling.h"

@implementation UITableView (AutomationScrolling)

- (void) scrollToRow: (NSInteger) row
           inSection: (NSInteger) section {
    [self scrollToRow: row
            inSection: section
     atScrollPosition: UITableViewScrollPositionNone];
}

- (void) scrollToRow: (NSInteger) row
           inSection: (NSInteger) section
    atScrollPosition: (UITableViewScrollPosition)scrollPosition {
    
#warning check for bounds
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: row
                                                inSection: section];
    
    [self scrollToRowAtIndexPath: indexPath
                atScrollPosition: scrollPosition
                        animated: NO];
}

@end
