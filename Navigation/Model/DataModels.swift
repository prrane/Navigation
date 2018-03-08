

import Foundation

struct Model: Codable  {
    let car: [Car]
}

struct Car: Codable {
    let gpsposition: GPSPosition?
}

struct GPSPosition: Codable {
    let location: Location?
}

struct Location: Codable {
    let lat: Double?
    let lng: Double?
    let shortAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case shortAddress = "short_display_address"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let lat_intermediate = try values.decode(Double.self, forKey: .lat)
        lat = (lat_intermediate != 0) ? lat_intermediate : nil
        
        let lng_intermediate = try values.decode(Double.self, forKey: .lng)
        lng = (lng_intermediate != 0) ? lng_intermediate : nil
        
        shortAddress = try values.decode(String.self, forKey: .shortAddress)
    }
}
