module 0x36b4a91087080d013a45cc5d1ff62d9248719e8375a33b93d3f5696222effde7::kriya {
    public(friend) fun after_protocol(arg0: u64, arg1: u64) : u64 {
        arg0 - (((arg0 as u128) * (arg1 as u128) / 1000000) as u64)
    }

    public fun quote<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: u64, arg2: bool) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1, v2, v3, v4, v5, v6) = state(0x2::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0));
        let (v7, v8, v9, v10) = if (arg2) {
            (v0, v1, v5, v6)
        } else {
            (v1, v0, v6, v5)
        };
        let v11 = if (v4) {
            0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::utils::get_input_price_stable(after_protocol(arg1, v3), v7, v8, v2, v9, v10)
        } else {
            0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::utils::get_input_price_uncorrelated(after_protocol(arg1, v3), v7, v8, v2)
        };
        (arg1, v11)
    }

    public(friend) fun state(arg0: vector<u8>) : (u64, u64, u64, u64, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun upper<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: bool) : (u256, u256) {
        let (v0, v1, v2, _, v4, _, _) = state(0x2::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0));
        upper_rate(v0, v1, v2, v4, arg1)
    }

    public(friend) fun upper_rate(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : (u256, u256) {
        if (arg3 || arg2 >= 1000000) {
            return (1, 0)
        };
        let (v0, v1) = if (arg4) {
            ((arg0 as u256), (arg1 as u256))
        } else {
            ((arg1 as u256), (arg0 as u256))
        };
        if (v0 == 0) {
            return (1, 0)
        };
        (v1 * ((1000000 - arg2) as u256), v0 * 1000000)
    }

    // decompiled from Move bytecode v7
}

