//
//  AppDelegate.swift
//  TreeTraversal
//
//  Created by vishnusankar on 17/04/18.
//  Copyright © 2018 vishnusankar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tree : Tree = Tree(traversalOrderType: .PreOrder)
        tree.addNode(value: 13)
        tree.addNode(value: 23)
        tree.addNode(value: 19)
        tree.addNode(value: 6)
        tree.addNode(value: 2)
        tree.addNode(value: 1)
        tree.addNode(value: 24)
//        tree.berthFirstTraverse(currentNode: tree.rootNode)
        tree.depthFirstTraverseInPreOrder(currentNode: tree.rootNode)
        
        
        
//        var tree : ArrayTree = ArrayTree()
//        tree.addNode(node: 13)
//        tree.addNode(node: 23)
//        tree.addNode(node: 19)
//        tree.addNode(node: 6)
//        tree.addNode(node: 2)
//        tree.addNode(node: 1)
//        tree.addNode(node: 24)
//        

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

class Node {
    var value : Int = 10
    var parentNode : Node?
    var leftNode : Node?
    var rightNode : Node?
    
    
    init(value : Int, parentNode : Node?, leftNode : Node?, rightNode : Node?) {
        self.value = value
        self.parentNode = parentNode
        self.leftNode = leftNode
        self.rightNode = rightNode
        
    }
}

struct Queue<T> {
    var array : [T] = [T]()
    var head : Int = 0
    var tail : Int = 0
    
    mutating func enqueue(value: T) {
        self.array.insert(value, at: tail)
        self.tail += 1
    }
    
    mutating func dequeue() -> T? {
        if self.array.count > 0 {
            let value = self.array[head]
            self.head += 1
            return value
        }
        return nil
    }
}

enum TraversalOrderType {
    case PreOrder
    case InOrder
    case PostOrder
}

class Tree {
    var rootNode : Node? = nil
    let traversalOrder : TraversalOrderType
    var treeQueue : Queue = Queue<Int>()
    var treeInArray = [Node]()
    
    init(traversalOrderType : TraversalOrderType) {
        self.traversalOrder = traversalOrderType
    }
    
    func addNode(value :Int) {
        
        if rootNode ==  nil {
            rootNode = Node(value: value, parentNode: nil, leftNode: nil, rightNode: nil)
            return
        }
        
        var tempNode : Node? = rootNode
        while tempNode != nil {
            if value > (tempNode?.value)! {
                if let rightNode = tempNode?.rightNode {
                    tempNode = rightNode
                }else {
                    tempNode?.rightNode = Node(value: value, parentNode: tempNode, leftNode: nil, rightNode: nil)
                    tempNode = nil
                }
            }
            else if value < (tempNode?.value)! {
                if let leftNode = tempNode?.leftNode {
                    tempNode = leftNode
                }else {
                    tempNode?.leftNode = Node(value: value, parentNode: tempNode, leftNode: nil, rightNode: nil)
                    tempNode = nil
                }
            }
        }
    }
    
    func depthFirstTraverseInPreOrder(currentNode : Node?) {
        
        //Traverse through left side
        if currentNode == nil {
            return
        }
//        if traversalOrder == .PreOrder {
            //print(currentNode?.value as Any)
//            self.treeQueue.enqueue(value: (currentNode?.value)!)
//        }

        self.depthFirstTraverseInPreOrder(currentNode: currentNode?.leftNode)
//        if traversalOrder == .InOrder {
            print(currentNode?.value as Any)
//            self.treeQueue.enqueue(value: (currentNode?.value)!)
//        }
        self.depthFirstTraverseInPreOrder(currentNode: currentNode?.rightNode)
//        if traversalOrder == .PostOrder {
//            print(currentNode?.value as Any)
//            self.treeQueue.enqueue(value: (currentNode?.value)!)
//        }
    }
    
    func berthFirstTraverse(currentNode : Node?) {
        
        if currentNode == nil {
            return
        }
        
        var queue : Queue = Queue<Node>()
        queue.enqueue(value: currentNode!)
        
        while queue.array.count > 0 {
            let tempNode = queue.dequeue()
            print(tempNode?.value)
            if tempNode?.leftNode != nil {
                queue.enqueue(value: (tempNode?.leftNode!)!)
            }
            if tempNode?.rightNode != nil {
                queue.enqueue(value: (tempNode?.rightNode!)!)
            }
        }
        
        queue.array.removeAll()
    }
}

struct ArrayTree {
    var layerLevel : Int = 0
    var nodes : [Int] = [Int]()
    
    mutating func addNode(node : Int) {
        //Adding root node
        if nodes.count == 0 {
            self.nodes.append(node)
            return
        }
        
        var parentNodeIndex = 0
        var tempNode : Int? = self.nodes[parentNodeIndex] //root node
        while tempNode != nil {
            if tempNode! < node {
                let childNodeIndexValue = 2*parentNodeIndex+1
                let childNodeIndex = self.nodes.index(self.nodes.startIndex, offsetBy: childNodeIndexValue)
                let childNode =  self.nodes[childNodeIndex]
                
                if childNode != nil {
                    tempNode = childNode
                    parentNodeIndex = childNodeIndex
                }else {
                    
                }
                
            }
            else if tempNode! > node {
                
            }
        }
    }
}
