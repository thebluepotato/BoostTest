// Test file

#include "boosttest.hpp"

namespace boosttest {
std::string toUpper(std::string input) {
    return boost::algorithm::to_upper_copy(input);
}
}
