module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::vq_i {
    fun g(arg0: vector<u8>) : (bool, bool) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_vec_address(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 181);
        let v2 = !0x2::bcs::peel_bool(&mut v0) && 0x2::bcs::peel_u64(&mut v0) == 1;
        (v2, 0x2::bcs::peel_bool(&mut v0))
    }

    public fun i<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg3: bool) {
        let (v0, v1) = g(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global>(arg2));
        let (v2, v3, v4, v5, v6) = p(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1));
        let (v7, v8, v9) = if (arg3) {
            (v2, v3, v4)
        } else {
            (v3, v2, v5)
        };
        let v10 = 0;
        while (v10 < 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::cn(arg0)) {
            let v11 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ra(arg0, v10);
            if (v11 > 0) {
                let v12 = if (v0) {
                    o(v6, v11, v7, v8, v9, v1)
                } else {
                    0
                };
                0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::sr(arg0, v10, v12);
            };
            v10 = v10 + 1;
        };
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::np(arg0, 0x2::object::id<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1), arg3);
    }

    fun o(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg0 > 2000
        };
        if (v0) {
            return 0
        };
        let v1 = (arg1 as u256) * (10000 - (arg0 as u256));
        let v2 = v1 * (arg3 as u256) / ((arg2 as u256) * 10000 + v1);
        if (v2 > 18446744073709551615) {
            return 0
        };
        let v3 = (v2 as u64);
        let v4 = if (arg5) {
            (((arg1 as u128) * (arg0 as u128) / 10000) as u64) / 5
        } else {
            0
        };
        if ((arg4 as u128) + (v4 as u128) > (18446744073709551615 as u128)) {
            return 0
        };
        let v5 = (arg2 as u128) + ((arg1 - v4) as u128);
        if (v5 > (18446744073709551615 as u128)) {
            return 0
        };
        if ((arg2 as u128) * (arg3 as u128) > v5 * ((arg3 - v3) as u128)) {
            return 0
        };
        v3
    }

    public(friend) fun p(arg0: vector<u8>) : (u64, u64, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 181);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    // decompiled from Move bytecode v7
}

