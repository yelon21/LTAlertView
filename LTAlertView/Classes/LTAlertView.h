//
//  LTAlertView.h
//  LTAlertView
//
//  Created by yelon on 16/10/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTAlertView;
@protocol LTAlertViewDelegate <NSObject>

- (void)ltAlertView:( LTAlertView * _Nonnull )alertView
   clickButtonTitle:(NSString * _Nonnull)buttonTitle;

@end

@interface LTAlertView : UIView

//文本框
@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;
//标题
@property (nullable, nonatomic, assign) NSString *title;
@property (nullable, nonatomic, assign) NSAttributedString  *attributedTitle;
@property (nullable, nonatomic, assign) UIColor *titleColor;
@property (nonatomic, assign) NSTextAlignment titleAlignment;
//消息
@property (nullable, nonatomic, assign) NSString *message;
@property (nullable, nonatomic, assign) NSAttributedString  *attributedMessage;
@property (nullable, nonatomic, assign) UIColor *messageColor;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

@property (nonatomic, assign) BOOL neverHide;
@property (nonatomic, assign,readonly) BOOL isShowing;

@property (nullable, nonatomic, assign) id<LTAlertViewDelegate> delegate;
@property (nullable, nonatomic, copy) void(^ClickButtonBlock)(LTAlertView * _Nonnull alertView,NSString *_Nonnull buttonTitle);

+ (_Nonnull id)LT_showAlertViewWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                        clickButtonBlock:(void(^)(LTAlertView * _Nonnull alertView,NSString *_Nonnull buttonTitle))clickButtonBlock
                            buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (_Nonnull id)LT_alertViewWithTitle:(nullable NSString *)title
                             message:(nullable NSString *)message;

-(_Nonnull id)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

////添加按钮  -1 表示失败
- (NSInteger)lt_addButtonWithTitle:(NSString  * _Nonnull )title;

//添加Button
- (void)lt_addButtonWithConfigurationHandler:(void (^ __nullable)(UIButton  * _Nonnull button))configurationHandler;

//添加TextField
//- (void)lt_addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField  * _Nonnull textField))configurationHandler;


//主动隐藏
- (void)lt_dismissWithClickedButtonIndex:(NSInteger)buttonIndex;
//展示
- (void)lt_show;
//关闭
- (void)lt_hideForce;

@end
