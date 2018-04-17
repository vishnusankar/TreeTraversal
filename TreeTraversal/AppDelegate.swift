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
        tree.depthFirstTraverseInPreOrder(currentNode: tree.rootNode)
//        print(tree.treeQueue.array)
        
        let secondTree = Tree(traversalOrderType: .PreOrder)
        for value in tree.treeQueue.array {
            secondTree.addNode(value: value)
        }
        secondTree.depthFirstTraverseInPreOrder(currentNode: secondTree.rootNode)
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
    var value : Int = -1
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

struct Queue {
    var array : [Int] = [Int]()
    var head : Int = 0
    var tail : Int = 0
    
    mutating func enqueue(value: Int) {
        self.array.insert(value, at: tail)
        self.tail += 1
    }
    
    mutating func dequeue() -> Int {
        let value = self.array[head]
        self.head += 1
        return value
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
    var treeQueue : Queue = Queue()
    
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
        if traversalOrder == .PreOrder {
            print(currentNode?.value as Any)
            self.treeQueue.enqueue(value: (currentNode?.value)!)
        }
        self.depthFirstTraverseInPreOrder(currentNode: currentNode?.leftNode)
        if traversalOrder == .InOrder {
            print(currentNode?.value as Any)
            self.treeQueue.enqueue(value: (currentNode?.value)!)
        }
        self.depthFirstTraverseInPreOrder(currentNode: currentNode?.rightNode)
        if traversalOrder == .PostOrder {
            print(currentNode?.value as Any)
            self.treeQueue.enqueue(value: (currentNode?.value)!)
        }
    }
}

