//
// Created by Mustafin Askar on 05/08/2014.
// Copyright (c) 2014 Crystal Spring. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ButtonClickBlock)();

@interface MinAlertView : UIScrollView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;

- (void)showAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;

- (void)addButtonWithTitle:(NSString *)title actionBlock:(ButtonClickBlock)actionBlock;

@end