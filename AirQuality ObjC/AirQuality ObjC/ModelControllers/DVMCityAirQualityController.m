//
//  DVMCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "DVMCityAirQualityController.h"
#import "DVMCityAirQuality.h"

/// To make life easier when implementing our methods, we will use string constants to store the frequently used string values for the API calls.
/// Above the class declaration, we'll add our string constants
static NSString *const baseURLString = @"https://api.airvisual.com/";
static NSString *const versionComponent = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apiKey = @"5f3cd124-bdc5-4762-bb71-b81df5566cec";

@implementation DVMCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    /// Start with defining a url from the baseURLString
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    /// Append the versionComponent string as a pathComponent
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    
    /// Append the countryComponent string as a pathComponent
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    /// Add your apiKey as a queryItem with the key of "key"
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    /// Here is where we take in the key:@"key" and the apiKey's value...
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    /// ...And pass it into the URL
    [queryItems addObject:apiKeyQuery];
    
    /// This appends the key to the url
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    /// Our final URL
    NSURL *finalURL = [urlComponents URL];
    
    /// With your finalURL consturcted, perform a shared URLSession dataTaskWithURL and completion
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        /// Handle the error
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        /// Print the response
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        /// Unwrap your data
        if (data)
        {
            /// Create a topLevel Dictionary from serializing the JSON from the unwrapped data
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
            
            /// Step into your data dictionary from the topLevel dictionary
            NSDictionary *dataDict = topLevel[@"data"];
            
            /// Creating our placeholder array for our countries
            NSMutableArray *countries = [NSMutableArray new];
            
            /// Loop through the data dictionary and create an array of strings from the names of the countries found
           for (NSDictionary *countryDict in dataDict)
           {
               NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
               [countries addObject:country];
           }
            /// Complete with the array of strings
            completion(countries);
        }
        
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    /// Start with defining a url from the baseURLString
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    /// Append the versionComponent string as a pathComponent
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    
    /// Append the countryComponent string as a pathComponent
    NSURL *statesURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    /// Add your apiKey as a queryItem with the key of "key"
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    /// Add a queryItem for the country, use the string value for the country parameter as the value and "country" as the key
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    
    /// Here is where we take in the key:@"key" and the apiKey's value...
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    /// ...And pass it into the URL, along with countryQuery
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    /// This appends the key to the url
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    /// Our final URL
    NSURL *finalURL = [urlComponents URL];
    
    /// With your finalURL consturcted, perform a shared URLSession dataTaskWithURL and completion
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        /// Handle the error
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        /// Print the response
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        /// Unwrap your data
        if (data)
        {
            /// Create a topLevel Dictionary from serializing the JSON from the unwrapped data
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
            
            /// Step into your data dictionary from the topLevel dictionary
            NSDictionary *dataDict = topLevel[@"data"];
            
            /// Creating our placeholder array for our states
            NSMutableArray *states = [NSMutableArray new];
            
            /// Loop through the data dictionary and create an array of strings from the names of the states found
           for (NSDictionary *stateDict in dataDict)
           {
               NSString *state = [[NSString alloc] initWithString:stateDict[@"state"]];
               [states addObject:state];
           }
            /// Complete with the array of strings
            completion(states);
        }
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    /// Start with defining a url from the baseURLString
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    /// Append the versionComponent string as a pathComponent
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    
    /// Append the countryComponent string as a pathComponent
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    /// Add your apiKey as a queryItem with the key of "key"
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    /// Add a qureryItem for the state, use the string value for the state parameter as the value and "state" as the key
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    
    /// Add a queryItem for the country, use the string value for the country parameter as the value and "country" as the key
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    
    /// Here is where we take in the key:@"key" and the apiKey's value...
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    /// ...And pass it into the URL, along with countryQuery and stateQuery
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    /// This appends the key to the url
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    /// Our final URL
    NSURL *finalURL = [urlComponents URL];
    
    /// With your finalURL consturcted, perform a shared URLSession dataTaskWithURL and completion
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        /// Handle the error
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        /// Print the response
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        /// Unwrap your data
        if (data)
        {
            /// Create a topLevel Dictionary from serializing the JSON from the unwrapped data
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
            
            /// Step into your data dictionary from the topLevel dictionary
            NSDictionary *dataDict = topLevel[@"data"];
            
            /// Creating our placeholder array for our cities
            NSMutableArray *cities = [NSMutableArray new];
            
            /// Loop through the data dictionary and create an array of strings from the names of the cities found
           for (NSDictionary *cityDict in dataDict)
           {
               NSString *city = [[NSString alloc] initWithString:cityDict[@"city"]];
               [cities addObject:city];
           }
            /// Complete with the array of strings
            completion(cities);
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(DVMCityAirQuality * _Nullable))completion
{
    /// Start with defining a url from the baseURLString
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    /// Append the versionComponent string as a pathComponent
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    
    /// Append the countryComponent string as a pathComponent
    NSURL *cityDetailsURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    /// Add your apiKey as a queryItem with the key of "key"
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    /// Add a qureryItem for the state, use the string value for the state parameter as the value and "city" as the key
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    
    /// Add a qureryItem for the state, use the string value for the state parameter as the value and "state" as the key
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    
    /// Add a queryItem for the country, use the string value for the country parameter as the value and "country" as the key
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    
    /// Here is where we take in the key:@"key" and the apiKey's value...
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    /// ...And pass it into the URL, along with countryQuery, stateQuery and cityQuery
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    /// This appends the key to the url
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityDetailsURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    /// Our final URL
    NSURL *finalURL = [urlComponents URL];
    
    /// With your finalURL consturcted, perform a shared URLSession dataTaskWithURL and completion
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        /// Handle the error
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        /// Print the response
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        /// Unwrap your data
        if (data)
        {
            /// Create a topLevel Dictionary from serializing the JSON from the unwrapped data
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
            
            /// Step into your data dictionary from the topLevel dictionary
            NSDictionary *dataDict = topLevel[@"data"];
            
            /// Perform your dataTask with the finalURL and complete with the CityAirQuality object found
            DVMCityAirQuality *cityAQI = [[DVMCityAirQuality alloc] initWithDictionary:dataDict];
            completion(cityAQI);
        }
    }] resume];
}

@end
