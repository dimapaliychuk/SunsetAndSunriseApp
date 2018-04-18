//
//  JSONKeys.swift
//  Imago
//
//  Created by Dima Paliychuk on 8/23/17.
//  Copyright © 2017 StarGo. All rights reserved.
//

import Foundation


struct JSONKeys {

    static let password = "password"
    static let oldPassword = "old_password"
    static let newPassword = "new_password"
    static let auth_token = "auth_token"
    static let authorization = "Authorization"
    static let authentication = "authentication"
    
    //user
    static let user = "user"
    static let id = "id"
    static let quickblox_user_id = "quickblox_user_id"
    static let email_confirmed = "email_confirmed"
    static let created_at = "created_at"
    static let first_name = "first_name"
    static let email = "email"
    static let date_of_birth = "date_of_birth"
    static let gender = "gender"
    static let education = "education"
    static let profession = "profession"
    static let interested_in = "interested_in"
    static let orientation = "orientation"
    static let ethnicity = "ethnicity"
    static let looking_for = "looking_for"
    static let smoke_status = "smoke_status"
    static let drink_status = "drink_status"
    static let diet = "diet"
    static let about = "about"
    static let haveKidsKey = "have_kids"
    static let photosKey = "photos"
    static let photoUrlKey = "url"
    static let videoUrlKey = "video"
    static let videoThumbnailUrlKey = "video_thumbnail"
    
    
    //response
    static let status = "status"
    static let message = "message"
    static let code = "code"
    static let success = "success"
    static let confirmation_code = "confirmation_code"
    static let email_verified = "email_verified"
    static let user_authentication = "user_authentication"
    
    //settigs
    static let settings = "settings"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let location = "location"
    static let maxDistance = "max_distance"
    static let minAge = "min_age"
    static let maxAge = "max_age"
    static let newMatchNotification = "new_match_notification"
    static let messageNotification = "message_notification"
    static let videoCalls = "video_calls"
    static let showProfileToLiked = "show_my_profile_to_users_i_liked"
    static let hideAdds = "hide_advertisement"
    static let highlyVisibleProfile = "highly_visible_profile"
    static let pin = "pin"
    static let askPinAccess = "ask_pin_upon_access"
    static let page = "page"
    static let per_page = "per_page"
    
    
    //like
    static let like = "like"
    static let likeable_user_id = "likeable_user_id"
    static let dislike = "dislike"
    static let dislikeable_user_id = "dislikeable_user_id"
    static let undo = "undo"
    static let user_id = "user_id"
    
    
    //unmatch
    static let matched_user_id = "matched_user_id"
    static let quickblox_chat_id = "quickblox_chat_id"
    
    
    //report
    static let reportable_id = "reportable_id"
    
    
    //badges
    static let user_id_from_match = "user_id_from_match"
    
    
    //push notification
    static let ids = "ids"
    static let dialog_id = "dialog_id"
    static let imago_type = "imago_type"
    static let ios_sound = "ios_sound"
    static let ios_category = "ios_category"
    static let sender_qb_id = "sender_qb_id"
    static let sender_id = "sender_id"
    static let profile_url = "profile_url"
    static let login = "login"
    static let uuid = "uuid"
    static let receiver_id = "receiver_id"
    static let ios_voip = "ios_voip"
    static let quickblox_id = "quickblox_id"
    static let full_name = "full_name"
    static let messageNotificationCategory = "messageNotificationCategory"
    static let second_user_id = "second_user_id"
    static let first_user_id = "first_user_id"
    static let alert = "alert"
    static let aps = "aps"
}
