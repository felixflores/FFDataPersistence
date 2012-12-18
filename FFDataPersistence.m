//
//  FFDataPersistence.m
//  FFDataPersistence
//
//  Created by Felix Flores on 11/30/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import "FFDataPersistence.h"

@implementation FFDataPersistence

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        [self start];
    }
    
    return _managedObjectContext;
}

+ (FFDataPersistence *)sharedInstance
{
    static FFDataPersistence *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (NSEntityDescription *)entityDescriptionWithName:(NSString *)entityName
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:[self managedObjectContext]];
    
    return entity;
}

- (id)entityWithName:(NSString *)entityName
{
    NSEntityDescription *entityDesc = [self entityDescriptionWithName:entityName];
    
    return [[NSManagedObject alloc] initWithEntity:entityDesc
                    insertIntoManagedObjectContext:[self managedObjectContext]];
}

@end
