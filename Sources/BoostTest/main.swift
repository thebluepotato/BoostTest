//
//  File.swift
//  
//
//  Created by Jonas Zaugg on 18.07.20.
//

import CWrapper
//import CXXBoost

/// The imported C function calls the C++ toUpper(_:) function (which uses Boost to uppercase the string) and prints the result
print_upper_c("Test string") // Test string -> TEST STRING

