module 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_raw_value(0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::u64::mul_div(0x1::fixed_point32::get_raw_value(arg0), arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

