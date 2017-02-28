//
//  Photo.m
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(void)makeCompleteURL
{
    self.completeURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.farmID, self.serverID, self.idNumber, self.secret]];
}

@end
