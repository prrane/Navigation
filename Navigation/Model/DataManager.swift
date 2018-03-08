

import Foundation

enum JSONLoadingError: Error {
    case fileNotPresent
    case invalidData
}

/// A one stop solution for all your data needs
/// Fetching/Caching and Filtering (TBD)

class DataManager {
    
    static let shared = DataManager()
    
    func jsonData(from jsonFileURL: URL) throws -> Data {
        return try Data(contentsOf: jsonFileURL, options: [.mappedIfSafe, .uncached])
    }
    
    func jsonFileURL() throws -> URL {
        guard let fileURL = Bundle.main.url(forResource: "vehicles", withExtension: "json") else {
            throw JSONLoadingError.fileNotPresent
        }
        
        return fileURL
    }
    
    // The JSON was not compatible with Codable JSON format, so this cleanup is required
    // Real life method would accept current lat long from user and filter out the cars
    // from cache and/or fetch from server depending on how stale cache is
    func fetchCars() throws -> [Car] {

        var cars = [Car]()
        
        let carsData = try self.jsonData(from: jsonFileURL())
        let json = try JSONSerialization.jsonObject(with: carsData, options: [])
        
        // The keys in `topLevelDictionary` are numbers like 84, 1101, etc.. :-(
        if let topLevelDictionary = json as? [String: Any] {
            for obj in topLevelDictionary {
                if let carDictionary = obj.value as? [String: Any] {
                    // Convert the dictionary back to JSON data so as we can decode `Car`
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
