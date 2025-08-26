module 0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::mmt_tick_lens {
    public fun get_all_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64) : vector<0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::TickInfo> {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((arg1 as u32) * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0)));
        let v2 = v1;
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick())) {
            v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick(), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((arg1 as u32) * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0)));
        let v4 = v3;
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick())) {
            v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick(), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        let v5 = 0x1::vector::empty<0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::TickInfo>();
        let v6 = tick_to_word<T0, T1>(arg0, v2);
        while (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v6, tick_to_word<T0, T1>(arg0, v4))) {
            0x1::vector::append<0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::TickInfo>(&mut v5, get_populated_ticks_in_word<T0, T1>(arg0, v6, v2, v4));
            v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v6, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        v5
    }

    public fun get_populated_ticks_in_word<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) : vector<0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::TickInfo> {
        let v0 = 0x1::vector::empty<0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::TickInfo>();
        if (!0x2::table::contains<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0), arg1)) {
            return v0
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v2 = 0;
        while (v2 < 256) {
            if (*0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0), arg1) & 1 << (v2 as u8) > 0) {
                let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::shl(arg1, 8), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v2)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0)));
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v3, arg2) && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v3, arg3)) {
                    0x1::vector::push_back<0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::TickInfo>(&mut v0, 0x4f766df7d08c1fd16e957a7f634dcbebac109e57ebe6ebc60100e7e6fdb95652::tick_info::new(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v1, v3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v1, v3))));
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun tick_to_word<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::div(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0)));
        let v1 = v0;
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::is_neg(arg1) && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::abs_u32(arg1) % 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0) != 0) {
            v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::shr(v1, 8)
    }

    // decompiled from Move bytecode v6
}

