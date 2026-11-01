module 0x36b4a91087080d013a45cc5d1ff62d9248719e8375a33b93d3f5696222effde7::dipcoin {
    public fun quote<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg1: u64, arg2: bool) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1, v2) = state(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0));
        let (v3, v4) = if (arg2) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        (arg1, 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_out(v2, arg1, v3, v4))
    }

    public(friend) fun state(arg0: vector<u8>) : (u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    // decompiled from Move bytecode v7
}

