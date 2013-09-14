//
//  ViewController.m
//  QuadTree2
//
//  Created by Waleed Azhar on 9/13/2013.
//  Copyright (c) 2013 Waleed Azhar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    QuadTree* root = [[QuadTree alloc] initWithRegion:CGRectMake(0, 0, 320, 320) andDepth:1];
    DataPoint* dp;
	for( int i =1;i <100; i++){
        dp = [[DataPoint alloc] init];
        dp.point = CGPointMake(arc4random()%320, arc4random()%320);
        [root insertPoint:dp];
        //NSLog(@"hello");
    }

    
    NSArray* array = [root pointsInRect:CGRectMake(0, 0, 320, 320)];
    
    for (DataPoint*dp in array){
        
        UIView*circle = [[UIView alloc] initWithFrame:CGRectMake(dp.point.x, dp.point.y, 5, 5)];
        circle.backgroundColor = [UIColor redColor];
        [self.view addSubview:circle];
       // NSLog([NSString stringWithFormat:@"%d",array.count]);
    }
    
    NSArray* array2 = [root pointsInRect:CGRectMake(0,0, 320/2, 320/2)];
    for (DataPoint*dp in array2){
        UIView* circle2 = [[UIView alloc] initWithFrame:CGRectMake(dp.point.x, dp.point.y, 5, 5)];
        circle2.backgroundColor = [UIColor whiteColor];
        [circle2 setAlpha:.5];
        [self.view addSubview:circle2];
        //NSLog([NSString stringWithFormat:@"%d",array2.count]);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
