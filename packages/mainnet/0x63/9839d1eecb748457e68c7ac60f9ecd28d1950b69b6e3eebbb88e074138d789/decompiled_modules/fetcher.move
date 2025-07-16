module 0x639839d1eecb748457e68c7ac60f9ecd28d1950b69b6e3eebbb88e074138d789::fetcher {
    struct TickInfo has drop {
        index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::I128,
        fee_growth_outside_x: u128,
        fee_growth_outside_y: u128,
        reward_growths_outside: vector<u128>,
        tick_cumulative_out_side: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64,
        seconds_per_liquidity_out_side: u256,
        seconds_out_side: u64,
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u32, arg2: u32) : vector<TickInfo> {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0));
        let v1 = round_tick(arg1, v0, true);
        let v2 = 0x1::vector::empty<TickInfo>();
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        while (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v1, round_tick(arg2, v0, false))) {
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::is_initialized(v3, v1)) {
                let (v4, v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_fee_and_reward_growths_outside(v3, v1);
                let v7 = TickInfo{
                    index                          : v1,
                    liquidity_gross                : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v3, v1),
                    liquidity_net                  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v3, v1),
                    fee_growth_outside_x           : v4,
                    fee_growth_outside_y           : v5,
                    reward_growths_outside         : v6,
                    tick_cumulative_out_side       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_tick_cumulative_out_side(v3, v1),
                    seconds_per_liquidity_out_side : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_seconds_per_liquidity_out_side(v3, v1),
                    seconds_out_side               : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_seconds_out_side(v3, v1),
                };
                0x1::vector::push_back<TickInfo>(&mut v2, v7);
            };
            v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v1, v0);
        };
        v2
    }

    fun round_tick(arg0: u32, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg2: bool) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg0);
        let v1 = v0;
        if (arg2) {
            v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v0, arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::div(v1, arg1), arg1)
    }

    // decompiled from Move bytecode v6
}

