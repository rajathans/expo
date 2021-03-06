/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI33_0_0RCTInterpolationAnimatedNode.h"

#import "ABI33_0_0RCTAnimationUtils.h"

@implementation ABI33_0_0RCTInterpolationAnimatedNode
{
  __weak ABI33_0_0RCTValueAnimatedNode *_parentNode;
  NSArray<NSNumber *> *_inputRange;
  NSArray<NSNumber *> *_outputRange;
  NSString *_extrapolateLeft;
  NSString *_extrapolateRight;
}

- (instancetype)initWithTag:(NSNumber *)tag
                     config:(NSDictionary<NSString *, id> *)config
{
  if ((self = [super initWithTag:tag config:config])) {
    _inputRange = [config[@"inputRange"] copy];
    NSMutableArray *outputRange = [NSMutableArray array];
    for (id value in config[@"outputRange"]) {
      if ([value isKindOfClass:[NSNumber class]]) {
        [outputRange addObject:value];
      }
    }
    _outputRange = [outputRange copy];
    _extrapolateLeft = config[@"extrapolateLeft"];
    _extrapolateRight = config[@"extrapolateRight"];
  }
  return self;
}

- (void)onAttachedToNode:(ABI33_0_0RCTAnimatedNode *)parent
{
  [super onAttachedToNode:parent];
  if ([parent isKindOfClass:[ABI33_0_0RCTValueAnimatedNode class]]) {
    _parentNode = (ABI33_0_0RCTValueAnimatedNode *)parent;
  }
}

- (void)onDetachedFromNode:(ABI33_0_0RCTAnimatedNode *)parent
{
  [super onDetachedFromNode:parent];
  if (_parentNode == parent) {
    _parentNode = nil;
  }
}

- (void)performUpdate
{
  [super performUpdate];
  if (!_parentNode) {
    return;
  }

  CGFloat inputValue = _parentNode.value;

  self.value = ABI33_0_0RCTInterpolateValueInRange(inputValue,
                                          _inputRange,
                                          _outputRange,
                                          _extrapolateLeft,
                                          _extrapolateRight);
}

@end
