module 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::fixed_point_roll {
    public fun div_down(arg0: u64, arg1: u64) : u64 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::mul_div_down(arg0, 1000000000, arg1)
    }

    public fun div_up(arg0: u64, arg1: u64) : u64 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::mul_div_up(arg0, 1000000000, arg1)
    }

    public fun mul_down(arg0: u64, arg1: u64) : u64 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::mul_div_down(arg0, arg1, 1000000000)
    }

    public fun mul_up(arg0: u64, arg1: u64) : u64 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::mul_div_up(arg0, arg1, 1000000000)
    }

    public fun roll() : u64 {
        1000000000
    }

    public fun to_roll(arg0: u64, arg1: u64) : u64 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::mul_div_down(arg0, 1000000000, (arg1 as u64))
    }

    public fun try_div_down(arg0: u64, arg1: u64) : (bool, u64) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::try_mul_div_down(arg0, 1000000000, arg1)
    }

    public fun try_div_up(arg0: u64, arg1: u64) : (bool, u64) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::try_mul_div_up(arg0, 1000000000, arg1)
    }

    public fun try_mul_down(arg0: u64, arg1: u64) : (bool, u64) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::try_mul_div_down(arg0, arg1, 1000000000)
    }

    public fun try_mul_up(arg0: u64, arg1: u64) : (bool, u64) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64::try_mul_div_up(arg0, arg1, 1000000000)
    }

    // decompiled from Move bytecode v6
}

