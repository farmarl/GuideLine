 

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import "FriendTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface FriendListViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *userDefaults;

    __weak IBOutlet UIView *centerView;
     
     
    IBOutlet UIView *friendListView;
  
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchbarContacts;
@property (strong, nonatomic) IBOutlet UITableView *friendList;

@end

NS_ASSUME_NONNULL_END
