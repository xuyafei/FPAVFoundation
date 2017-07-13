//
//  ViewController.m
//  FPAVFoundation
//
//  Created by polycom on 2017/7/11.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#define RGB(r,g,b,a) [UIColor colorWithRed:((r)/255.0f) green:((g)/255.0f) blue:((b)/255.0f) alpha:(a)]

@interface ViewController ()

@property (nonatomic, weak) UIView *capturePreviewView;

@property (nonatomic, weak) UIButton *photoModeButton;
@property (nonatomic, weak) UIButton *toggleCameraButton;
@property (nonatomic, weak) UIButton *toggleFlashButton;
@property (nonatomic, weak) UIButton *videoModeButton;
@property (nonatomic, weak) UIButton *captureButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.capturePreviewView.backgroundColor = RGB(85, 85, 85, 1.0);
    [self configCaptureView];
    [self displayPreview:self.capturePreviewView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)configCaptureView {
    [self.toggleFlashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.capturePreviewView.mas_top).offset(16);
        make.left.mas_equalTo(self.capturePreviewView.mas_left).offset(315);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.toggleCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toggleFlashButton.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.toggleFlashButton.mas_centerX);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.photoModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.capturePreviewView.mas_top).offset(563);
        make.left.mas_equalTo(self.capturePreviewView.mas_left).offset(16);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.videoModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoModeButton.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.photoModeButton.mas_centerX);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.captureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.capturePreviewView.mas_top).offset(596);
        make.centerX.mas_equalTo(self.capturePreviewView.mas_centerX);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(55);
    }];
}

- (UIView *)capturePreviewView {
    if(!_capturePreviewView) {
        UIView *capturePreviewView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _capturePreviewView = capturePreviewView;
        [self.view addSubview:capturePreviewView];
    }
    
    return _capturePreviewView;
}

- (UIButton *)toggleFlashButton {
    if(!_toggleFlashButton) {
        UIButton *toggleFlashButton = [self setButton:@"Flash Off Icon"];
        _toggleFlashButton = toggleFlashButton;
        [self.capturePreviewView addSubview:toggleFlashButton];
    }
    
    return _toggleFlashButton;
}

- (UIButton *)toggleCameraButton {
    if(!_toggleCameraButton) {
        UIButton *toggleCameraButton = [self setButton:@"Rear Camera Icon"];
        _toggleCameraButton = toggleCameraButton;
        [self.capturePreviewView addSubview:toggleCameraButton];
    }
    
    return _toggleCameraButton;
}

- (UIButton *)photoModeButton {
    if(!_photoModeButton) {
        UIButton *photoModeButton = [self setButton:@"Photo Camera Icon"];
        _photoModeButton = photoModeButton;
        [self.capturePreviewView addSubview:photoModeButton];
    }
    
    return _photoModeButton;
}

- (UIButton *)videoModeButton {
    if(!_videoModeButton) {
        UIButton *videoModeButton = [self setButton:@"Video Camera Icon"];
        _videoModeButton = videoModeButton;
        [self.capturePreviewView addSubview:videoModeButton];
    }
    
    return _videoModeButton;
}

- (UIButton *)captureButton {
    if(!_captureButton) {
        UIButton *captureButton = [UIButton buttonWithType:UIButtonTypeSystem];
        captureButton.backgroundColor = [UIColor whiteColor];
        _captureButton = captureButton;
        captureButton.layer.borderColor = [UIColor blackColor].CGColor;
        captureButton.layer.borderWidth = 2;
        captureButton.layer.cornerRadius =  55 / 2;
        captureButton.clipsToBounds = YES;
        [self.capturePreviewView addSubview:captureButton];
    }
    
    return _captureButton;
}

- (UIButton *)setButton:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    button.tintColor = [UIColor whiteColor];
    
    return button;
}

- (void)displayPreview:(UIView *)view {
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;

    [previewLayer setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view.layer insertSublayer:previewLayer atIndex:0];
    
    [session startRunning];
}



@end
