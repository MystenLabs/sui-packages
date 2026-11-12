module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::liquidate_walk {
    fun absorb_dust(arg0: u128, arg1: u128, arg2: u128) : (u128, u128, u128) {
        if (arg1 > arg0) {
            (0, arg0, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(arg2, arg0, arg1))
        } else {
            (arg0 - arg1, arg1, arg2)
        }
    }

    fun initial_branch_debt_factor() : u64 {
        0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::big_number::create_big_number(34359738367, 16384)
    }

    public(friend) fun run<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: u128, arg2: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, arg3: u128, arg4: u128, arg5: u128) : (u128, u128) {
        let (v0, v1, v2) = absorb_dust(arg3, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::topmost_tick<T0, T1>(arg0);
        let v7 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v6, arg2) && v0 > 0;
        if (!v7) {
            return (v1, v2)
        };
        let v8 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::tick_bitmap<T0, T1>(arg0);
        let v9 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::ticks<T0, T1>(arg0);
        let v10 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::branches<T0, T1>(arg0);
        let v11 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::current_branch_id<T0, T1>(arg0);
        let v12 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_branch_id(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v11));
        let v13 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_minima_tick(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v11));
        let v14 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::debt_liquidity(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v11));
        let v15 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::branch_debt_factor(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v11));
        let v16 = if (v15 == 0) {
            initial_branch_debt_factor()
        } else {
            v15
        };
        let v17 = v16;
        let v18 = v6;
        let v19 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::is_branch_liquidated<T0, T1>(arg0);
        let v20 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick();
        let v21 = if (!v19) {
            v20 = v6;
            0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_ratio_at_tick(v6)
        } else {
            let (v22, _) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::get_current_partials_ratio(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::minima_tick_partials(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v11)), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_ratio_at_tick(v6));
            v22
        };
        let v24 = 0;
        let v25 = 0;
        let v26 = true;
        let v27;
        let v28;
        loop {
            let v29 = if (!v19) {
                0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::get_raw_debt(0x2::table::borrow<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::Tick>(v9, v18))
            } else {
                (v14 as u128)
            };
            let v30 = v24 + v29;
            let v31 = v25 + 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v29, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::zero_tick_scaled_ratio(), v21);
            if (v20 == v18 && !v19 || v26) {
                v26 = false;
                let v32 = if (!v19) {
                    0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::bitmap::scan_down_excluding(v8, v18, 0x1::option::some<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>(arg2))
                } else {
                    0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::bitmap::scan_down_from(v8, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::word_of(v18), 0x1::option::some<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>(arg2))
                };
                v20 = v32;
            };
            let (v33, v34) = if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v13, v20) && 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v13, arg2)) {
                let v33 = v13;
                (v33, 1)
            } else if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v20, arg2)) {
                (v20, 0)
            } else {
                (arg2, 2)
            };
            let v35 = if (v34 == 1) {
                let (v36, _) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::get_current_partials_ratio(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::minima_tick_partials(0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v12)), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_ratio_at_tick(v33));
                v36
            } else {
                0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_ratio_at_tick(v33)
            };
            let v38 = if (v35 == v21 + 1) {
                0
            } else {
                let v39 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v35, v30, v21);
                let v40 = if (v39 < v30) {
                    0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128((((v35 as u256) * (v30 as u256) % (v21 as u256)) as u128), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision(), v21)
                } else {
                    0
                };
                0x1::u128::div_ceil((v30 - v39) * 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision() - v40, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision() - 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(arg1, v35, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::zero_tick_scaled_ratio()))
            };
            v27 = v38;
            if (v30 == v38) {
                v27 = v38 - 1;
            };
            v28 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v27, arg1, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision());
            if (v27 >= v5 || v34 == 2) {
                break
            };
            v5 = v5 - v27;
            v4 = v4 + v27;
            v3 = v3 + v28;
            v25 = v31 - v28;
            v24 = v30 - v27;
            v17 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::big_number::mul_div_big_number(v17, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::big_number::two_power_64(), v30 - v27, v30));
            if (v34 == 1) {
                let v41 = 0x2::table::borrow<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>(v10, v12);
                v17 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::branch_debt_factor(v41);
                v12 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_branch_id(v41);
                v13 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_minima_tick(v41);
                v14 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::debt_liquidity(v41);
            };
            v18 = v33;
            v19 = v34 == 1;
            v21 = v35;
        };
        let (v42, v43) = if (v27 >= v5) {
            (v5, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v5, arg1, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision()))
        } else {
            (v27, v28)
        };
        (v4 + v42, v3 + v43)
    }

    // decompiled from Move bytecode v7
}

