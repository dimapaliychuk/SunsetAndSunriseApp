//
//  API.swift
//  Imago
//
//  Created by Dima Paliychuk on 8/23/17.
//  Copyright © 2017 StarGo. All rights reserved.
//

import Foundation


class API {
    
    static var user: UserService {
        return UserService.shared
    }
    
    static var users: UsersService {
        return UsersService.shared
    }
    
    static var settings: SettingsService {
        return SettingsService.shared
    }
    
    static var places: PlacesService {
        return PlacesService.shared
    }
    
    static var notification: NotificationService {
        return NotificationService.shared
    }
}
