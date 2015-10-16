//
//  ViewController.m
//  DDRevealImageDemo
//
//  Created by lovelydd on 15/10/16.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "ViewController.h"
#import "UIView+RevealAnimation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *revealView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (IBAction)startAnimation:(id)sender {
    
    [self.revealView dd_outLineAnimation];
    [self.imageView dd_revealAnimation];
    self.imageView.image = [UIImage imageNamed:@"testimage.jpg"];
}

- (void) triggerAnimations {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
