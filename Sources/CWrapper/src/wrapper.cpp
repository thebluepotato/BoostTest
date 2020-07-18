//
//  File.cpp
//  
//
//  Created by Jonas Zaugg on 18.07.20.
//

#include "wrapper.h"

#include "boosttest.hpp"

extern "C" {

void print_upper_c(const char* str) {
    std::string cppstr = boosttest::toUpper(std::string(str));
    const char * ret = cppstr.c_str();
    //return ret;
    printf("%s -> %s\n", str, ret);
}

const char* to_upper_c(const char* str) {
    std::string cppstr = boosttest::toUpper(std::string(str));
    const char * ret = cppstr.c_str();
    return ret;
}

}
