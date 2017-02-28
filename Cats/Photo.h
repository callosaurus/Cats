//
//  Photo.h
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *farmID;
@property (nonatomic, strong) NSString *serverID;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *photoTitle;
@property (nonatomic, strong) NSURL *completeURL;

-(void)makeCompleteURL;

@end
