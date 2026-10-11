module 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount {
    public fun bps(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun cap_fee_rate(arg0: u8) : u8 {
        if (arg0 > 100) {
            100
        } else {
            arg0
        }
    }

    public fun denormalize_amount(arg0: u64, arg1: u8) : u64 {
        if (arg0 > 0 && arg1 > 8) {
            arg0 * 0x1::u64::pow(10, arg1 - 8)
        } else {
            arg0
        }
    }

    public fun max_fee_rate() : u8 {
        100
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

    public fun sui_decimals() : u8 {
        9
    }

    // decompiled from Move bytecode v7
}

