//
//  FFDataPersistence+Setup.m
//  FFDataPersistence
//
//  Created by Felix Flores on 12/6/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import "FFDataPersistence+Setup.h"

@implementation FFDataPersistence (Setup)

- (void)start
{
    if (![self isStarted]) {
        [self setupManagedObjectContext];
        [self startPersistentStore];
        [self setStarted:YES];
    }
}

- (void)setupManagedObjectContext
{
    NSURL *modelURL = modelURL = [[NSBundle mainBundle] URLForResource:@"TimeCapsule" withExtension:@"momd"];
    NSAssert(modelURL, @"Failed to file model URL");
    
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom, @"Failed to initialize model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSAssert(psc, @"Failed to initialize persistent store coordinator");
    
    NSManagedObjectContext *privateMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    [privateMOC setPersistentStoreCoordinator:psc];
    [self setPrivateManagedObjectContext:privateMOC];
    
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [moc setParentContext:privateMOC];
    
    [self setManagedObjectContext:moc];
}

- (void)startPersistentStore
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *storeURL = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    storeURL = [storeURL URLByAppendingPathComponent:kTCDatabaseName];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator *coordinator = [[self managedObjectContext] persistentStoreCoordinator];
    NSDictionary *options = @{
        NSMigratePersistentStoresAutomaticallyOption: @YES,
        NSInferMappingModelAutomaticallyOption: @YES
    };
    
    NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                         configuration:nil
                                                                   URL:storeURL
                                                               options:options
                                                                 error:&error];
    if (!store) {
        NSLog(@"Error adding persistent store to coordinator %@\n%@",
              [error localizedDescription], [error userInfo]);
        
        NSString *msg = [NSString stringWithFormat:@"There was a problem with database %@\n%@\n%@",
                         @"Please contact support to assist with this error.",
                         [error localizedDescription], [error userInfo]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:msg
                                                           delegate:self
                                                  cancelButtonTitle:@"Quit"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end
