//
//  LTAlertView.m
//  LTAlertView
//
//  Created by yelon on 16/10/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "LTAlertView.h"

@interface LTAlertView (){

    BOOL isShowing;
}

@property(nonatomic,strong) NSMutableArray<UIButton *> *buttonsArray;
@property(nonatomic,strong) NSMutableArray<UITextField *> *textFieldsArray;

@property(nonatomic,strong) UIView *contentView;


@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *messageLabel;//消息

@property(nonatomic,strong) UIView *textFieldContentView;//文本框
@property(nonatomic,strong) UIView *buttonContentView;//按钮
@end

@implementation LTAlertView

#pragma mark init
+ (_Nonnull id)LT_showAlertViewWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                        clickButtonBlock:(void(^)(LTAlertView * _Nonnull alertView,NSString *_Nonnull buttonTitle))clickButtonBlock
                            buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    
    LTAlertView *alertView = [[LTAlertView alloc]init];
    
    alertView.title = title;
    alertView.message = message;
    alertView.ClickButtonBlock = clickButtonBlock;
    
    va_list params; //定义一个指向个数可变的参数列表指针;
    va_start(params,buttonTitles);//va_start 得到第一个可变参数地址,
    NSString *arg;
    if (buttonTitles) {

        id prev = buttonTitles;
        [alertView lt_addButtonWithTitle:prev];
        //va_arg 指向下一个参数地址
        while( (arg = va_arg(params,id)) ){
            
            if (arg && [arg isKindOfClass:[NSString class]]){
                
                [alertView lt_addButtonWithTitle:arg];
            }
        }
        //置空
        va_end(params);
    }
    [alertView lt_show];
    return alertView;
}
+ (_Nonnull id)LT_alertViewWithTitle:(nullable NSString *)title
                             message:(nullable NSString *)message{
    LTAlertView *alertView = [[LTAlertView alloc]init];
    
    alertView.title = title;
    alertView.message = message;
    
    return alertView;
}

