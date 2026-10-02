module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math {
    public fun buy_quote_upper_bound(arg0: u64, arg1: u64) : u64 {
        ceil_quote(arg0, arg1)
    }

    public fun ceil_quote(arg0: u64, arg1: u64) : u64 {
        to_u64(((arg0 as u128) * (arg1 as u128) + 1000000 - 1) / 1000000)
    }

    public fun fee_cap_upper_bound(arg0: u64, arg1: u64) : u64 {
        to_u64(((arg0 as u128) * (arg1 as u128) + 10000 - 1) / 10000)
    }

    public fun floor_quote(arg0: u64, arg1: u64) : u64 {
        to_u64((arg0 as u128) * (arg1 as u128) / 1000000)
    }

    public fun maker_quote_delta(arg0: u64, arg1: u64, arg2: u64) : u64 {
        floor_quote(arg0 + arg1, arg2) - floor_quote(arg0, arg2)
    }

    public fun risk_base_delta(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = if (v0 <= 1000000 - v0) {
            v0
        } else {
            1000000 - v0
        };
        to_u64(v1 * (arg1 as u128) / 1000000)
    }

    public fun sell_quote_lower_bound(arg0: u64, arg1: u64) : u64 {
        floor_quote(arg0, arg1)
    }

    public fun taker_fee_delta(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        to_u64((((arg0 as u128) + (arg1 as u128)) * (arg3 as u128) + 10000 - 1) / 10000) - arg2
    }

    fun to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::overflow());
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

