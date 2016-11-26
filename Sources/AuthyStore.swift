import Foundation

/// AuthyStore object that verifies phone numbers and authentication codes received via sms or Authy.
public struct AuthyStore {
    
    /// Authy private key
    private let key : String
    
    /// Initializer takes an Authy private key and sets up two-factor authentication.
    public init(key: String) {
        self.key = key
    }
    
    /// Requests and sms token for a given phone number.
    public func requestSMS(countryCode: Int, phoneNumber: String, completionHandler: @escaping (Bool)->Void) {
        
        print("request SMS")
        
        let requestString = "https://api.authy.com/protected/json/phones/verification/start"
        
        var request = URLRequest(url: URL(string: requestString)!)
        request.httpMethod = "POST"
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("278", forHTTPHeaderField: "Content-Length")
        
        let json: [String:Any] = [
            "via" : "sms",
            "country_code" : countryCode,
            "phone_number" : phoneNumber
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch let error {
            print(error)
            request.httpBody = nil
        }
        
        request.addValue(key, forHTTPHeaderField: "X-Authy-API-Key")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            var success = false
            defer {
                DispatchQueue.main.async {
                    completionHandler(success)
                }
            }
            
            guard error == nil else {
                print("POST: Error requesting SMS: \(error)")
                return
            }
            guard let data = data else { return }
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            
            print(json)
            
            success = json["success"] as? Bool ?? false
        }
        task.resume()
    }
    
    /// Verifies a token for the phone number it was sent to via SMS.
    public func verify(countryCode: Int, phoneNumber: String, token: String, completionHandler: @escaping (Bool) -> Void) {
        
        let requestString = "https://api.authy.com/protected/json/phones/verification/check?phone_number=\(phoneNumber)&country_code=\(countryCode)&verification_code=\(token)"
        
        var request = URLRequest(url: URL(string: requestString)!)
        request.httpMethod = "GET"
        request.addValue(key, forHTTPHeaderField: "X-Authy-API-Key")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            var success = false
            defer {
                DispatchQueue.main.async {
                    completionHandler(success)
                }
            }
            
            guard error == nil else {
                print("GET Error calling to verify token: \(error)")
                return
            }
            guard let data = data else { return }
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String:Any]
            success = json["success"] as? Bool ?? success
        }
        task.resume()
        
    }
}
