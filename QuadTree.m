//
//  QuadTree.m
//  QuadTree2
//
//  Created by Waleed Azhar on 9/13/2013.
//  Copyright (c) 2013 Waleed Azhar. All rights reserved.
//

#import "QuadTree.h"
#define MAX_POINTS_IN_NODE 4
#define MAX_DEPTH_IN_TREE 5

@interface QuadTree ()

@property (nonatomic,strong) NSMutableArray* points;
@property (nonatomic,strong) NSMutableArray*quadTreeNodes;
@property(nonatomic, strong) QuadTree *northWest;
@property(nonatomic, strong) QuadTree *northEast;
@property(nonatomic, strong) QuadTree *southWest;
@property(nonatomic, strong) QuadTree *southEast;


@end
@implementation QuadTree
@synthesize depth = _depth;
@synthesize region=_region;
@synthesize points=_points;
@synthesize northEast=_northEast;
@synthesize northWest=_northWest;
@synthesize southEast =_southEast;
@synthesize southWest =_southWest;
@synthesize quadTreeNodes=_quadTreeNodes;

-(id)init{
    if (!self) {
        self = [super init];
    }
    [self setPoints:[[NSMutableArray alloc] init]];
    [self setQuadTreeNodes:[[NSMutableArray alloc] init]];

    
    return self;
}
-(id)initWithRegion:(CGRect)region andDepth:(int)depth{
    if (!self) {
        self = [super init];
    }
    [self setPoints:[[NSMutableArray alloc] init]];
    [self setQuadTreeNodes:[[NSMutableArray alloc] init]];

    [self setRegion:region];
    [self setDepth:depth];
    return self;
}


-(BOOL)insertPoint:(DataPoint *)dp{
    
    if (!(CGRectContainsPoint(self.region, dp.point))) {
        return false;
        
    }
    
    if (self.points.count <= MAX_POINTS_IN_NODE || self.depth > MAX_DEPTH_IN_TREE){
        [self.points addObject:dp];
        return true;
    }
    if (self.points.count >= MAX_POINTS_IN_NODE && self.depth < MAX_DEPTH_IN_TREE){
     
        if ((_northEast == nil)) {
            [self subDivide];
        }
        
        for (DataPoint*dp2 in self.points){
            for (QuadTree*node2 in self.quadTreeNodes ){
                
                if ([node2 insertPoint:dp2]){break;}
            }
            
        }
        [self.points removeAllObjects];
        
    }

    for (QuadTree*node in self.quadTreeNodes ){

        if( [node insertPoint:dp]) {return true;}
    }
    
    return false;
}
-(void)subDivide{
    float width = self.region.size.width * 0.5f;
    float x = self.region.origin.x;
    float y = self.region.origin.y;
    
    self.northWest = [[QuadTree alloc] initWithRegion:CGRectMake(x, y, width, width) andDepth:self.depth +1];
    self.northEast = [[QuadTree alloc] initWithRegion:CGRectMake(x + width, y, width, width) andDepth:self.depth +1];
    self.southWest = [[QuadTree alloc] initWithRegion:CGRectMake(x, y + width, width, width) andDepth:self.depth +1];
    self.southEast = [[QuadTree alloc] initWithRegion:CGRectMake(x + width, y + width, width, width) andDepth:self.depth +1];

    [self.quadTreeNodes addObject:self.northEast];
    [self.quadTreeNodes addObject:self.northWest];
    [self.quadTreeNodes addObject:self.southEast];
    [self.quadTreeNodes addObject:self.southWest];
}
-(NSArray*)pointsInRect:(CGRect)rect{
    
    if(!CGRectIntersectsRect(rect, self.region))
        return nil;
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    
    if(_northEast == nil){
        for (DataPoint *dp in self.points) {
            
            [array addObject:dp];
        }
    }
    
    for (QuadTree*node in self.quadTreeNodes )
        [array addObjectsFromArray: [node pointsInRect:rect]];
    
    
    return array;
}
         
@end
