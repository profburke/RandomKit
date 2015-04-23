//
//  Utilities.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/22/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation


/**

Determine whether platform is 64 bits.

:returns: True if the platform is 64 bits, false otherwise.

*/
public func is64BitPlatform() -> Bool
{
  return sizeof(Int) == sizeof(Int64)
}



// TODO: generics ?

/**

Map a double value to the given range.

:param: value The value to transform.
:param: range The range to which the given value should be mapped.
:returns: The mapped value.

*/
public func linearTransform(value: Double, range: Range<Int>) -> Double
{
  return Double(range.startIndex) + Double(range.endIndex - range.startIndex) * value
}





/**

Map a float value to the given range.

:param: value The value to transform.
:param: range The range to which the given value should be mapped.
:returns: The mapped value.

*/
public func linearTransform(value: Float, range: Range<Int>) -> Float
{
  return Float(range.startIndex) + Float(range.endIndex - range.startIndex) * value
}


