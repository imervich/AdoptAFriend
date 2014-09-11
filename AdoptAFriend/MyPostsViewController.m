//
//  MyPostsViewController.m
//  AdoptAFriend
//
//  Created by Efrén Reyes Torres on 9/9/14.
//  Copyright (c) 2014 Iván Mervich - Efrén Reyes. All rights reserved.
//

#import "MyPostsViewController.h"

//Tab bar item indexes
#define tabBarItemGiveInAdoption 0
#define tabBarItemDeletePost 1

@interface MyPostsViewController () <UITabBarDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITabBar *postOptionsTabBar;
@property (weak, nonatomic) IBOutlet UIScrollView *giveInAdoptionScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *deletePostScrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIPickerView *interestedUsersPicker;
@property NSArray *interestedUsers;

@end

@implementation MyPostsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interestedUsers = [NSArray array];
    self.deletePostScrollView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.postOptionsTabBar.selectedItem = self.postOptionsTabBar.items[tabBarItemGiveInAdoption];
    PFRelation *relation = [self.post relationForKey:@"intrested"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.interestedUsers = objects;
            [self.interestedUsersPicker reloadAllComponents];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)onSubmitButtonPressed:(id)sender
{
    NSLog(@"Submit pressed");
}

- (IBAction)onDeleteButtonPressed:(id)sender
{
    NSLog(@"Delete pressed");
}

//#pragma mark - UIPickerViewDataSource
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    NSLog(@"Selected row %d", row);
//}

#pragma mark - UIPickerViewDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.interestedUsers.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    User *user = [self.interestedUsers objectAtIndex:row];
    NSString *name = [NSString stringWithFormat:@"%@ %@", user.name, user.lastName];
    return name;
}

#pragma mark - Navigation
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item isEqual:self.postOptionsTabBar.items[tabBarItemDeletePost]]) {
        self.giveInAdoptionScrollView.hidden = YES;
        self.deletePostScrollView.hidden = NO;
    } else {
        self.deletePostScrollView.hidden = YES;
        self.giveInAdoptionScrollView.hidden = NO;
    }
}

@end
