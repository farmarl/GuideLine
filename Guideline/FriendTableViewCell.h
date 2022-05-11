//
//  FriendTableViewCell.h
//  Guideline
//
//  Created by 傅家慶 on 2022/5/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *star;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

NS_ASSUME_NONNULL_END
