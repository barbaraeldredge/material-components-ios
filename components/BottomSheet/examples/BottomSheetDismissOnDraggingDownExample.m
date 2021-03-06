// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <UIKit/UIKit.h>

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialAppBar.h"
#import "MaterialBottomSheet+ShapeThemer.h"
#import "MaterialBottomSheet.h"
#import "supplemental/BottomSheetDummyCollectionViewController.h"
#import "supplemental/BottomSheetSupplemental.h"

/**
 In this example you should not be able to drag to dismiss the bottom sheet. For a more
 comprehensive example see BottomSheetTypicalUseExample.m.
*/
@interface BottomSheetDismissOnDraggingDownExample () <MDCBottomSheetControllerDelegate>
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@end

@implementation BottomSheetDismissOnDraggingDownExample

- (instancetype)init {
  self = [super init];
  if (self) {
    _shapeScheme = [[MDCShapeScheme alloc] init];
  }
  return self;
}

- (void)presentBottomSheet {
  BottomSheetDummyCollectionViewController *viewController =
      [[BottomSheetDummyCollectionViewController alloc] initWithNumItems:102];
  viewController.title = @"Bottom sheet example";

  MDCAppBarContainerViewController *container =
      [[MDCAppBarContainerViewController alloc] initWithContentViewController:viewController];
  container.preferredContentSize = CGSizeMake(500, 200);
  container.appBarViewController.headerView.trackingScrollView = viewController.collectionView;
  container.topLayoutGuideAdjustmentEnabled = YES;

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:container.appBarViewController];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:container.appBarViewController];

  MDCBottomSheetController *bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:container];
  [MDCBottomSheetControllerShapeThemer applyShapeScheme:self.shapeScheme
                                toBottomSheetController:bottomSheet];
  bottomSheet.isScrimAccessibilityElement = YES;
  bottomSheet.scrimAccessibilityLabel = @"Close";
  bottomSheet.trackingScrollView = viewController.collectionView;
  bottomSheet.delegate = self;
  // In this example you should not be able to drag to dismiss the bottom sheet. Tapping on the
  // scrim still dismisses the bottom sheet. The line below is the purpose of this example and is
  // the only delta between this example and the BottomSheetTypicalUseExample.m
  bottomSheet.dismissOnDraggingDownSheet = NO;
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

- (void)bottomSheetControllerDidChangeYOffset:(MDCBottomSheetController *)controller
                                      yOffset:(CGFloat)yOffset {
  NSLog(@"bottom sheet Y offset changed: %f", yOffset);
}

- (void)bottomSheetControllerStateChanged:(MDCBottomSheetController *)controller
                                    state:(MDCSheetState)state {
  NSLog(@"bottom sheet state changed to: %lu", (unsigned long)state);
}

@end
