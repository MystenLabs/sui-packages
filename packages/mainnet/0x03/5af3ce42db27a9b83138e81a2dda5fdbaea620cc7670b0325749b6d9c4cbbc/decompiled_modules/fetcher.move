module 0x35af3ce42db27a9b83138e81a2dda5fdbaea620cc7670b0325749b6d9c4cbbc::fetcher {
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
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg1);
        let v1 = 0x1::vector::empty<TickInfo>();
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        while (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg2))) {
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::is_initialized(v2, v0)) {
                let (v3, v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_fee_and_reward_growths_outside(v2, v0);
                let v6 = TickInfo{
                    index                          : v0,
                    liquidity_gross                : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v2, v0),
                    liquidity_net                  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v2, v0),
                    fee_growth_outside_x           : v3,
                    fee_growth_outside_y           : v4,
                    reward_growths_outside         : v5,
                    tick_cumulative_out_side       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_tick_cumulative_out_side(v2, v0),
                    seconds_per_liquidity_out_side : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_seconds_per_liquidity_out_side(v2, v0),
                    seconds_out_side               : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_seconds_out_side(v2, v0),
                };
                0x1::vector::push_back<TickInfo>(&mut v1, v6);
            };
            v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0)));
        };
        v1
    }

    // decompiled from Move bytecode v6
}

