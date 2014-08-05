//
//  ViewController.m
//  MinAlertViewDemo
//
//  Created by Mustafin Askar on 05/08/2014.
//  Copyright (c) 2014 askar. All rights reserved.
//

#import "ViewController.h"
#import "MinAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MinAlertView *minAlertView = [[MinAlertView alloc] init];
    minAlertView.title = @"Would you like to share your Yums on Facebook?";
    minAlertView.message = @"Inspire your Facebook friends with your tasty discoveries.";
    [minAlertView addButtonWithTitle:@"YES" actionBlock:^{NSLog(@"yes");}];
    [minAlertView addButtonWithTitle:@"NO" actionBlock:^{NSLog(@"no");}];
    [minAlertView showAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
