//
//  RandomDoubleVariables.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/20/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation



public protocol RandomDoubleVariable: CustomStringConvertible, Equatable
{
  var value: Double { get }
}


public struct NormalVar: RandomDoubleVariable
{
  public let mu: Double
  public let sigma: Double

  
  public init(mu: Double, sigma: Double)
  {
    self.mu = mu
    self.sigma = sigma
  }
  
  public var value: Double {
    get {
      return normal(mu, sigma: sigma)
    }
  }
  
  
  public var description: String {
    get {
      return "\u{1d4a9}(\u{03bc}=\(mu), \u{03c3}=\(sigma))"
    }
  }
  
}


public func ==(lhs: NormalVar, rhs: NormalVar) -> Bool
{
  return lhs.mu == rhs.mu && lhs.sigma == rhs.sigma
}

