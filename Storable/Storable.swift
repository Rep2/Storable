import Foundation

public enum StorableError: Error, LocalizedError {
    case dataNotFound(identifier: String)

    public var errorDescription: String? {
        switch self {
        case .dataNotFound(let identifier):
            return "Data for \(identifier) not stoed in user defaults"
        }
    }
}

public protocol Storable: Codable {
    static var identifier: String { get }

    static func fetchFromUserDefaults() throws -> Self
    func saveInUserDefaults() throws
}

extension Storable {
    public static var identifier: String {
        return String(describing: Self.self)
    }

    public static func fetchFromUserDefaults() throws -> Self {
        guard let decoded = UserDefaults.standard.object(forKey: identifier) as? Data else {
            throw StorableError.dataNotFound(identifier: identifier)
        }

        return try Self.decode(data: decoded)
    }

    public static func deleteFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: identifier)
    }

    public func saveInUserDefaults() throws {
        let data = try encode()

        UserDefaults.standard.set(data, forKey: Self.identifier)
    }
}
