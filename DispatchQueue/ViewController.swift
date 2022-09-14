//
//  ViewController.swift
//  DispatchQueue
//
//  Created by Kim Nghĩa on 14/09/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        foo()
//        syncAwaitingGroup()
        DispatchQueueQOS()
    }

    func foo() {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "q1")
        let otherqueue = DispatchQueue(label: "q2")
        
        queue.async(group: group) {
            for i in 1...10 {
                print("queue:- task one running: \(i)")
            }
        }
        
        queue.async(group: group) {
            for i in 11...20 {
                print("queue:- task two running: \(i)")
            }
        }
        
        otherqueue.async {
            for i in 21...30 {
                print("otherqueue:- task one running: \(i)")
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("Done")
        }
    }

    func syncAwaitingGroup() {
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group: group) {
            print("Start job 1")
            Thread.sleep(until: Date().addingTimeInterval(6))
            print("End job 1")
        }
        
        queue.async(group: group) {
            print("Start job 2")
            Thread.sleep(until: Date().addingTimeInterval(7))
            print("End job 2")
        }
        
        if group.wait(timeout: .now() + 5) == .timedOut {
            print("long time")
        } else {
            print("All the jobs completed")
        }
    }
    
    func DispatchQueueQOS() {
        
        let queue1 = DispatchQueue.global(qos: .userInitiated)
        let queue2 = DispatchQueue.global(qos: .userInteractive)
        let queue3 = DispatchQueue.global(qos: .default)
        let queue4 = DispatchQueue.global(qos: .utility)
        let queue5 = DispatchQueue.global(qos: .background)
        
        queue1.async {
            for i in 1...10 {
                print("queue1:- \(i)")
            }
            print("queue1: finished")
        }
        
        queue2.async {
            for i in 11...20 {
                print("queue2:- \(i)")
            }
            print("queue2: finished")
        }

        queue3.async {
            for i in 21...30 {
                print("queue3:- \(i)")
            }
            print("queue3: finished")
        }

        queue4.async {
            for i in 31...40 {
                print("queue4:- \(i)")
            }
            print("queue4: finished")
        }

        queue5.async {
            for i in 41...50 {
                print("queue5:- \(i)")
            }
            print("queue5: finished")
        }
    }
    
}

