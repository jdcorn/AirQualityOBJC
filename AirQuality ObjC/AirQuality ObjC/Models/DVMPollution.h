//
//  DVMPollution.h
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMPollution : NSObject

/// Add the appropriate properties (we onlhy care about AQI)
@property (nonatomic, readonly) NSInteger airQualityIndex;

/// Add the convenience initializer
- (instancetype)initWithInt:(NSInteger) aqi;

@end

/// Add the convenience initializer for the dictionary in an extension labeled "JSONConvertable"
@interface DVMPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
