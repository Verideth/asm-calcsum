/* another simple assembly and C++11
 * example on pointer logic and storing
 * values into pointers. simple 
 * product quotient and remainder calculator*/
#include <iostream>
#include <cstdint>

extern "C" std::int32_t intmuldiv(std::int32_t a, // 8
    std::int32_t b, // 12
    std::int32_t* prod, // 16
    std::int32_t* quo, // 20
    std::int32_t* rem); // 24

std::int32_t main(std::int32_t argc, char* argv[])
{
    std::int32_t a = 10;
    std::int32_t b = 2;
    std::int32_t prod = 0;
    std::int32_t quo = 0;
    std::int32_t rem = 0;
    std::int32_t* product = &prod;
    std::int32_t* quotient = &quo;
    std::int32_t* remainder = &rem;

    intmuldiv(a, b, product, quotient, remainder);

    std::cout << *product << std::endl;
    std::cout << *quotient << std::endl;
    std::cout << *remainder << std::endl;

    std::cout << "done!" << std::endl;

    std::cin.get();

    delete product;
    delete quotient;
    delete remainder;

    return 0;
}