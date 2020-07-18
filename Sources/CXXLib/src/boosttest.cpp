// Test file

#include "boosttest.hpp"

namespace boosttest {
std::string fakeToUpper(std::string input) {
    return input + "UPPERCASED";
}

std::string toUpper(std::string input) {
    return boost::algorithm::to_upper_copy(input);
}
}
