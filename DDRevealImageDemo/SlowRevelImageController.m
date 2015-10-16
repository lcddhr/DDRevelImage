//
//  SlowRevelImageController.m
//  DDRevealImageDemo
//
//  Created by lovelydd on 15/10/16.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "SlowRevelImageController.h"
#import "UIView+RevealAnimation.h"

@interface SlowRevelImageController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SlowRevelImageController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.imageView dd_slowRevealAnimation];
}
@end
