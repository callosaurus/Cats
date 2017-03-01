//
//  Photo.h
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Photo : NSObject <MKAnnotation> 

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *completeURL;
@property (nonatomic, strong) NSString *photoTitle;
@property (nonatomic, strong) UIImage *photoImage;
@property(nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype) initWithTitle:(NSString *)title IDNumber: (NSString *)idNumber andURL:(NSString *)url;

@end
