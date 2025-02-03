module 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::fixed_point_roll {
    public fun div_down(arg0: u64, arg1: u64) : u64 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::mul_div_down(arg0, 1000000000, arg1)
    }

    public fun div_up(arg0: u64, arg1: u64) : u64 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::mul_div_up(arg0, 1000000000, arg1)
    }

    public fun mul_down(arg0: u64, arg1: u64) : u64 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::mul_div_down(arg0, arg1, 1000000000)
    }

    public fun mul_up(arg0: u64, arg1: u64) : u64 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::mul_div_up(arg0, arg1, 1000000000)
    }

    public fun roll() : u64 {
        1000000000
    }

    public fun to_roll(arg0: u64, arg1: u64) : u64 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::mul_div_down(arg0, 1000000000, (arg1 as u64))
    }

    public fun try_div_down(arg0: u64, arg1: u64) : (bool, u64) {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::try_mul_div_down(arg0, 1000000000, arg1)
    }

    public fun try_div_up(arg0: u64, arg1: u64) : (bool, u64) {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::try_mul_div_up(arg0, 1000000000, arg1)
    }

    public fun try_mul_down(arg0: u64, arg1: u64) : (bool, u64) {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::try_mul_div_down(arg0, arg1, 1000000000)
    }

    public fun try_mul_up(arg0: u64, arg1: u64) : (bool, u64) {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math64::try_mul_div_up(arg0, arg1, 1000000000)
    }

    // decompiled from Move bytecode v6
}