-(instancetype)init{

    if (self = [super init]) {
        
        isShowing = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self setLayoutForContentView];
    }
    return self;
}
#pragma mark setter & getter ==private
-(UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5.0;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
//标题
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 3;
    }
    return _titleLabel;
}
//消息
-(UILabel *)messageLabel{
    
    if (!_messageLabel) {
        
        _messageLabel = [UILabel new];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
-(UIView *)textFieldContentView{
    
    if (!_textFieldContentView) {
        
        _textFieldContentView = [[UIView alloc]init];
        _textFieldContentView.backgroundColor = [UIColor clearColor];
    }
    return _textFieldContentView;
}
//按钮视图
-(UIView *)buttonContentView{

    if (!_buttonContentView) {
        
        _buttonContentView = [[UIView alloc]init];
        _buttonContentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _buttonContentView;
}

//按钮
-(NSMutableArray<UIButton *> *)buttonsArray{

    if (!_buttonsArray) {
        
        _buttonsArray = [[NSMutableArray alloc]init];
    }
    return _buttonsArray;
}
//文本框
-(NSMutableArray<UITextField *> *)textFieldsArray{

    if (!_textFieldsArray) {
        
        _textFieldsArray = [[NSMutableArray alloc]init];
    }
    return _textFieldsArray;
}

#pragma mark setter & getter == public
//设置标题
-(void)setTitle:(NSString *)title{

    self.titleLabel.text = title;
}
-(NSString *)title{

    return self.titleLabel.text;
}
-(void)setAttributedTitle:(NSAttributedString *)attributedTitle{

    self.titleLabel.attributedText = attributedTitle;
}
-(NSAttributedString *)attributedTitle{

    return self.titleLabel.attributedText;
}
-(void)setTitleColor:(UIColor *)titleColor{

    self.titleLabel.textColor = titleColor;
}
-(UIColor *)titleColor{

    return self.titleLabel.textColor;
}
-(void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    
    self.titleLabel.textAlignment = titleAlignment;
}
-(NSTextAlignment)titleAlignment{

    return self.titleLabel.textAlignment;
}
//设置消息
-(void)setMessage:(NSString *)message{

    self.messageLabel.text = message;
}
-(NSString *)message{

    return self.messageLabel.text;
}
-(void)setAttributedMessage:(NSAttributedString *)attributedMessage{
    
    self.messageLabel.attributedText = attributedMessage;
}
-(NSAttributedString *)attributedMessage{
    
    return self.messageLabel.attributedText;
}
-(void)setMessageColor:(UIColor *)messageColor{
    
    self.messageLabel.textColor = messageColor;
}
-(UIColor *)messageColor{
    
    return self.messageLabel.textColor;
}
-(void)setMessageAlignment:(NSTextAlignment)messageAlignment{

    self.messageLabel.textAlignment = messageAlignment;
}
-(NSTextAlignment)messageAlignment{

    return self.messageLabel.textAlignment;
}
//获取文本框数组
-(NSArray<UITextField *> *)textFields{

    return [NSArray arrayWithArray:self.textFieldsArray];
}
#pragma mark private Method
- (void)setLayoutForContentView{

    //scrollView
    UIView *superView = self;
    
    //contentView
    UIView *contentView = self.contentView;
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:contentView];
    
    [superView addConstraint:[self constraintForView:contentView
                                              toView:superView
                                       withAttribute:NSLayoutAttributeCenterX
                                            constant:0.0]];
    
    [superView addConstraint:[self constraintForView:contentView
                                              toView:superView
                                       withAttribute:NSLayoutAttributeCenterY
                                            constant:0.0]];
    
    [superView addConstraint:[self constraintForView:contentView
                                           attribute:NSLayoutAttributeWidth
                                              toView:superView
                                       withAttribute:NSLayoutAttributeWidth
                                            constant:-80.0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:40.0]];

    //---------------------content begin
    //titleLabel
    UILabel *titleLabel = self.titleLabel;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    
    [contentView addConstraint:[self constraintForView:titleLabel
                                         toView:contentView
                                  withAttribute:NSLayoutAttributeTop
                                       constant:10.0]];

    [contentView addConstraint:[self constraintForView:titleLabel
                                         toView:contentView
                                  withAttribute:NSLayoutAttributeLeft
                                       constant:20.0]];
    
    [contentView addConstraint:[self constraintForView:titleLabel
                                         toView:contentView
                                  withAttribute:NSLayoutAttributeRight
                                       constant:-20.0]];
    //messageLabel
    UILabel *messageLabel = self.messageLabel;
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:messageLabel];
    
    
    [contentView addConstraint:[self constraintForView:messageLabel
                                             attribute:NSLayoutAttributeTop
                                                toView:titleLabel
                                         withAttribute:NSLayoutAttributeBottom
                                              constant:5.0]];
    [contentView addConstraint:[self constraintForView:messageLabel
                                                toView:titleLabel
                                         withAttribute:NSLayoutAttributeLeft
                                              constant:0.0]];
    [contentView addConstraint:[self constraintForView:messageLabel
                                                toView:titleLabel
                                         withAttribute:NSLayoutAttributeRight
                                              constant:0.0]];
    
    //textFieldContentView
    UIView *textFieldContentView = self.textFieldContentView;
    textFieldContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:textFieldContentView];
    
    [contentView addConstraint:[self constraintForView:textFieldContentView
                                             attribute:NSLayoutAttributeTop
                                                toView:messageLabel
                                         withAttribute:NSLayoutAttributeBottom
                                              constant:10.0]];
    [contentView addConstraint:[self constraintForView:textFieldContentView
                                                toView:titleLabel
                                         withAttribute:NSLayoutAttributeLeft
                                              constant:0.0]];
    [contentView addConstraint:[self constraintForView:textFieldContentView
                                                toView:titleLabel
                                         withAttribute:NSLayoutAttributeRight
                                              constant:0.0]];
    
    //buttonContentView
    UIView *buttonContentView = self.buttonContentView;
    buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:buttonContentView];
    
    [contentView addConstraint:[self constraintForView:buttonContentView
                                             attribute:NSLayoutAttributeTop
                                                toView:textFieldContentView
                                         withAttribute:NSLayoutAttributeBottom
                                              constant:10.0]];
    [contentView addConstraint:[self constraintForView:buttonContentView
                                                toView:contentView
                                         withAttribute:NSLayoutAttributeLeft
                                              constant:0.0]];
    [contentView addConstraint:[self constraintForView:buttonContentView
                                                toView:contentView
                                         withAttribute:NSLayoutAttributeRight
                                              constant:0.0]];
    [contentView addConstraint:[self constraintForView:buttonContentView
                                                toView:contentView
                                         withAttribute:NSLayoutAttributeBottom
                                              constant:0.0]];
}

- (void)resetAllSubContentLayout{

    [self resetButtonContentLayout];
}

