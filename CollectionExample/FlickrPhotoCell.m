//
//  FlickrPhotoCell.m
//  CollectionExample
//
//  Created by Aizawa Takashi on 2014/02/28.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "FlickrPhotoCell.h"
#import "FlickrPhoto.h"

@implementation FlickrPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPhoto:(FlickrPhoto *)photo
{
    if( _photo != photo )
    {
        _photo = photo;
    }
    self.imageView.image = _photo.thumbnail;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
