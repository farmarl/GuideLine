 

#import "FriendListViewController.h"

struct FriendInfo{
    NSString *friendId  ;
    NSString *isTopStr  ;
    NSString *friendName  ;
    NSString *friendStatus  ;
    NSString *friendUpdateDate  ;
};

@interface FriendListViewController (){
    NSMutableArray *tableDataArray; //本
    NSMutableArray *searchContactDataArray;//暫存
    
    NSMutableArray *isTopArray;
    NSMutableArray *friendStatusArray;
    NSMutableArray *friendUpdateDateArray;
    NSMutableArray *friendIdArray;
    
 

}

@end

@implementation FriendListViewController

@synthesize friendList;

@synthesize searchbarContacts;

- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.searchbarContacts.delegate = self;
    self.friendList.dataSource = self;
    
    tableDataArray = [[NSMutableArray alloc]init];
    searchContactDataArray = [[NSMutableArray alloc]init];
    
    isTopArray = [[NSMutableArray alloc]init];
    friendStatusArray = [[NSMutableArray alloc]init];
    friendUpdateDateArray = [[NSMutableArray alloc]init];
    friendIdArray = [[NSMutableArray alloc]init];
    
    

    
    
  
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSString *caseString = [userDefaults stringForKey:@"case"] ;
   
    
    if( [caseString  isEqual: @"case1"]){
        
       [self loadCase1];
    }else if ( [caseString  isEqual: @"case2"]){
        [self loadCase2];
    }else if ( [caseString  isEqual: @"case3"]){
        [self loadCase3];
    }
}

//private method
- (void)loadCase1{
    printf("in loadCase1 "  );
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"https://dimanyen.github.io/friend4.json"]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"text/plain" forHTTPHeaderField:@"Accept"];

            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
      
                NSArray *values = [jsonDict objectForKey:@"response"];
                if (values.count > 0 ){
                    [self changeCenterView];
                    for( NSDictionary *everyFriend in values){
     
                        NSInteger b = [[everyFriend objectForKey:@"status"] integerValue];
                        if( b < 2 ){
                            
                            [self->tableDataArray addObject:[everyFriend objectForKey:@"name"]];
                            [self->isTopArray addObject:[everyFriend objectForKey:@"isTop"]];
                            [self->friendStatusArray addObject:[everyFriend objectForKey:@"status"]];
                            [self->friendUpdateDateArray addObject:[everyFriend objectForKey:@"updateDate"]];
                            [self->friendIdArray addObject:[everyFriend objectForKey:@"fid"]];
                            
                        }
     
                    }
                 
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->friendList reloadData];
                   
                     });
                }
              
                
        }] resume];
     
}
- (void)loadCase2{
    printf("in loadCase2 "  );
    
    [self changeCenterView];
    dispatch_queue_t queue = dispatch_queue_create("myConcurrentDispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //call API 2-(2)
    });
    dispatch_async(queue, ^{
        //call API 2-(3)
    });
}
- (void)loadCase3{
    printf("in loadCase3 "  );
    [self changeCenterView];
 
     
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"https://dimanyen.github.io/friend3.json"]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"text/plain" forHTTPHeaderField:@"Accept"];

            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
      
                NSArray *values = [jsonDict objectForKey:@"response"];
              
                for( NSDictionary *everyFriend in values){
 
                    NSInteger b = [[everyFriend objectForKey:@"status"] integerValue];
                    if( b < 2 ){
                        
                        [self->tableDataArray addObject:[everyFriend objectForKey:@"name"]];
                        [self->isTopArray addObject:[everyFriend objectForKey:@"isTop"]];
                        [self->friendStatusArray addObject:[everyFriend objectForKey:@"status"]];
                        [self->friendUpdateDateArray addObject:[everyFriend objectForKey:@"updateDate"]];
                        [self->friendIdArray addObject:[everyFriend objectForKey:@"fid"]];
                        
                    }
 
                }
             
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self->friendList reloadData];
               
                 });
        }] resume];
    
}

- (void)changeCenterView{
    friendListView.frame = centerView.bounds;
    [centerView addSubview:friendListView];
    [friendList reloadData];
}

#pragma mark - UITableViewDataSource
 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if  (searchbarContacts.text.length > 0){
        return [searchContactDataArray count];
    }else{
        return [tableDataArray count];
    }

}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"friendCell";
     
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
     
    
    if  (searchbarContacts.text.length > 0){
        
      //  cell.textLabel.text = [searchContactDataArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = [searchContactDataArray objectAtIndex:indexPath.row];
    }
    else {
        
      //  cell.textLabel.text = [tableDataArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = [tableDataArray objectAtIndex:indexPath.row];
    }
    
    return cell;
     
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    if (searchbarContacts.text.length == 0){

        

        [self.searchbarContacts endEditing:YES];

    }else {

       

        searchContactDataArray = [[NSMutableArray alloc]init];

     for (NSString *device in tableDataArray) {

            NSRange range = [device rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if (range.location != NSNotFound) {

                [searchContactDataArray addObject:device];

            }

        }

    }

    [self.friendList reloadData];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
