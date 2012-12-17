//
//  FFDataPersistence+Saving.m
//  FFDataPersistence
//
//  Created by Felix Flores on 12/1/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import "FFDataPersistence+Saving.h"

@implementation FFDataPersistence (Saving)

- (void)saveContext
{
    [self saveContextWithWait:NO];
}

- (void)saveContextAndWait
{
    [self saveContextWithWait:YES];
}

- (void)saveContextWithWait:(BOOL)wait
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    if (!moc || ![moc hasChanges]) return;
    
    [moc performBlockAndWait:^{
        NSError *error = nil;
        [moc save:&error];
        [self logSavingOfContextFor:@"Main" andError:error];
    }];
    
    NSManagedObjectContext *private = [self privateManagedObjectContext];
    
    void (^savePrivate) (void) = ^{
        NSError *error = nil;
        [private save:&error];
        [self logSavingOfContextFor:@"Private" andError:error];
    };
    
    if ([private hasChanges]) {
        if (wait) {
            [private performBlockAndWait:savePrivate];
        } else {
            [private performBlock:savePrivate];
        }
    }
}

- (void)logSavingOfContextFor:(NSString *)contextName andError:(NSError *)error
{
    if (error) {
        DLog(@"*** Error *** Saving managed context (%@):\n%@\n%@",
             contextName, [error localizedDescription], [error userInfo]);
    } else {
        DLog(@"Saving managed context (%@)", contextName);
    }
}

@end
