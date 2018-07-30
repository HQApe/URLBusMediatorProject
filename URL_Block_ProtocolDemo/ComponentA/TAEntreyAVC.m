//
//  TAEntreyVC.m
//  Pods-TargetActionComponentA_Example
//
//  Created by Ape on 2018/7/28.
//

#import "TAEntreyAVC.h"
#import "TAentryADetailVC.h"
#import "LDBusMediator.h"
#import "ComponentAEnteryServicePrt.h"
@interface TAEntreyAVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TAEntreyAVC

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TargetA";
    if (self.entrySource) {
        self.title = [NSString stringWithFormat:@"TargetA from %@", self.entrySource];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(gotoOtherComponent)];
    
    [self.view addSubview:self.tableView];
}

- (void)gotoOtherComponent {
    
//    [LDBusMediator routeURL:[NSURL URLWithString:@"URL://TAEntreyB"]];
    
    [[LDBusMediator serviceForProtocol:@protocol(ComponentAEnteryServicePrt)] componentA_jumpToComponentB];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"TargetDetail%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TAentryADetailVC *detailVC = [[TAentryADetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
