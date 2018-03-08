//
//  foo.swift
//  Navigation
//
//  Created by Prashant Rane on 08/03/18.
//  Copyright © 2018 Prashant Rane. All rights reserved.
//

import Foundation

import Foundation
struct Json4Swift_Base : Codable {
    let battery_level : Int?
//    let door : Door?
    let door_status : String?
    let fuel_percentage : Int?
//    let gpsposition : Gpsposition?
    let id : Int?
    let is_active : Bool?
    let is_available : Bool?
    let lat : Double?
    let license_plate_number : String?
    let lng : Double?
    let pool : String?
    let remaining_mileage : Int?
    let remaining_range_in_meters : Int?
    let reservation_status : String?
//    let services : [Services]?
    let transmission_mode : String?
    let vehicle_make : String?
    let vehicle_pic : String?
    let vehicle_pic_absolute_url : String?
    let vehicle_type : String?
    let vehicle_type_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case battery_level = "battery_level"
//        case door
        case door_status = "door_status"
        case fuel_percentage = "fuel_percentage"
//        case gpsposition
        case id = "id"
        case is_active = "is_active"
        case is_available = "is_available"
        case lat = "lat"
        case license_plate_number = "license_plate_number"
        case lng = "lng"
        case pool = "pool"
        case remaining_mileage = "remaining_mileage"
        case remaining_range_in_meters = "remaining_range_in_meters"
        case reservation_status = "reservation_status"
//        case services = "services"
        case transmission_mode = "transmission_mode"
        case vehicle_make = "vehicle_make"
        case vehicle_pic = "vehicle_pic"
        case vehicle_pic_absolute_url = "vehicle_pic_absolute_url"
        case vehicle_type = "vehicle_type"
        case vehicle_type_id = "vehicle_type_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        battery_level = try values.decodeIfPresent(Int.self, forKey: .battery_level)
//        door = try Door(from: decoder)
        door_status = try values.decodeIfPresent(String.self, forKey: .door_status)
        fuel_percentage = try values.decodeIfPresent(Int.self, forKey: .fuel_percentage)
//        gpsposition = try Gpsposition(from: decoder)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        is_active = try values.decodeIfPresent(Bool.self, forKey: .is_active)
        is_available = try values.decodeIfPresent(Bool.self, forKey: .is_available)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        license_plate_number = try values.decodeIfPresent(String.self, forKey: .license_plate_number)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
        pool = try values.decodeIfPresent(String.self, forKey: .pool)
        remaining_mileage = try values.decodeIfPresent(Int.self, forKey: .remaining_mileage)
        remaining_range_in_meters = try values.decodeIfPresent(Int.self, forKey: .remaining_range_in_meters)
        reservation_status = try values.decodeIfPresent(String.self, forKey: .reservation_status)
//        services = try values.decodeIfPresent([Services].self, forKey: .services)
        transmission_mode = try values.decodeIfPresent(String.self, forKey: .transmission_mode)
        vehicle_make = try values.decodeIfPresent(String.self, forKey: .vehicle_make)
        vehicle_pic = try values.decodeIfPresent(String.self, forKey: .vehicle_pic)
        vehicle_pic_absolute_url = try values.decodeIfPresent(String.self, forKey: .vehicle_pic_absolute_url)
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        vehicle_type_id = try values.decodeIfPresent(Int.self, forKey: .vehicle_type_id)
    }
    
}
