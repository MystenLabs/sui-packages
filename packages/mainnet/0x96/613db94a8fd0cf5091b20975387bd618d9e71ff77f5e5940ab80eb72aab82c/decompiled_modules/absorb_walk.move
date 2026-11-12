module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::absorb_walk {
    fun absorb_branches<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, arg2: &mut u64) : (u128, u128, bool) {
        let v0 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::branches<T0, T1>(arg0);
        let v1 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::current_branch_id<T0, T1>(arg0);
        let v2 = if (!0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::is_branch_liquidated<T0, T1>(arg0)) {
            if (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_minima_tick(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v0, v1)) != 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()) {
                0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_branch_id(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v0, v1))
            } else {
                0
            }
        } else {
            v1
        };
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        loop {
            if (v3 == 0) {
                return (v4, v5, false)
            };
            let v6 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::minima_tick(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v0, v3));
            if (!0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v6, arg1)) {
                return (v4, v5, false)
            };
            if (*arg2 == 0) {
                break
            };
            *arg2 = *arg2 - 1;
            let v7 = 0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v0, v3);
            let (v8, _) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::get_current_partials_ratio(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::minima_tick_partials(v7), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_ratio_at_tick(v6));
            let v10 = (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::debt_liquidity(v7) as u128);
            v5 = v5 + v10;
            v4 = v4 + 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v10, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::zero_tick_scaled_ratio(), v8);
            let v11 = if (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_minima_tick(v7) != 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()) {
                0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_branch_id(v7)
            } else {
                0
            };
            v3 = v11;
        };
        (v4, v5, true)
    }

    fun absorb_ticks<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, arg2: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, arg3: &mut u64) : (u128, u128, bool) {
        let v0 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::tick_bitmap<T0, T1>(arg0);
        let v1 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::ticks<T0, T1>(arg0);
        let v2 = if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(arg1, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::max_tick())) {
            0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::max_tick()
        } else {
            arg1
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::bitmap::scan_down_from(v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::word_of(v2), 0x1::option::none<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>());
        loop {
            if (v5 == 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()) {
                return (v3, v4, false)
            };
            if (!0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v5, arg2)) {
                return (v3, v4, false)
            };
            if (*arg3 == 0) {
                break
            };
            *arg3 = *arg3 - 1;
            let v6 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::get_raw_debt(0x2::table::borrow<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::Tick>(v1, v5));
            v4 = v4 + v6;
            v3 = v3 + 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v6, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::zero_tick_scaled_ratio(), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_ratio_at_tick(v5));
            v5 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::bitmap::scan_down_excluding(v0, v5, 0x1::option::none<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>());
        };
        (v3, v4, true)
    }

    public(friend) fun simulate_absorb<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick) : (u128, u128, bool) {
        let v0 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::max_absorb_iterations();
        let v1 = &mut v0;
        let (v2, v3, v4) = absorb_ticks<T0, T1>(arg0, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::add_u32(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::topmost_tick<T0, T1>(arg0), 1), arg1, v1);
        let v5 = &mut v0;
        let (v6, v7, v8) = absorb_branches<T0, T1>(arg0, arg1, v5);
        let v9 = v4 || v8;
        (v2 + v6, v3 + v7, v9)
    }

    // decompiled from Move bytecode v7
}

