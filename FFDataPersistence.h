//
//  FFDataPersistence.h
//  FFDataPersistence
//
//  Created by Felix Flores on 11/30/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFDataPersistence : NSObject

@property (nonatomic, strong) NSManagedObjectContext *privateManagedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, getter=isStarted) BOOL started;

+ (FFDataPersistence *)sharedInstance;
- (NSEntityDescription *)entityDescriptionForEntity:(NSString *)entityName;
- (id)createEntity:(NSString *)entityName;
@end
