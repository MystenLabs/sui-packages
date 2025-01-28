module 0xb5bd3599ec7f4ae86afd84398f6f2d862deecce965e8ace2d8d8c8108d5076df::amount {
    public fun bps(arg0: u64, arg1: u16) : u64 {
        arg0 * (arg1 as u64) / 10000
    }

    public fun denormalize_amount(arg0: u64, arg1: u8) : u64 {
        if (arg0 > 0 && arg1 > 8) {
            arg0 * 0x1::u64::pow(10, arg1 - 8)
        } else {
            arg0
        }
    }

    public fun normalize_amount(arg0: u64, arg1: u8) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg1 > 8) {
            arg0 / 0x1::u64::pow(10, arg1 - 8)
        } else {
            arg0
        }
    }

    // decompiled from Move bytecode v6
}

