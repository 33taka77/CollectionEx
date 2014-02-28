//
//  ViewController.m
//  CollectionExample
//
//  Created by 相澤 隆志 on 2014/02/23.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "ViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCell.h"


@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIToolbar* toolBar;
@property (nonatomic, weak) IBOutlet UITextField* textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* shareButton;
@property (nonatomic, strong) NSMutableDictionary* searchResults;
@property (nonatomic, strong) NSMutableArray* searches;
@property (nonatomic, strong) Flickr* flockr;
@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;

- (IBAction)shareButtonTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.searchResults = [@{} mutableCopy];
    self.searches = [@[] mutableCopy];
    self.flockr = [[Flickr alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    UIImage* navBarImage = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 27, 27, 27)];
    [self.toolBar setBackgroundImage:navBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImage* shareButtonImage = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.shareButton setBackButtonBackgroundImage:shareButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage* textFieldImage = [[UIImage imageNamed:@"search_field.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:textFieldImage];
    //self.textField.delegate = self;
    [self.collectionView registerClass:[FlickrPhotoCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonTapped:(id)sender
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [self.flockr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if( results && results.count > 0 )
        {
            if( ![self.searches containsObject:searchTerm] )
            {
                NSLog(@"Found %d photos matching %@", [results count],searchTerm);
                [self.searches insertObject:searchTerm atIndex:0];
                self.searchResults[searchTerm] = results;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }else
            NSLog(@"Error searching Flickr");
    }];
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString* searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.searches.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrPhotoCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSString* searchTrem = self.searches[indexPath.section];
    cell.photo = self.searchResults[searchTrem][indexPath.row];
    return cell;
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* searchTerm = self.searches[indexPath.section];
    FlickrPhoto* photo = self.searchResults[searchTerm][indexPath.row];
    
    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    retval.height += 35; retval.width += 35;
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

@end
