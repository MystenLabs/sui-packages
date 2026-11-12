module 0x47ae7ed0da3ec1bf71bb3b9a41deeee200f731d7affcb3695925d886d886b01b::a {
    public fun bfc<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        check_sqrt_price(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun cc<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        check_sqrt_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    fun check_reserve_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg2 > 0) {
                    arg3 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 103);
        if (arg4) {
            assert!((arg1 as u128) * (arg2 as u128) >= (arg3 as u128) * (arg0 as u128), 101);
        } else {
            assert!((arg1 as u128) * (arg2 as u128) <= (arg3 as u128) * (arg0 as u128), 101);
        };
    }

    fun check_sqrt_price(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    public fun dcc<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) {
        let (v0, v1) = dipcoin_reserves(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0));
        check_reserve_price(v0, v1, arg1, arg2, arg3);
    }

    fun dipcoin_reserves(arg0: vector<u8>) : (u64, u64) {
        assert!(0x1::vector::length<u8>(&arg0) == 96, 102);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun tbc<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        check_sqrt_price(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

