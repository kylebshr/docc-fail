//
//  ReuseIdentifier.swift
//  CheckoutApplet
//
//  Created by Kyle Van Essen on 6/21/19.
//


private var identifiers : [ObjectIdentifier:Any] = [:]


final class ReuseIdentifier<Element> : Hashable
{
    //
    // MARK: Fetching Identifiers
    //

    static func identifier(for element : Element.Type) -> ReuseIdentifier<Element>
    {
        let typeIdentifier = ObjectIdentifier(element)
        
        if let identifier = identifiers[typeIdentifier] {
            return identifier as! ReuseIdentifier<Element>
        } else {
            let identifier = ReuseIdentifier<Element>()
            identifiers[typeIdentifier] = identifier
            return identifier
        }
    }
    
    let stringValue : String
    let identifier : ObjectIdentifier
    
    let hash : Int
    
    //
    // MARK: Private Methods
    //
    
    private init()
    {
        self.identifier = ObjectIdentifier(Element.self)
        
        self.stringValue = "\(self.identifier)"
        
        var hasher = Hasher()
        hasher.combine(self.identifier)
        self.hash = hasher.finalize()
    }
    
    //
    // MARK: Equatable
    //
    
    static func == (lhs: ReuseIdentifier, rhs: ReuseIdentifier) -> Bool
    {
        return lhs === rhs
    }
    
    //
    // MARK: Hashable
    //
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.hash)
    }
}
