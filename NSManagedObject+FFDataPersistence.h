//
//  NSManagedObject+FFDataPersistence.h
//  CoreDataExample
//
//  Created by Felix Flores on 12/18/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (FFDataPersistence)
- (id)initInDataPersistenceContext;
- (void)save;
- (void)saveAndWait;
@end
