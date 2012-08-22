//
//  UITableView+AutomationScrolling.h
//  Frank
//
//  Created by Olivier Larivain on 8/21/12.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (AutomationScrolling)

- (void) scrollToRow: (NSInteger) row
           inSection: (NSInteger) section;

- (void) scrollToRow: (NSInteger) row
           inSection: (NSInteger) section
    atScrollPosition: (UITableViewScrollPosition)scrollPosition;

@end
