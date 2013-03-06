//
//  ViewController.m
//  Categories
//
//  Created by Conroy, William | Liam | SDTD on 13/03/06.
//  Copyright (c) 2013年 Conroy, William | Liam | SDTD. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+NextHint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 50.0f, 50.0f, 50.0f)];
    [testView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:testView];
    [testView startHint];
    
    UIButton * hintSwitchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [hintSwitchButton setFrame:CGRectMake(50, 400, 100, 50)];
    [hintSwitchButton addTarget:testView action:@selector(endHint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hintSwitchButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
