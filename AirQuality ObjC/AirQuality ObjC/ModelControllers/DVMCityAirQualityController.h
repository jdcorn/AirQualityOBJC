//
//  DVMCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVMCityAirQuality;

NS_ASSUME_NONNULL_BEGIN

/// On this .h file we are declaring the varius network call methods we'll be using.
@interface DVMCityAirQualityController : NSObject

/// This method will take no parameters and complete with an array of strings.
+ (void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

/// This method will take in a string parameter for the country and complete with an array of strings.
+ (void)fetchSupportedStatesInCountry:(NSString *)country
                           completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

/// This method will take in string parameters for the country and state and complete with an array of strings.
+ (void)fetchSupportedCitiesInState:(NSString *)state
                            country:(NSString *)country
                         completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

/// This method will take in string parameters for country, state, city, and complete with a CityAirQuality object.
+ (void)fetchDataForCity:(NSString *)city
                   state:(NSString *)state
                 country:(NSString *)country
              completion:(void (^) (DVMCityAirQuality *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
