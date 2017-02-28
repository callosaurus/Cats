//
//  PhotoCell.h
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoCellLabel;

@property (strong, nonatomic) Photo *photo;

@end
