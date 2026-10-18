module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::vq_r {
    struct P has copy, drop {
        x: u64,
        y: u64,
        lp: u64,
        pf: u64,
        pfx: u64,
        pfy: u64,
        stable: bool,
        enabled: bool,
    }

    fun o(arg0: &P, arg1: bool, arg2: u64) : u64 {
        let v0 = if (!arg0.enabled) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg0.x == 0) {
            true
        } else if (arg0.y == 0) {
            true
        } else {
            arg0.stable
        };
        if (v0) {
            return 0
        };
        if ((arg0.lp as u128) > 1000000) {
            return 0
        };
        let v1 = (arg2 as u128) * (arg0.pf as u128) / 1000000;
        if (v1 > (arg2 as u128)) {
            return 0
        };
        let v2 = (arg2 as u128) - v1;
        let (v3, v4, v5) = if (arg1) {
            (arg0.x, arg0.y, arg0.pfx)
        } else {
            (arg0.y, arg0.x, arg0.pfy)
        };
        let v6 = v2 * (1000000 - (arg0.lp as u128));
        if (v4 > 0 && v6 > 340282366920938463463374607431768211455 / (v4 as u128)) {
            return 0
        };
        let v7 = (v3 as u128) * 1000000 + v6;
        if (v7 == 0) {
            return 0
        };
        let v8 = v6 * (v4 as u128) / v7;
        if (v8 > 18446744073709551615 || v8 > (v4 as u128)) {
            return 0
        };
        if ((v3 as u128) + v2 > 18446744073709551615 || (v5 as u128) + v1 > 18446744073709551615) {
            return 0
        };
        if (((v3 as u128) + v2) * ((v4 as u128) - v8) <= (v3 as u128) * (v4 as u128)) {
            return 0
        };
        (v8 as u64)
    }

    fun p(arg0: vector<u8>) : P {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 183);
        P{
            x       : 0x2::bcs::peel_u64(&mut v0),
            y       : 0x2::bcs::peel_u64(&mut v0),
            lp      : 0x2::bcs::peel_u64(&mut v0),
            pf      : 0x2::bcs::peel_u64(&mut v0),
            pfx     : 0x2::bcs::peel_u64(&mut v0),
            pfy     : 0x2::bcs::peel_u64(&mut v0),
            stable  : 0x2::bcs::peel_bool(&mut v0),
            enabled : 0x2::bcs::peel_bool(&mut v0),
        }
    }

    public fun r<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: bool) {
        let v0 = p(0x2::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1));
        let v1 = 0;
        while (v1 < 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::cn(arg0)) {
            let v2 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ra(arg0, v1);
            if (v2 > 0) {
                0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::sr(arg0, v1, o(&v0, arg2, v2));
            };
            v1 = v1 + 1;
        };
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::np(arg0, 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

