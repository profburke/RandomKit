//
//  RandomIntegerVariables.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/20/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation


public protocol RandomIntegerVariable: CustomStringConvertible, Equatable
{
  var value: Int { get }
}



public struct RandomIntVariable: RandomIntegerVariable
{
  public let range: Range<Int>
  
  public init(range: Range<Int> = 0..<1)
  {
    self.range = range
  }
  
  public var value: Int {
    get {
      return randomInt(range)
    }
  }
  
  public var description: String {
    get {
      return "R[\(range.startIndex)..<\(range.endIndex)]"
    }
  }
}


public func ==(lhs: RandomIntVariable, rhs: RandomIntVariable) -> Bool
{
  return lhs.range == rhs.range
}




public struct PoissonVariable: RandomIntegerVariable
{
  public let l: Double
  
  
  init(l: Double)
  {
    self.l = l
  }
  
  
  public var value: Int {
    get {
      return poisson(l)
    }
  }
  
  
  public var description: String {
    get {
      return "Poisson(l=\(l))"
    }
  }
}



public func ==(lhs: PoissonVariable, rhs: PoissonVariable) -> Bool
{
  return lhs.l == rhs.l
}




public struct BinomialVariable: RandomIntegerVariable
{
  public let trials: Int
  public let success: Double
  
  
  public init(success: Double, trials: Int)
  {
    self.trials = trials
    self.success = success
  }
  
  public var value: Int {
    get {
      return binomial(success, trials: trials)
    }
  }
  
  public var description: String {
    get {
      return "B(s=\(success), n=\(trials))"
    }
  }
}


public func ==(lhs: BinomialVariable, rhs: BinomialVariable) -> Bool
{
  return lhs.trials == rhs.trials && lhs.success == rhs.success
}


