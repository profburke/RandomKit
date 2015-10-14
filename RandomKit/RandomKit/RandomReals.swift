//
//  RandomReals.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/23/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation





/**

Generates a uniformly-distributed random double.

The default range is 0..<1.

:param: range The range from which the random value should be chosen.
:returns: a uniformly-distributed random double.

*/
public func uniform(range: Range<Int> = 0..<1) -> Double
{
  let r = Double(arc4random())/Double(UInt32.max)
  return linearTransform(r, range: range)
}





public func uniformFloat(range: Range<Int> = 0..<1) -> Float
{
  let r = Float(arc4random())/Float(UInt32.max)
  return linearTransform(r, range: range)
}