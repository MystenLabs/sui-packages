module 0xf4719ea787e63d9c21d6f5711e1b65110dd8b4f23c14ceab16fa20ab8ac023f4::prize {
    struct PrizeLevelDistribution has copy, drop, store {
        first_level: u64,
        second_level: u64,
        third_level: u64,
        fourth_level: u64,
        fifth_level: u64,
        sixth_level: u64,
    }

    public fun create_prize_level_distribution(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : PrizeLevelDistribution {
        PrizeLevelDistribution{
            first_level  : arg0,
            second_level : arg1,
            third_level  : arg2,
            fourth_level : arg3,
            fifth_level  : arg4,
            sixth_level  : arg5,
        }
    }

    public fun get_fifth_level(arg0: &PrizeLevelDistribution) : u64 {
        arg0.fifth_level
    }

    public fun get_first_level(arg0: &PrizeLevelDistribution) : u64 {
        arg0.first_level
    }

    public fun get_fourth_level(arg0: &PrizeLevelDistribution) : u64 {
        arg0.fourth_level
    }

    public fun get_prize_level_amount(arg0: &PrizeLevelDistribution, arg1: u8) : u64 {
        let v0 = &arg1;
        if (*v0 == 1) {
            arg0.first_level
        } else if (*v0 == 2) {
            arg0.second_level
        } else if (*v0 == 3) {
            arg0.third_level
        } else if (*v0 == 4) {
            arg0.fourth_level
        } else if (*v0 == 5) {
            arg0.fifth_level
        } else if (*v0 == 6) {
            arg0.sixth_level
        } else {
            0
        }
    }

    public fun get_second_level(arg0: &PrizeLevelDistribution) : u64 {
        arg0.second_level
    }

    public fun get_sixth_level(arg0: &PrizeLevelDistribution) : u64 {
        arg0.sixth_level
    }

    public fun get_third_level(arg0: &PrizeLevelDistribution) : u64 {
        arg0.third_level
    }

    // decompiled from Move bytecode v6
}

