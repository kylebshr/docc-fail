//
//  ListChangesQueue.swift
//  ListableUI
//
//  Created by Kyle Van Essen on 7/19/21.
//

import Foundation


/// Used to queue updates into a list view.
/// Note: This type is only safe to use from the main thread.
final class ListChangesQueue {
        
    /// Adds a synchronous block to the queue, marked as done once the block exits.
    func add(_ block : @escaping () -> ()) {
        self.waiting.append(.init(block))
        self.runIfNeeded()
    }
    
    /// Set by consumers to enable and disable queueing during a reorder event.
    var isQueuingForReorderEvent : Bool = false {
        didSet {
            self.runIfNeeded()
        }
    }
    
    /// Prevents processing other events in the queue.
    ///
    /// Note: Right now this just checks `isQueuingForReorderEvent`, but may check more props in the future.
    var isPaused : Bool {
        self.isQueuingForReorderEvent
    }
    
    /// Operations waiting to execute.
    private(set) var waiting : [Operation] = []
    
    /// Invoked to continue processing queue events.
    private func runIfNeeded() {
        precondition(Thread.isMainThread)
        
        /// Nothing to do if we're currently paused!
        guard self.isPaused == false else {
            return
        }
        
        while let next = self.waiting.popFirst() {
            autoreleasepool {
                guard case .new(let new) = next.state else {
                    fatalError("State of enqueued operation was wrong")
                }
                
                /// Ok, we have a runnable operation; let's run it.
                
                next.state = .done
                
                new.body()
            }
        }
    }
}


extension ListChangesQueue {
    
    final class Operation {
        
        fileprivate(set) var state : State
        
        init(_ body : @escaping () -> ()) {
            self.state = .new(.init(body: body))
        }
        
        enum State {
            case new(New)
            case done
            
            struct New {
                let body : () -> ()
            }
        }
    }
}


fileprivate extension Array {
    
    mutating func popFirst() -> Element? {
        guard self.isEmpty == false else {
            return nil
        }
        
        let first = self[0]
        
        self.remove(at: 0)
        
        return first
    }
}
