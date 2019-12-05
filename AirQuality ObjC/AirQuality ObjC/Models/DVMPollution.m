//
//  DVMPollution.m
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "DVMPollution.h"

@implementation DVMPollution

- (instancetype)initWithInt:(NSInteger)aqi
{
    self = [super init];
    if (self)
    {
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation DVMPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    
    return [self initWithInt:aqi];
}

@end
