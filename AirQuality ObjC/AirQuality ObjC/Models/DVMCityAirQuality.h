//
//  DVMCityAirQuality.h
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVMWeather;
@class DVMPollution;

NS_ASSUME_NONNULL_BEGIN

@interface DVMCityAirQuality : NSObject

/// Create model properties with JSON data in mind.
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;

/// The endpoint has two more levels of dictionaries, for now add them as properties.
@property (nonatomic, copy, readonly) DVMWeather *weather;
@property (nonatomic, copy, readonly) DVMPollution *pollution;

/// Add the designated initializer declaration for this model object.
- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(DVMWeather *)weather
                   pollution:(DVMPollution *)pollution;

@end

/// Add the convenience initializer for the dictionary in an extension labeled "JSONConvertable"
@interface DVMCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
