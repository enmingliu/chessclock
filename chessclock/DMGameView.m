//
//  DMGameView.m
//  chessclock
//
//  Created by Dan on 2015-12-18.
//
//

#import "DMGameView.h"
#import "UIColor+CTRExtensions.h"

@interface DMGameView ()

@property (weak, nonatomic) IBOutlet UIView *whiteBackground;
@property (weak, nonatomic) IBOutlet UIView *greyBackground;
@property (weak, nonatomic) IBOutlet UIView *blackBackground;
@property (weak, nonatomic) IBOutlet UILabel *startGameLabel;
@property(nonatomic, weak) IBOutlet UIButton *whiteButton;
@property(nonatomic, weak) IBOutlet UIButton *blackButton;
@property(nonatomic, weak) IBOutlet UIButton *pauseButton;
@property(nonatomic, weak) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *timesButton;
@property(weak, nonatomic) IBOutlet UISlider *whiteSlider;
@property(weak, nonatomic) IBOutlet UISlider *blackSlider;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *whiteSliderTopConstraint;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *blackSliderBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resetButtonLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pauseButtonTrailingConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelResetButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmResetButton;
@property (weak, nonatomic) IBOutlet UILabel *confirmResetLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greyBackgroundHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *winnerButton;
@property (weak, nonatomic) IBOutlet UIButton *loserButton;

@end

@implementation DMGameView

