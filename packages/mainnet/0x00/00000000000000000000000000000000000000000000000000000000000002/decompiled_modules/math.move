module 0x2::math {
    public fun sqrt(arg0: u64) : u64 {
        0x1::u64::sqrt(arg0)
    }

    public fun diff(arg0: u64, arg1: u64) : u64 {
        0x1::u64::diff(arg0, arg1)
    }

    public fun divide_and_round_up(arg0: u64, arg1: u64) : u64 {
        0x1::u64::divide_and_round_up(arg0, arg1)
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        0x1::u64::max(arg0, arg1)
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        0x1::u64::min(arg0, arg1)
    }

    public fun pow(arg0: u64, arg1: u8) : u64 {
        0x1::u64::pow(arg0, arg1)
    }

    public fun sqrt_u128(arg0: u128) : u128 {
        0x1::u128::sqrt(arg0)
    }

    // decompiled from Move bytecode v6
}

