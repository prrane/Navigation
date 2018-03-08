

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
    
}
