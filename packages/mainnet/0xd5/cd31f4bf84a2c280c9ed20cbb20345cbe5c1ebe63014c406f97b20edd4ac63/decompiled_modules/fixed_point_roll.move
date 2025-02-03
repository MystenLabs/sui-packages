module 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::fixed_point_roll {
    public fun div_down(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::mul_div_down(arg0, 1000000000, arg1)
    }

    public fun div_up(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::mul_div_up(arg0, 1000000000, arg1)
    }

    public fun mul_down(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::mul_div_down(arg0, arg1, 1000000000)
    }

    public fun mul_up(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::mul_div_up(arg0, arg1, 1000000000)
    }

    public fun roll() : u64 {
        1000000000
    }

    public fun to_roll(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::mul_div_down(arg0, 1000000000, (arg1 as u64))
    }

    public fun try_div_down(arg0: u64, arg1: u64) : (bool, u64) {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::try_mul_div_down(arg0, 1000000000, arg1)
    }

    public fun try_div_up(arg0: u64, arg1: u64) : (bool, u64) {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::try_mul_div_up(arg0, 1000000000, arg1)
    }

    public fun try_mul_down(arg0: u64, arg1: u64) : (bool, u64) {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::try_mul_div_down(arg0, arg1, 1000000000)
    }

    public fun try_mul_up(arg0: u64, arg1: u64) : (bool, u64) {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::try_mul_div_up(arg0, arg1, 1000000000)
    }

    // decompiled from Move bytecode v6
}

