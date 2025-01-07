module 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

