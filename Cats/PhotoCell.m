//
//  PhotoCell.m
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "PhotoCell.h"


@implementation PhotoCell

-(void)setPhoto:(Photo *)photo {
    _photo = photo;
    
    [self setup];
}

-(void)setup {
    
    [self downloadPhoto];
    
    self.photoCellLabel.text = self.photo.photoTitle;
}

-(void)downloadPhoto {

    NSLog(@"%@", self.photo.completeURL);
    
//    [[NSURLComponents alloc] initWithString:self.photo.completeURL];
    
    NSURL *photoURL = [NSURL URLWithString:self.photo.completeURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:photoURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        UIImage *imageToBeDisplayed = [UIImage imageWithData:data];
        
        self.photo.photoImage = imageToBeDisplayed;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.photoCellImageView.image = imageToBeDisplayed;
        }];
        
    }];
    
    [downloadTask resume];
    
}

@end
