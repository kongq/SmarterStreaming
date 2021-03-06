//
//  SettingView.m
//  SmartiOSPlayer
//
//  GitHub: https://github.com/daniulive/SmarterStreaming
//
//  Created by daniulive on 16/3/24.
//  Copyright © 2016年 daniulive. All rights reserved.

#import "SettingView.h"
#import "ViewController.h"

#define kBtnHeight     50
#define kHorMargin     10
#define kVerMargin     80

@interface SettingView ()
{
    NSString *baseURL;
}

@property (nonatomic, strong) UINavigationBar *nvgBar;

@property (nonatomic, strong) UIButton *cdnServerBtn;
@property (nonatomic, strong) UIButton *daniuServerBtn;

@property (nonatomic, strong) UIButton *interPlaybackView;

@property (nonatomic,strong) UILabel *cdnServerLable;
@property (nonatomic,strong) UILabel *mediumQualityLable;
@property (nonatomic,strong) UILabel *daniuServerLable;

@property (nonatomic, strong) UITextField *urlID;

- (void)qualityButtonClicked:(id)sender;

@end

@implementation SettingView

@synthesize nvgBar;
@synthesize cdnServerBtn;
@synthesize daniuServerBtn;
@synthesize cdnServerLable;
@synthesize mediumQualityLable;
@synthesize daniuServerLable;
@synthesize interPlaybackView;


#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //当前屏幕宽高
    CGFloat screenWidth  = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    //导航栏:直播设置
    
    [self.navigationItem setTitle:@"大牛直播播放端V1.0.06.05.05"];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    

    CGFloat buttonWidth = screenWidth - kHorMargin*2;
    
    CGFloat buttonSpace = (screenWidth - 2*kHorMargin-160)/6;
    
    //直播地址
    self.urlID = [[UITextField alloc] initWithFrame:CGRectMake(kHorMargin, kVerMargin, buttonWidth, kBtnHeight)];
    [self.urlID setBackgroundColor:[UIColor whiteColor]];
    self.urlID.placeholder = @"请输入播放urlID（推流url中，stream后的部分）";
    self.urlID.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    self.urlID.borderStyle = UITextBorderStyleRoundedRect;
    self.urlID.autocorrectionType = UITextAutocorrectionTypeNo;
    self.urlID.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.urlID addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.urlID.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //[self.urlID setText:[NSString stringWithFormat:@"t1"]];
    
    //直播视频质量
    self.daniuServerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.daniuServerBtn.tag = 1;
    self.daniuServerBtn.frame = CGRectMake(kHorMargin+buttonSpace, kVerMargin+kBtnHeight+80, 20, 20);
    [self.daniuServerBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
    [self.daniuServerBtn addTarget:self action:@selector(qualityButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    self.daniuServerLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+buttonSpace+20, kVerMargin+kBtnHeight+80, 40, 20)];
    self.daniuServerLable.text = @"大牛";
    self.cdnServerLable.lineBreakMode = NSLineBreakByCharWrapping;
    self.daniuServerLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

    self.cdnServerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cdnServerBtn.tag = 2;
    
    self.cdnServerBtn.frame = CGRectMake(screenWidth-kHorMargin-buttonSpace-60,kVerMargin+kBtnHeight+80,20,20);
    [self.cdnServerBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.cdnServerBtn addTarget:self action:@selector(qualityButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.cdnServerLable = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-kHorMargin-buttonSpace-40,kVerMargin+kBtnHeight+80,40,20)];
    self.cdnServerLable.text = @"CDN";
    self.cdnServerLable.lineBreakMode = NSLineBreakByCharWrapping;
    self.cdnServerLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    //进入播放页面
    self.interPlaybackView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.interPlaybackView.tag = 3;
    self.interPlaybackView.frame = CGRectMake(kHorMargin, kVerMargin+kBtnHeight+80+80+20, buttonWidth, kBtnHeight);
    [self.interPlaybackView setTitle:@"进入播放页面" forState:UIControlStateNormal];
    [self.interPlaybackView setBackgroundImage:[UIImage imageNamed:@"start_playback"] forState:UIControlStateNormal];
    self.interPlaybackView.titleLabel.textColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.interPlaybackView addTarget:self action:@selector(interPlaybackViewBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nvgBar];
    [self.view addSubview:self.cdnServerBtn];
    [self.view addSubview:self.daniuServerBtn];
    [self.view addSubview:self.interPlaybackView];
    [self.view addSubview:self.cdnServerLable];
    [self.view addSubview:self.mediumQualityLable];
    [self.view addSubview:self.daniuServerLable];
    [self.view addSubview:self.urlID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //默认baseURL
    baseURL = @"rtmp://daniulive.com:1935/hls/stream";

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Buttons methods
- (void)qualityButtonClicked:(id)sender {
    
    UIButton *serverSelBtn = (UIButton *)sender;

    
    switch (serverSelBtn.tag) {
        case 1: {
            [self.cdnServerBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.daniuServerBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            baseURL = @"rtmp://daniulive.com:1935/hls/stream";
            break;
        }
        case 2: {
            
            [self.cdnServerBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.daniuServerBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
             baseURL = @"rtmp://play.daniulive.8686c.com/live/stream";
            break;
        }
        default:
            break;
    }
}

#pragma mark - textField method
- (void)textFieldDone:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (void)interPlaybackViewBtnPressed:(id)sender {
    
    NSString* playbackURL = [baseURL stringByAppendingString:self.urlID.text];
    
    NSLog(@"pass playbackURL:%@", playbackURL);
    
    ViewController * coreView =[[ViewController alloc] initParameter:playbackURL];
    [self presentViewController:coreView animated:YES completion:nil];
}

@end
