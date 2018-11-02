//
//  ViewController.m
//  CombineArrayOfDictsObjC
//
//  Created by Greg Alton on 10/31/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray* result;

NSArray* arrayOne;
NSArray* arrayTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOne  = @[@{@"id": @"1", @"location": @"Baltimore, MD"}, @{@"id": @"2", @"location": @"Chicago,IL"}];
    arrayTwo  = @[@{@"id": @"1", @"name": @"John Barnes"}, @{@"id": @"2", @"name": @"John Smith"}];
    
    NSArray* finalResult = [self combineArraysOfDictionaries:arrayOne :arrayTwo];
    NSLog(@"%@", finalResult);
}

- (NSArray *)combineArraysOfDictionaries:(NSArray *)firstArray :(NSArray *)secondArray {
    
    result = [NSMutableArray new];
    
    for (NSDictionary* dict1 in firstArray) {
        for (NSDictionary* dict2 in secondArray) {
            if([[dict1 objectForKey:@"id"] isEqual: [dict2 objectForKey:@"id"]]) {
                [result addObject:dict1];
            } else {
                [result addObject:[self coalesce:dict1 :dict2]];
            }
        }
    }
    return result;
}

- (NSDictionary*)coalesce:(NSDictionary *)dict1 :(NSDictionary *)dict2 {
    
    NSArray* arr1=[dict1 allKeys];
    NSArray* arr2=[dict2 allKeys];
    
    NSArray* allKeysArray=[arr1 arrayByAddingObjectsFromArray:arr2];
    
    NSMutableDictionary* newDict=[[NSMutableDictionary alloc]init];
    
    for (NSString *aKey in allKeysArray)
    {

        if ([arr1 containsObject:aKey])
        {
            [newDict setObject:dict1[aKey] forKey:aKey];
        }
        else if ([arr2 containsObject:aKey])
        {
            [newDict setObject:dict2[aKey] forKey:aKey];
        }
    }
    
    return newDict;
}


@end
