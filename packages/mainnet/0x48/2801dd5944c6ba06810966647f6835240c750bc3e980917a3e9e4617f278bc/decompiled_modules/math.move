module 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math {
    struct Number has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Number, arg1: Number) : Number {
        Number{value: arg0.value + arg1.value}
    }

    public fun bps_round_up(arg0: Number, arg1: u64) : Number {
        Number{value: (arg0.value + (arg1 as u256) - 1) * 10000 / (arg1 as u256)}
    }

    public fun div(arg0: Number, arg1: Number) : Number {
        Number{value: arg0.value * 1000000000000000000 / arg1.value}
    }

    public fun div_round_up(arg0: Number, arg1: Number) : Number {
        Number{value: (arg0.value * 1000000000000000000 + arg1.value - 1) / arg1.value}
    }

    public fun from(arg0: u64) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_apr(arg0: u16) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000 / 10000}
    }

    public fun from_bps(arg0: u64) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000 / 10000}
    }

    public fun from_percentage(arg0: u8) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_u128(arg0: u128) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_u8(arg0: u8) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun ge(arg0: Number, arg1: Number) : bool {
        arg0.value >= arg1.value
    }

    public fun gt(arg0: Number, arg1: Number) : bool {
        arg0.value > arg1.value
    }

    public fun le(arg0: Number, arg1: Number) : bool {
        arg0.value <= arg1.value
    }

    public fun lt(arg0: Number, arg1: Number) : bool {
        arg0.value < arg1.value
    }

    public fun max(arg0: Number, arg1: Number) : Number {
        if (arg0.value > arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: Number, arg1: Number) : Number {
        if (arg0.value < arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Number, arg1: Number) : Number {
        Number{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun per_day_from_apr(arg0: u16) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000 / 10000 / 365}
    }

    public fun per_second_from_apr(arg0: u16) : Number {
        Number{value: (arg0 as u256) * 1000000000000000000 / 10000 / 365 / 24 / 60 / 60}
    }

    public fun percentage_round_up(arg0: Number, arg1: u8) : Number {
        Number{value: (arg0.value + (arg1 as u256) - 1) * 100 / (arg1 as u256)}
    }

    public fun pow(arg0: Number, arg1: u64) : Number {
        let v0 = from(1);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = mul(v0, arg0);
            };
            arg0 = mul(arg0, arg0);
            arg1 = arg1 / 2;
        };
        v0
    }

    public fun sub(arg0: Number, arg1: Number) : Number {
        Number{value: arg0.value - arg1.value}
    }

    public fun to_percentage(arg0: Number) : u8 {
        ((arg0.value * 100 / 1000000000000000000) as u8)
    }

    public fun to_u128(arg0: Number) : u128 {
        ((arg0.value / 1000000000000000000) as u128)
    }

    public fun to_u64(arg0: Number) : u64 {
        ((arg0.value / 1000000000000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

