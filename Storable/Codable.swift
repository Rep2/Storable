import Foundation

extension Encodable {
    public func encode() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    public func loggedEncode() -> Data {
        guard let data = try? encode() else {
            fatalError("Encode of type \(Self.self) failed")
        }

        return data
    }
}

extension Decodable {
    public static func decode(data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }

    public static func loggedDecode(data: Data) -> Self {
        guard let instance = try? decode(data: data) else {
            fatalError("Decode of type \(Self.self) failed")
        }

        return instance
    }
}
