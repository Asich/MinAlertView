//
// Created by Mustafin Askar on 05/08/2014.
// Copyright (c) 2014 Crystal Spring. All rights reserved.
//

#import "MinAlertView.h"


#define kDefHolderViewWidth 320

@implementation MinAlertView {
    UIView *holderView;
    UILabel *titleLabel;
    NSMutableArray *buttonsArray;
    NSMutableArray *buttonActionsArray;
}

- (id)init {
    CGRect windowFrame = [self delegateWindow].bounds;
    if ( self = [super initWithFrame:windowFrame] ) {
        [self configUI];
    }
    return self;
}

#pragma mark - setters

- (void)setTitle:(NSString *)title {
    _title = title;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDefHolderViewWidth - 20, 1)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 2;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.text = title;
    [titleLabel sizeToFit];

    CGRect labelFrame = titleLabel.frame;
    labelFrame.origin.x = (CGFloat) ((holderView.frame.size.width - titleLabel.frame.size.width) * 0.5);
    labelFrame.origin.y = 50;
    titleLabel.frame = labelFrame;

    [holderView addSubview:titleLabel];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDefHolderViewWidth - 20, 1)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    messageLabel.textColor = [UIColor grayColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 2;
    messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    messageLabel.text = message;
    [messageLabel sizeToFit];

    CGRect labelFrame = messageLabel.frame;
    labelFrame.origin.x = (CGFloat) ((holderView.frame.size.width - messageLabel.frame.size.width) * 0.5);
    labelFrame.origin.y = [self bottomOfView:titleLabel] + 30;
    messageLabel.frame = labelFrame;

    [holderView addSubview:messageLabel];

    //200 px
}

- (void)addButtonWithTitle:(NSString *)title actionBlock:(ButtonClickBlock)actionBlock {
    if (buttonsArray.count <= 2) {
        NSUInteger btnTag = 0;

        if (!buttonsArray) {
            buttonsArray = [[NSMutableArray alloc] init];
            buttonActionsArray = [[NSMutableArray alloc] init];

            btnTag = 0;
        } else {
            btnTag = buttonsArray.count - 1;
        }

        UIView *lastButton = [buttonsArray lastObject];
        CGFloat yOffset = 200;
        if (lastButton) {
            yOffset = [self bottomOfView:lastButton];
        }

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, yOffset, kDefHolderViewWidth, 60);
        [button setBackgroundColor:[self colorFromRGB:0x40A19C]];
        button.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
        button.tag = btnTag;
        if (title) {
            [button setTitle:title forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        [holderView addSubview:button];
        [buttonsArray addObject:button];
        if (actionBlock) {
            [buttonActionsArray addObject:actionBlock];
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    ButtonClickBlock buttonClickBlock = [buttonActionsArray objectAtIndex:(NSUInteger) button.tag];
    if (buttonClickBlock) {
        buttonClickBlock();
    }
}

#pragma mark - animations

- (void)showAnimated:(BOOL)animated {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }];
}

- (void)hideAnimated:(BOOL)animated {

}

#pragma mark - config ui

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];
    self.alwaysBounceVertical = YES;

    holderView = [UIView new];
    holderView.frame = CGRectMake(0, (CGFloat) (( self.frame.size.height - kDefHolderViewWidth ) * 0.5),
            kDefHolderViewWidth, kDefHolderViewWidth);
    holderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:holderView];

    [self.delegateWindow addSubview:self];
}

#pragma mark - helper methods

- (CGFloat)bottomOfView:(UIView *)view
{
    return view.frame.origin.y + view.frame.size.height;
}

- (UIWindow *)delegateWindow {
    return [[[UIApplication sharedApplication] delegate] window];
}

- (UIColor *)colorFromRGB:(int)rgb {
    return [UIColor colorWithRed:(CGFloat) (((CGFloat) ((rgb & 0xFF0000) >> 16)) / 255.0) green:(CGFloat) (((float) ((rgb & 0xFF00) >> 8)) / 255.0) blue:(CGFloat) (((float) (rgb & 0xFF)) / 255.0) alpha:1.0];
}

@end