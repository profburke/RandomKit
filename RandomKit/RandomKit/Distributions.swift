//
//  Distributions.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/20/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//
//  Implementations of the various distributions
//

import Foundation



/**

Map a value to the given range.

:param: value The value to transform.
:param: range The range to which the given value should be mapped.
:returns: The mapped value.

*/
public func linearTransform(value: Double, range: Range<Int>) -> Double
{
  return Double(range.startIndex) + Double(range.endIndex - range.startIndex) * value
}




/**

  An Int wrapper for arc4random_uniform.

  The default value for *range* is 0..<UInt32.max.

  :param: range The range for the returned random Int.
  :returns: A random Int in the range range.startIndex0..<range.endIndex.

*/
public func randomInt(_ range: Range<Int> = 0..<Int(UInt32.max)) -> Int
{
  let upperBound = range.endIndex - range.startIndex
  let randomValue = Int(arc4random_uniform(UInt32(upperBound)))
  return range.startIndex + randomValue
}




/**

  Generates a uniformly-distributed random double.

  The default range is 0..<1.

  :param: range The range from which the random value should be chosen.
  :returns: a uniformly-distributed random double.

*/
public func uniform(_ range: Range<Int> = 0..<1) -> Double
{
  let randomValue = Double(arc4random())/Double(UInt32.max)
  return linearTransform(randomValue, range)
}




/**

  Generates a normally-distributed random double with given mean and standard deviation.

  The mean defaults to 0 and the standard deviation defaults to 1.0. Uses the Marsaglia and
  Bray (Polar) method
  (see http://phoxis.org/2013/05/04/generating-random-numbers-from-normal-distribution-in-c/ )

  :param: mu The average value of the distribution.
  :param: sigma The standard deviation of the distribution.
  :returns: a normally-distributed random double.

*/
public func normal(mu: Double = 0.0, sigma: Double = 1.0) -> Double
{
  struct FunctionLocalState {
    static var spareResult: Double = 0.0
    static var spareExists: Bool = false
  }
  let result: Double
  
  if FunctionLocalState.spareExists {
    result = FunctionLocalState.spareResult
  } else {
    var U1: Double
    var U2: Double
    var W: Double
    do {
      U1 = uniform(-1...1)
      U2 = uniform(-1...1)
      W = pow(U1, 2) + pow(U2, 2)
    } while W >= 1 || 0 == W
    
    let mult = sqrt( -2 * log(W) / W)
    result = U1 * mult
    FunctionLocalState.spareResult = U2 * mult
  }
  
  FunctionLocalState.spareExists = !FunctionLocalState.spareExists
  
  return mu + sigma * result
}




/**

  Generates an exponentially-distributed random variable.

  The parameter *c*, average number of events per unit-time, defaults to 1.

  :param: c The average number of events per unit-time.
  :returns: an exponentially-distributed random double.

*/
public func exponential(_ c: Double = 1.0) -> Double
{
  return -1.0 * log(uniform()) / c
}




// l must be negative
public func poisson(_ l: Double = -1) -> Int
{
  let threshold = exp(l)
  var product = 1.0
  var count = 0
  do {
    product *= uniform()
    count++
  } while (threshold < product)
  return count
}




public func binomial(success: Double, trials: Int = 1) -> Int
{
  // success must be in [0,1]
  var result = 0
  for i in 1...trials {
    if uniform() < success {
      result++
    }
  }
  
  return result
}




// Range is the range covered by the pdf; max is the maximum value of the
// pdf on its range.
public func rejection(pdf: Double -> Double, range: Range<Int>, max: Double) -> Double
{
  while true {
    let test = linearTransform(uniform(), range)
    if uniform() < pdf(test/max) {
      return test
    }
  }
}
