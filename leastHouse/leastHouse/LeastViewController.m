//
//  LeastViewController.m
//  leastHouse
//
//  Created by DOO on 2016/7/28.
//  Copyright © 2016年 DOO. All rights reserved.
//

#import "LeastViewController.h"
#import "Least.h"

@interface LeastViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger i;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)NSMutableArray *leasts;

@end

@implementation LeastViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.leasts = [NSMutableArray array];
//        for (int i=0;i<3;i++)
//        {
//            Least *least = [[Least alloc]init];
//            least.text = [NSString stringWithFormat:@"New Least %d",i];
//            
////            NSDate *now = [NSDate date];
////            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
////            formatter.timeZone = [NSTimeZone systemTimeZone];
////            NSString *dataFormatter =[NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd" options:0 locale:[NSLocale systemLocale]];
////            formatter.dateFormat = dataFormatter;
//            
//            least.date = [self time];
//            
//            [self.leasts addObject:least];
//        
//        }
        
    }
    return self;
}

-(NSString*)time{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *dataFormatter =[NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd" options:0 locale:[NSLocale systemLocale]];
    formatter.dateFormat = dataFormatter;
    
    return [NSString stringWithFormat:@"%@",[formatter stringFromDate:now]];

}

- (IBAction)addLeast:(id)sender {
    
    Least *least = [[Least alloc]init];
least.text = [ NSString stringWithFormat:@"New Least %lu",(unsigned long)self.leasts.count];
    
    least.date = [self time];
    [self.leasts insertObject:least atIndex:0];

    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.leasts removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Least *least = self.leasts[sourceIndexPath.row];
    [self.leasts removeObjectAtIndex:sourceIndexPath.row];
    [self.leasts insertObject:least atIndex:destinationIndexPath.row];
    
    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource=self;
    self.tableView.delegate= self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITabelVeiwDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leasts.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subtitle" forIndexPath:indexPath];
    Least *least = [self.leasts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = least.text;
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@~%@",least.text,least.date];
    cell.showsReorderControl = YES;
    return cell;
    
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
