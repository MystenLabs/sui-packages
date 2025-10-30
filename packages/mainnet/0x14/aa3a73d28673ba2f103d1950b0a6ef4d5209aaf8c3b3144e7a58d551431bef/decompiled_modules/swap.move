module 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::swap {
    public fun exact_in(arg0: bool, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg0) {
            0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(arg3, arg2 - 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(arg3, 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(arg3, arg2) + 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(arg1))))
        } else {
            0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(arg3, arg2) - 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(arg3, 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(arg3, arg2) + 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(arg1), arg3)))
        }
    }

    // decompiled from Move bytecode v6
}

