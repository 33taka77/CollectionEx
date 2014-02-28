//
//  FlickrPhotoCell.h
//  CollectionExample
//
//  Created by Aizawa Takashi on 2014/02/28.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class FlickrPhoto;

@interface FlickrPhotoCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) FlickrPhoto* photo;

@end