- (void)resetButtonContentLayout{

    UIView *buttonContentView = self.buttonContentView;
    
    [buttonContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [buttonContentView removeConstraints:[buttonContentView constraints]];
    
    NSUInteger btnCount = [self.buttonsArray count];
    
    if (btnCount > 0) {

        UIButton *btn0 = [self.buttonsArray firstObject];
        [buttonContentView addSubview:btn0];
        
        [buttonContentView addConstraint:[self constraintForView:btn0
                                                          toView:buttonContentView
                                                   withAttribute:NSLayoutAttributeTop
                                                        constant:0.5]];
        
        [buttonContentView addConstraint:[self constraintForView:btn0
                                                          toView:buttonContentView
                                                   withAttribute:NSLayoutAttributeLeft
                                                        constant:0.0]];
        
        [buttonContentView addConstraint:[self constraintForView:btn0
                                                   withAttribute:NSLayoutAttributeHeight
                                                        constant:40.0]];
        
        if (btnCount == 2) {
            
            [buttonContentView addConstraint:[self constraintForView:btn0
                                                              toView:buttonContentView
                                                       withAttribute:NSLayoutAttributeBottom
                                                            constant:0.0]];
            
            UIButton *btn1 = [self.buttonsArray lastObject];
            [buttonContentView addSubview:btn1];
            
            [buttonContentView addConstraint:[self constraintForView:btn1
                                                              toView:btn0
                                                       withAttribute:NSLayoutAttributeTop
                                                            constant:0.0]];
            [buttonContentView addConstraint:[self constraintForView:btn1
                                                              toView:btn0
                                                       withAttribute:NSLayoutAttributeBottom
                                                            constant:0.0]];
            
            [buttonContentView addConstraint:[self constraintForView:btn1
                                                              toView:btn0
                                                       withAttribute:NSLayoutAttributeWidth
                                                            constant:0.0]];
            
            [buttonContentView addConstraint:[self constraintForView:btn1
                                                           attribute:NSLayoutAttributeLeft
                                                              toView:btn0
                                                       withAttribute:NSLayoutAttributeRight
                                                            constant:0.5]];
            
            [buttonContentView addConstraint:[self constraintForView:btn1
                                                              toView:buttonContentView
                                                       withAttribute:NSLayoutAttributeRight
                                                            constant:0.0]];
        }
        else{
        
            [buttonContentView addConstraint:[self constraintForView:btn0
                                                              toView:buttonContentView
                                                       withAttribute:NSLayoutAttributeRight
                                                            constant:0.0]];
            
            if (btnCount == 1) {
                
                [buttonContentView addConstraint:[self constraintForView:btn0
                                                                  toView:buttonContentView
                                                           withAttribute:NSLayoutAttributeBottom constant:0.0]];
            }
            else{
            
                for (NSUInteger index = 1;index< btnCount;index++) {
                    
                    UIButton *btnPre = self.buttonsArray[index-1];
                    UIButton *btnCurrent = self.buttonsArray[index];
                    [buttonContentView addSubview:btnCurrent];
                    
                    [buttonContentView addConstraint:[self constraintForView:btnCurrent
                                                                   attribute:NSLayoutAttributeTop
                                                                      toView:btnPre
                                                               withAttribute:NSLayoutAttributeBottom
                                                                    constant:0.5]];
                    
                    [buttonContentView addConstraint:[self constraintForView:btnCurrent
                                                                      toView:btnPre
                                                               withAttribute:NSLayoutAttributeLeft
                                                                    constant:0.0]];
                    
                    [buttonContentView addConstraint:[self constraintForView:btnCurrent
                                                                      toView:btnPre
                                                               withAttribute:NSLayoutAttributeRight
                                                                    constant:0.0]];
                    [buttonContentView addConstraint:[self constraintForView:btnCurrent
                                                                      toView:btnPre
                                                               withAttribute:NSLayoutAttributeHeight
                                                                    constant:0.0]];
                }
                
                UIButton *btnLast = [self.buttonsArray lastObject];

                [buttonContentView addConstraint:[self constraintForView:btnLast
                                                                  toView:buttonContentView
                                                           withAttribute:NSLayoutAttributeBottom
                                                                constant:0.0]];
            }
        }
    }
    else{
    
        buttonContentView.backgroundColor = [UIColor grayColor];
    }
}

- (UIButton *)newButtonWithTitle:(NSString *)title{

    UIButton *btn = [[UIButton alloc] init];
    
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:35.0/255.0 green:137.0/255.0 blue:250.0/255.0 alpha:1.0]
              forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor]
              forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[LTAlertView lt_imageWithColor:self.contentView.backgroundColor]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[LTAlertView lt_imageWithColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]]
                   forState:UIControlStateHighlighted];
    
    [btn addTarget:self
            action:@selector(buttonClickAction:)
  forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return btn;
}