- (void)setUpSubviews
{
    // Set the colour of the background views
    [self.whiteBackground setBackgroundColor:[UIColor whiteColor]];
    [self.greyBackground setBackgroundColor:[UIColor ctr_lightGreyColor]];
    [self.blackButton setBackgroundColor:[UIColor blackColor]];

    // Rotate the white controls 180°
    self.startGameLabel.transform = CGAffineTransformMakeRotation(-M_PI);
    self.whiteButton.transform = CGAffineTransformMakeRotation(-M_PI);
    self.whiteSlider.transform = CGAffineTransformMakeRotation(-M_PI);

    // Set button colours
    [self.whiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.whiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.whiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];

    [self.blackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.blackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.blackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];

    [self.pauseButton setTitleColor:[UIColor ctr_blueColor] forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted];
    [self.pauseButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted|UIControlStateSelected];
    [self.pauseButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateDisabled];

    [self.resetButton setTitleColor:[UIColor ctr_blueColor] forState:UIControlStateNormal];
    [self.resetButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted];
    [self.resetButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted|UIControlStateSelected];
    [self.resetButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateDisabled];

    [self.timesButton setTitleColor:[UIColor ctr_blueColor] forState:UIControlStateNormal];
    [self.timesButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted];
    [self.timesButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted|UIControlStateSelected];
    [self.timesButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateDisabled];

    [self.cancelResetButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted];
    [self.confirmResetButton setTitleColor:[UIColor ctr_greyColor] forState:UIControlStateHighlighted];

    self.startGameLabel.textColor = [UIColor ctr_greyColor];

    // Set button titles
    [self.pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [self.pauseButton setTitle:@"pause" forState:UIControlStateHighlighted];
    [self.pauseButton setTitle:@"resume" forState:UIControlStateSelected];
    [self.pauseButton setTitle:@"resume" forState:UIControlStateHighlighted|UIControlStateSelected];

    [self.timesButton setTitle:@"times" forState:UIControlStateNormal];
    [self.timesButton setTitle:@"times" forState:UIControlStateHighlighted];
    [self.timesButton setTitle:@"done" forState:UIControlStateSelected];
    [self.timesButton setTitle:@"done" forState:UIControlStateHighlighted|UIControlStateSelected];

    // Configure the slider images
    UIEdgeInsets slider_insets = UIEdgeInsetsMake(0, 0, 0, 0);

    // These names are kind of counterintuitive... black track goes on white slider
    UIImage *sliderTrackBlack = [[UIImage imageNamed:@"slider-track-black"] resizableImageWithCapInsets:slider_insets];
    UIImage *sliderTrackWhite = [[UIImage imageNamed:@"slider-track-white"] resizableImageWithCapInsets:slider_insets];

    [self.whiteSlider setMinimumTrackImage:sliderTrackBlack forState:UIControlStateNormal];
    [self.whiteSlider setMaximumTrackImage:sliderTrackBlack forState:UIControlStateNormal];
    [self.whiteSlider setThumbImage:[UIImage imageNamed:@"slider-thumb-black"] forState:UIControlStateNormal];

    [self.blackSlider setMinimumTrackImage:sliderTrackWhite forState:UIControlStateNormal];
    [self.blackSlider setMaximumTrackImage:sliderTrackWhite forState:UIControlStateNormal];
    [self.blackSlider setThumbImage:[UIImage imageNamed:@"slider-thumb-white"] forState:UIControlStateNormal];

    // Hide the sliders initially
    self.whiteSliderTopConstraint.constant = -1 * self.whiteSlider.intrinsicContentSize.height;
    self.blackSliderBottomConstraint.constant = -1 * self.blackSlider.intrinsicContentSize.height;
    self.whiteSlider.alpha = 0.0f;
    self.blackSlider.alpha = 0.0f;

    // Hide some buttons too
    //    self.resetButtonLeadingConstraint.constant = -20;
    self.resetButton.alpha = 0.0f;

    //    self.pauseButtonTrailingConstraint.constant = 20;
    self.pauseButton.alpha = 0.0f;

    self.confirmResetLabel.alpha = 0.0f;
    self.cancelResetButton.alpha = 0.0f;
    self.confirmResetButton.alpha = 0.0f;

    self.whiteButton.alpha = 0.0f;
    self.blackButton.alpha = 0.0f;
    self.startGameLabel.alpha = 0.0f;
    self.timesButton.alpha = 0.0f;

    [self enableWhiteButton];
    [self disableBlackButton];

    [self updateInterfaceWithChanges:^{
        self.whiteButton.alpha = 1.0f;
        self.blackButton.alpha = 0.4f;
        self.startGameLabel.alpha = 1.0f;
        self.timesButton.alpha = 1.0f;

        [self.view layoutIfNeeded];
    }];

#pragma mark -
#pragma mark View changes


}


- (void)updateInterfaceWithChanges:(void (^)(void))changes
{
    [self updateInterfaceWithChanges:changes animatable:YES];
}

- (void)updateInterfaceWithChanges:(void (^)(void))changes
                        animatable:(BOOL)animatable
{
    [self updateInterfaceWithChanges:changes animatable:animatable completion:nil];
}

- (void)updateInterfaceWithChanges:(void (^)(void))changes
                        animatable:(BOOL)animatable
                        completion:(void (^)(BOOL))completion
{
    // Draw changes we aren't animating at all
    [self.view layoutIfNeeded];

    NSTimeInterval duration = 0.25;

    if (animatable) {
        [UIView animateWithDuration:duration animations:changes completion:completion];
    } else {
        [UIView transitionWithView:self.view
                          duration:duration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:changes
                        completion:completion];
    }
}


- (void)setTitleOfButton:(UIButton *)button toTime:(DMClockTime)time
{
    NSString *displayTime = [NSString stringWithFormat:@"%d:%02d", time.minutes, time.seconds];

    [button setTitle:displayTime forState:UIControlStateNormal];
}

- (void)setButtonTitlesToTimes
{
    [self setTitleOfButton:self.whiteButton toTime:[self.white remainingTime]];
    [self setTitleOfButton:self.blackButton toTime:[self.black remainingTime]];
}

- (void)setButtonTitlesToWinLose
{
    [self.winnerButton setTitle:@"win" forState:UIControlStateNormal];
    [self.loserButton setTitle:@"lose" forState:UIControlStateNormal];

    [self.winnerButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.winnerButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [self.loserButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.loserButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}

#pragma mark -
#pragma mark View change macros

- (void)enableWhiteButton
{
    self.whiteButton.enabled = YES;
    self.whiteButton.alpha = 1.0f;
}

- (void)disableWhiteButton
{
    self.whiteButton.enabled = NO;
    self.whiteButton.alpha = 0.2f;
}

- (void)enableBlackButton
{
    self.blackButton.enabled = YES;
    self.blackButton.alpha = 1.0f;
}

- (void)disableBlackButton
{
    self.blackButton.enabled = NO;
    self.blackButton.alpha = 0.4f;
}

- (void)showSliders
{
    self.whiteSlider.alpha = 1.0f;
    self.blackSlider.alpha = 1.0f;
    self.whiteSliderTopConstraint.constant = 20;
    self.blackSliderBottomConstraint.constant = 20;
}

- (void)hideSliders
{
    self.whiteSlider.alpha = 0.0f;
    self.blackSlider.alpha = 0.0f;
    self.whiteSliderTopConstraint.constant = -1 * self.whiteSlider.intrinsicContentSize.height;
    self.blackSliderBottomConstraint.constant = -1 * self.blackSlider.intrinsicContentSize.height;
}

- (void)enablePlayerButtonInteraction
{
    self.whiteButton.userInteractionEnabled = YES;
    self.blackButton.userInteractionEnabled = YES;
}

- (void)disablePlayerButtonInteraction
{
    self.whiteButton.userInteractionEnabled = NO;
    self.blackButton.userInteractionEnabled = NO;
}

-(void)showResetButton
{
    //    self.resetButtonLeadingConstraint.constant = 0;
    self.resetButton.alpha = 1.0f;
}

- (void)hideResetButton
{
    //    self.resetButtonLeadingConstraint.constant = -20;
    self.resetButton.alpha = 0.0f;
}

-(void)showTimesButton
{
    self.timesButton.alpha = 1.0f;
}

- (void)hideTimesButton
{
    self.timesButton.alpha = 0.0f;
}

- (void)showPauseButton
{
    //    self.pauseButtonTrailingConstraint.constant = 0;
    self.pauseButton.alpha = 1.0f;
}

- (void)hidePauseButton
{
    //    self.pauseButtonTrailingConstraint.constant = 20;
    self.pauseButton.alpha = 0.0f;
}

- (void)showStartGameLabel
{
    self.startGameLabel.alpha = 1.0f;
}

- (void)hideStartGameLabel
{
    self.startGameLabel.alpha = 0.0f;
}

- (void)resetStartGameLabelContent
{
    self.startGameLabel.text = @"tap here to start the game";
    [self.startGameLabel invalidateIntrinsicContentSize];
    [self.startGameLabel layoutIfNeeded];
}

- (void)replaceStartGameLabelContent
{
    self.startGameLabel.text = @"tap on your clock to end your turn";
    [self.startGameLabel invalidateIntrinsicContentSize];
    [self.startGameLabel layoutIfNeeded];
}

- (void)showConfirmResetArea
{
    self.greyBackgroundHeightConstraint.constant = 164;
    self.confirmResetLabel.alpha = 1.0f;
    self.cancelResetButton.alpha = 1.0f;
    self.confirmResetButton.alpha = 1.0f;
}

- (void)hideConfirmResetArea
{
    self.greyBackgroundHeightConstraint.constant = 72;
    self.confirmResetLabel.alpha = 0.0f;
    self.cancelResetButton.alpha = 0.0f;
    self.confirmResetButton.alpha = 0.0f;
}

- (void)resetPlayerButtonColors
{
    [self.whiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.whiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.blackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.blackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (void)selectPauseButton
{
    self.pauseButton.selected = YES;

    [self.pauseButton invalidateIntrinsicContentSize];
}

- (void)deselectPauseButton
{
    self.pauseButton.selected = NO;

    [self.pauseButton invalidateIntrinsicContentSize];
}

- (void)selectTimesButton
{
    self.timesButton.selected = YES;

    [self.timesButton invalidateIntrinsicContentSize];
}

- (void)deselectTimesButton
{
    self.timesButton.selected = NO;

    [self.timesButton invalidateIntrinsicContentSize];
}



@end