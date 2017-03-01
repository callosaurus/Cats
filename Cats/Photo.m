//
//  Photo.m
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype) initWithTitle:(NSString *)title IDNumber: (NSString *)idNumber andURL:(NSString *)url
{
        if (self == [super init]) {
            
            self.photoTitle = title;
            self.idNumber = idNumber;
            self.completeURL = url;
        }
        return self;
}

@end
