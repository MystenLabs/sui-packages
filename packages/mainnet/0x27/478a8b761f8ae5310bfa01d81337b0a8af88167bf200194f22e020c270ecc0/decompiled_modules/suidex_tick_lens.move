module 0x27478a8b761f8ae5310bfa01d81337b0a8af88167bf200194f22e020c270ecc0::suidex_tick_lens {
    struct TickInfo has copy, drop, store {
        index: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32,
        liquidity_gross: u128,
        liquidity_net: u128,
    }

    public fun get_all_ticks<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<TickInfo> {
        let v0 = 0x1::vector::empty<TickInfo>();
        0x1::vector::append<TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, arg2, true));
        0x1::vector::append<TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, arg2, false));
        v0
    }

    public fun get_initialized_ticks<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : vector<TickInfo> {
        let v0 = 0x1::vector::empty<TickInfo>();
        let v1 = 0;
        let v2 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg0);
        let v3 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v4 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_ticks<T0, T1>(arg0);
        while (0x1::vector::length<TickInfo>(&v0) < arg1 && v1 < arg2) {
            v1 = v1 + 1;
            let (v5, v6) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_bitmap::next_initialized_tick_within_one_word(v3, v2, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg0), arg3);
            if (arg3 && 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lt(v5, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::min_tick()) || 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::gt(v5, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::max_tick())) {
                break
            };
            let v7 = if (arg3) {
                0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::sub(v5, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::from(1))
            } else {
                v5
            };
            v2 = v7;
            if (v6) {
                let v8 = TickInfo{
                    index           : v5,
                    liquidity_gross : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick::get_liquidity_gross(v4, v5),
                    liquidity_net   : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::as_u128(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick::get_liquidity_net(v4, v5)),
                };
                0x1::vector::push_back<TickInfo>(&mut v0, v8);
            };
        };
        v0
    }

    // decompiled from Move bytecode v7
}

