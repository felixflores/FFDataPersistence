//
//  NSManagedObject+FFDataPersistence.m
//  CoreDataExample
//
//  Created by Felix Flores on 12/18/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import "NSManagedObject+FFDataPersistence.h"

@implementation NSManagedObject (FFDataPersistence)
- (id)initInDataPersistenceContext
{
    NSString *className = NSStringFromClass([self class]);
    self = [[FFDataPersistence sharedInstance] entityWithName:className];
    
    return self;
}

- (void)save
{
    [[FFDataPersistence sharedInstance] saveContext];
}

- (void)saveAndWait
{
    [[FFDataPersistence sharedInstance] saveContextAndWait];
}
@end
