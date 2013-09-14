//
//  QuadTree.h
//  QuadTree2
//
//  Created by Waleed Azhar on 9/13/2013.
//  Copyright (c) 2013 Waleed Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataPoint.h"


@interface QuadTree : NSObject

@property (nonatomic,assign) CGRect region;
@property (nonatomic,assign) int depth;

-(BOOL)insertPoint:(DataPoint*)dp;
-(NSArray*)pointsInRect:(CGRect)rect;
-(id)initWithRegion:(CGRect)region andDepth:(int)depth;


@end
