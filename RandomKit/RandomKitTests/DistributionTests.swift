//
//  DistributionTests.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/20/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import UIKit
import XCTest


class DistributionTests: XCTestCase
{
  

  // How the heck do we test this?
  func testUniform01()
  {
    let trials = 1000000
    
    for _ in 0..<trials {
      let u = uniform()
      if u < 0.0 { XCTFail("Generated value < 0") }
      if u > 1.0 { XCTFail("Generated value > 1") }
    }
  }
  
  
  func testUniformM1To1()
  {
    let range = -1...1
    let trials = 1000000
    var negativeAppeared = false
    var positiveAppeared = false
    
    for _ in 0..<trials {
      let u = uniform(range)
      if u < Double(range.startIndex) { XCTFail("Generated value < \(range.startIndex)") }
      if u > Double(range.endIndex) { XCTFail("Generated value > \(range.endIndex)") }
      if u > 0.0 { positiveAppeared = true }
      if u < 0.0 { negativeAppeared = true }
    }
    XCTAssertTrue(positiveAppeared, "really? no positive numbers generated?")
    XCTAssertTrue(negativeAppeared, "really? no negative numbers generated?")
  }
  
  
  
  func testNormal()
  {
    let trials = 1000000
    var sum = 0.0
    
    for _ in 0..<trials {
      let n = normal()
      sum += n
    }
    let average = sum/Double(trials)
    print("Avg: \(average)")
    XCTAssertEqualWithAccuracy(average, 0.0, accuracy: 0.01, "average is off")
  }
  

  
  func testNormalwAverage100()
  {
    let trials = 1000000
    var sum = 0.0
    
    for _ in 0..<trials {
      let n = normal(100)
      sum += n
    }
    let average = sum/Double(trials)
    print("Avg: \(average)")
    XCTAssertEqualWithAccuracy(average, 100.0, accuracy: 0.01, "average is off")
  }
  

  
}