module 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::swap {
    public fun exact_in(arg0: bool, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg0) {
            0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::floor(0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::mul_128(arg3, arg2 - 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::div_128(arg3, 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::div_128(arg3, arg2) + 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::to_128(arg1))))
        } else {
            0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::floor(0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::div_128(arg3, arg2) - 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::div_128(arg3, 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::div_128(0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::mul_128(arg3, arg2) + 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic::to_128(arg1), arg3)))
        }
    }

    // decompiled from Move bytecode v6
}

