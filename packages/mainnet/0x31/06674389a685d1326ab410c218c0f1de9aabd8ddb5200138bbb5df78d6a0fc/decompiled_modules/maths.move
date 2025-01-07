module 0x3106674389a685d1326ab410c218c0f1de9aabd8ddb5200138bbb5df78d6a0fc::maths {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        arg0 * 0x3106674389a685d1326ab410c218c0f1de9aabd8ddb5200138bbb5df78d6a0fc::constants::base_uint() / arg1
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0x3106674389a685d1326ab410c218c0f1de9aabd8ddb5200138bbb5df78d6a0fc::constants::base_uint()
    }

    // decompiled from Move bytecode v6
}

