

import Foundation

enum JSONLoadingError: Error {
    case fileNotPresent
    case invalidData
}

class DataManager {
    
    static func jsonData(from jsonFileURL: URL) throws -> Data {
        return try Data(contentsOf: jsonFileURL, options: [.mappedIfSafe, .uncached])
    }
    
    static func jsonFileURL() throws -> URL {
        guard let fileURL = Bundle.main.url(forResource: "vehicles", withExtension: "json") else {
            throw JSONLoadingError.fileNotPresent
        }
        
        return fileURL
    }
    
    /// The JSON was not compatible with Codable JSON format, so this cleanup is required
    static func fetchCars(from jsonData: Data) throws -> [Car] {
        var cars = [Car]()
        
        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        if let topLevelDictionary = json as? [String: Any] {
            for obj in topLevelDictionary {
                if let carDictionary = obj.value as? [String: Any] {
                    let json = try JSONSerialization.data(withJSONObject: carDictionary, options: .prettyPrinted)
                    let car = try JSONDecoder().decode(Car.self, from: json)
                    if let _ = car.gpsposition?.location?.lat, let _ = car.gpsposition?.location?.lng {
                        cars.append(car)
                    }
                }
            }
        }
        
        return cars
    }
    
}
