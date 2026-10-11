module 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::amount {
    public fun bps(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun cap_fee_rate(arg0: u8) : u8 {
        if (arg0 > 250) {
            250
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
        250
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

