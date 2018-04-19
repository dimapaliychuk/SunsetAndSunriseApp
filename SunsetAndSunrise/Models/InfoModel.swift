//
//  InfoModel.swift
//  SunsetAndSunrise
//
//  Created by Dima Paliychuk on 4/18/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Foundation

class InfoResponseModel: Codable {
    
    var results: InfoModel
    var status: String
    
    // compiler generated
    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case status = "status"
    }
}

class InfoModel: Codable {
    
    var sunrise: String
    var sunset: String
    var solarNoon: String
    var dayLength: String
    var civilTwilightBegin: String
    var civilTwilightEnd: String
    var nauticalTwilightBegin: String
    var nauticalTwilightEnd: String
    var astronomicalTwilightBegin: String
    var astronomicalTwilightEnd: String
    
    // compiler generated
    private enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
        case solarNoon = "solar_noon"
        case dayLength = "day_length"
        case civilTwilightBegin = "civil_twilight_begin"
        case civilTwilightEnd = "civil_twilight_end"
        case nauticalTwilightBegin = "nautical_twilight_begin"
        case nauticalTwilightEnd = "nautical_twilight_end"
        case astronomicalTwilightBegin = "astronomical_twilight_begin"
        case astronomicalTwilightEnd = "astronomical_twilight_end"
    }
}
