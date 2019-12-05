//
//  DVMWeather.h
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMWeather : NSObject

/// Review the endpoint for the weather level of the JSON object and add the appropriate properties
@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;

/// Add the designated initializer declaration for this Model object
- (instancetype)initWithWeatherInfo:(NSInteger)temperature
                           humidity:(NSInteger)humidity
                          windSpeed:(NSInteger)windspeed;

@end

/// Add the convenience initializer for the dictionary in an extension labeled "JSONConvertable"
@interface DVMWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