- (void)buttonClickAction:(UIButton *)btn{

    NSString *buttonTitle = [btn titleForState:UIControlStateNormal];
    
    [self lt_hide];
    
    if ([self.delegate respondsToSelector:@selector(ltAlertView:clickButtonTitle:)]) {
        
        [self.delegate ltAlertView:self
                  clickButtonTitle:buttonTitle];
    }
    if (self.ClickButtonBlock) {
        
        self.ClickButtonBlock(self,buttonTitle);
    }
}

#pragma mark public Method
- (NSInteger)lt_addButtonWithTitle:(NSString *)title{
    
    if (!title||![title isKindOfClass:[NSString class]]) {
        
        return -1;
    }
    
    title = [NSString stringWithFormat:@"%@",title];
    
    [self.buttonsArray addObject:[self newButtonWithTitle:title]];
    
    return [self.buttonsArray count]-1;
}

-(void)lt_addButtonWithConfigurationHandler:(void (^)(UIButton * _Nonnull))configurationHandler{

    UIButton *btn = [self newButtonWithTitle:@""];
    [self.buttonsArray addObject:btn];
    if (configurationHandler) {
        configurationHandler(btn);
    }
}

-(void)lt_dismissWithClickedButtonIndex:(NSInteger)buttonIndex{

    if (buttonIndex<0||buttonIndex>[self.buttonsArray count]-1) {
        
        [self lt_hide];
        return;
    }
    
    [self buttonClickAction:self.buttonsArray[buttonIndex]];
}

- (void)lt_show{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isShowing) {
            return ;
        }
        
        isShowing = YES;
        
        [self resetAllSubContentLayout];
        
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        self.frame = [window bounds];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [window addSubview:self];
        
        [self showAnimation];
    });
    
}

- (void)lt_hide{
    
    if (self.neverHide) {
        
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!isShowing) {
            
            return ;
        }
        isShowing = NO;
        [self hideAnimation:^{
            
            [self removeFromSuperview];
        }];
    });
}

- (void)showAnimation{
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.7],
                              [NSNumber numberWithFloat:1.15],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    
    [self.contentView.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    [UIView animateWithDuration:0.15 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
}

- (void)hideAnimation:(void(^)())hideCompleteBlock{
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.2;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:1.05],
                              [NSNumber numberWithFloat:0.5],
                              nil];
    
    [self.contentView.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    
    [UIView animateWithDuration:0.15
                     animations:^{
                         
                         self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         
                         hideCompleteBlock();
                     }];
}

#pragma mark layout method
//等价父视图
- (NSLayoutConstraint *)constraintForView:(UIView *)view
                            withAttribute:(NSLayoutAttribute)attribute
                                 constant:(CGFloat)constant{
    
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.0
                                         constant:constant];
}

- (NSLayoutConstraint *)constraintForView:(UIView *)forView
                                   toView:(UIView *)toView
                            withAttribute:(NSLayoutAttribute)attribute
                                 constant:(CGFloat)constant{
    
    return [NSLayoutConstraint constraintWithItem:forView
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toView
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:constant];
}

- (NSLayoutConstraint *)constraintForView:(UIView *)forView
                                attribute:(NSLayoutAttribute)attribute
                                   toView:(UIView *)toView
                            withAttribute:(NSLayoutAttribute)withAttribute
                                 constant:(CGFloat)constant{
    
    return [NSLayoutConstraint constraintWithItem:forView
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toView
                                        attribute:withAttribute
                                       multiplier:1.0
                                         constant:constant];
}

- (NSArray *)constraintForView:(UIView *)forView
                        toView:(UIView *)toView
                    edgeInsets:(UIEdgeInsets)insets{
    
    return @[[self constraintForView:forView
                              toView:(UIView *)toView
                       withAttribute:NSLayoutAttributeTop
                            constant:insets.top],
             [self constraintForView:forView
                              toView:toView
                       withAttribute:NSLayoutAttributeLeft
                            constant:insets.left],
             [self constraintForView:forView
                              toView:toView
                       withAttribute:NSLayoutAttributeBottom
                            constant:insets.bottom],
             [self constraintForView:forView
                              toView:toView
                       withAttribute:NSLayoutAttributeRight
                            constant:insets.right]];
}
#pragma mark other 
+ (UIImage*) lt_imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
