//
//  CameraObject.h
//  FPAVFoundation
//
//  Created by polycom on 2017/7/12.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, CameraPosition) {
    CameraPositionFront,
    CameraPositionRear
};

typedef void(^photoCaptureCompletionBlock)(NSError *error, UIImage *image);

@interface CameraObject : NSObject

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *frontCamera;
@property (nonatomic, strong) AVCaptureDeviceInput *frontCameraInput;
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;
@property (nonatomic, strong) AVCaptureDevice *rearCamera;
@property (nonatomic, strong) AVCaptureDeviceInput *rearCameraInput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, assign) AVCaptureFlashMode flashMode;
@property (nonatomic, copy) photoCaptureCompletionBlock actionBlock;

- (void)configureCaptureDevices;
- (void)configureDeviceInputs;
- (void)configurePhotoOutput;
- (void)displayPreview:(UIView *)view;
- (void)switchCameras;
- (void)switchToRearCamera;
- (void)captureImage;

@end
