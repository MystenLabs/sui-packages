module 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::maths {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        arg0 * 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::base_uint() / arg1
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::base_uint()
    }

    // decompiled from Move bytecode v6
}

