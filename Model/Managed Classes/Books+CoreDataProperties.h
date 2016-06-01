//
//  Books+CoreDataProperties.h
//  ProjectVaia
//
//  Created by UsFromMini on 2/22/16.
//  Copyright © 2016 Jamil. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Books.h"

NS_ASSUME_NONNULL_BEGIN

@interface Books (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *category;

@end

NS_ASSUME_NONNULL_END
