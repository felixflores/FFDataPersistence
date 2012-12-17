//
//  FFDataPersistence+Saving.h
//  FFDataPersistence
//
//  Created by Felix Flores on 12/1/12.
//  Copyright (c) 2012 felixflor.es. All rights reserved.
//

#import "FFDataPersistence.h"

@interface FFDataPersistence (Saving)
- (void)saveContext;
- (void)saveContextAndWait;
@end
