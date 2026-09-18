module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_logic {
    fun absorb<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) : (u128, u128) {
        let (v0, _, _, v3) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::engine_mut<T0, T1>(arg0);
        let (v4, v5, v6) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::fetch_next_tick_absorb(v3, v0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::add_u32(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::topmost_tick<T0, T1>(arg0), 1), arg1);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::new_branch_memory_vars();
        let v10 = 0;
        let v11 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::current_branch_id<T0, T1>(arg0);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_id(&mut v9, v11);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_data(&mut v9, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches<T0, T1>(arg0), v11));
        if (!0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::is_branch_liquidated<T0, T1>(arg0)) {
            v10 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v9);
            let v12 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v9);
            if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_minima_tick(&v12) != 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick()) {
                let v13 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v9);
                let v14 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_branch_id(&v13);
                let v15 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v9);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_id(&mut v9, v14);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_minima_tick(&mut v9, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_minima_tick(&v15));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_data(&mut v9, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches<T0, T1>(arg0), v14));
            } else {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_id(&mut v9, 0);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::reset_branch_data(&mut v9);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_minima_tick(&mut v9, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick());
            };
        } else {
            let v16 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v9);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_minima_tick(&mut v9, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_minima_tick(&v16));
        };
        while (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_minima_tick(&v9), arg1)) {
            let v17 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v9);
            let v18 = (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_debt_liquidity(&v17) as u128);
            v7 = v7 + v18;
            v8 = v8 + 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v18, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::get_current_ratio_from_minima_tick(&v9));
            let v19 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v9);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::set_state_after_absorb(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v9)), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_minima_tick(&v19), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_minima_tick_partials(&v19), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_debt_liquidity(&v19), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_debt_factor(&v19), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_branch_id(&v19), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_minima_tick(&v19));
            if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_minima_tick(&v19) != 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick()) {
                let v20 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_branch_id(&v19);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_id(&mut v9, v20);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_minima_tick(&mut v9, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_minima_tick(&v19));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_data(&mut v9, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches<T0, T1>(arg0), v20));
                continue
            };
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_id(&mut v9, 0);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::reset_branch_data(&mut v9);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_minima_tick(&mut v9, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick());
        };
        if (!0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::lt(v4, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_minima_tick(&v9))) {
            if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(v4, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick())) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_topmost_tick<T0, T1>(arg0, v4);
            } else {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::reset_top_tick<T0, T1>(arg0);
            };
            if (v10 == 0) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::update_branch_info_by_one<T0, T1>(arg0);
                v10 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::total_branch_id<T0, T1>(arg0);
            } else {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::reset_branch_liquidated<T0, T1>(arg0);
            };
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::ensure_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), v10);
            if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_minima_tick(&v9), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick())) {
                let v21 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), v10);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::reset_branch_data(v21);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::set_connections(v21, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v9), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_minima_tick(&v9));
            } else {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::reset_branch_data(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), v10));
            };
        } else {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::update_state_at_liq_end<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_minima_tick(&v9), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v9));
            if (v10 != 0) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_total_branch_id<T0, T1>(arg0, v10 - 1);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::reset_branch_data(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), v10));
            };
        };
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::add_absorbed_col_amount<T0, T1>(arg0, v8);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::add_absorbed_debt_amount<T0, T1>(arg0, v7);
        (v8, v7)
    }

    public(friend) fun liquidate<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::view::PriceQuote, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg2);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::assert_caps_installed<T0, T1>(arg1);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::assert_liquidity_program<T0, T1>(arg1, arg0);
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::debt_decimals<T0, T1>(arg1);
        let v1 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::col_decimals<T0, T1>(arg1);
        let v2 = if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::topmost_tick<T0, T1>(arg1) == 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick()) {
            let v3 = arg9 && (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::absorbed_debt_amount<T0, T1>(arg1) > 0 || 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::absorbed_col_amount<T0, T1>(arg1) > 0);
            !v3
        } else {
            false
        };
        assert!(!v2, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_top_tick_does_not_exist());
        let v4 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::scale_amounts((arg7 as u128), v0);
        let (v5, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T0>(arg3, arg10);
        let (_, v8) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T1>(arg4, arg10);
        let (_, _, v11, v12) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::load_exchange_prices<T0, T1>(arg1, v5, v8, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg10));
        let v13 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::new_current_liquidity();
        let (v14, v15, v16) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::get_ticks_from_oracle_price<T0, T1>(arg1, arg5, v11, v12);
        let v17 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::topmost_tick<T0, T1>(arg1);
        if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::topmost_tick<T0, T1>(arg1), v16)) {
            let (v18, v19) = absorb<T0, T1>(arg1, v16);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_absorb((0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::unscale_amounts(v18, v1) as u64), (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::unscale_amounts(v19, v0) as u64));
            if (v4 == 0) {
                0x2::balance::destroy_zero<T1>(arg6);
                return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
            };
        };
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_current_tick(&mut v13, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::topmost_tick<T0, T1>(arg1));
        assert!(v4 >= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::get_minimum_debt(v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_liquidation_amt());
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_tick_status(&mut v13, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::get_tick_status<T0, T1>(arg1));
        let v20 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::new_tick_memory_vars(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::current_tick(&v13));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_debt_remaining(&mut v13, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v4, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::exchange_prices_precision(), v12));
        assert!(!(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::get_total_borrow<T0, T1>(arg1) / 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::billion() > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::debt_remaining(&v13)), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_liquidation_amt());
        if (arg9) {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::absorb_dust_amount_for_liquidate<T0, T1>(arg1, &mut v13);
        };
        if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::current_tick(&v13), v15) && 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::debt_remaining(&v13) > 0) {
            let v21 = &mut v13;
            let v22 = &mut v20;
            liquidation_loop<T0, T1>(arg1, v21, v22, v14, v15, v0);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_liquidate_info(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_id<T0, T1>(arg1), v17, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::topmost_tick<T0, T1>(arg1));
        };
        let (v23, v24) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::get_actual_amounts(&v13, v12, v11, v4, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_id<T0, T1>(arg1));
        let v25 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::unscale_amounts_up(v23, v0);
        let v26 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::unscale_amounts(v24, v1);
        assert!(!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v26, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision(), v25) < arg8), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_excess_slippage_liquidation());
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::reduce_total_supply<T0, T1>(arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::total_col_liq(&v13));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::reduce_total_borrow<T0, T1>(arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::total_debt_liq(&v13));
        0x2::balance::destroy_zero<T1>(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::borrow<T0, T1>(arg0, arg1, arg4, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::negative((v25 as u64)), 0x2::balance::split<T1>(&mut arg6, (v25 as u64)), arg10, arg11));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_liquidate(0x2::tx_context::sender(arg11), (v26 as u64), (v25 as u64), 0x2::tx_context::sender(arg11));
        (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::supply<T0, T1>(arg0, arg1, arg3, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::negative((v26 as u64)), 0x2::balance::zero<T0>(), arg10, arg11), arg6)
    }

    fun liquidation_loop<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::CurrentLiquidity, arg2: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::TickMemoryVars, arg3: u128, arg4: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, arg5: u8) {
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::new_branch_memory_vars();
        let v1 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::current_branch_id<T0, T1>(arg0);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_data_in_memory(&mut v0, v1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches<T0, T1>(arg0), v1));
        let v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick();
        if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_perfect_tick(arg1)) {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_ratio(arg1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_ratio_at_tick(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::tick_memory_tick(arg2)));
            v2 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::current_tick(arg1);
        } else {
            let v3 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v0);
            let (v4, v5) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_current_partials_ratio(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_minima_tick_partials(&v3), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_ratio_at_tick(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::tick_memory_tick(arg2)));
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_ratio(arg1, v4);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_partials(arg2, v5);
            let v6 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::add_u32(arg4, 1) == 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::tick_memory_tick(arg2) && 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::tick_memory_partials(arg2) == 1;
            assert!(!v6, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_liquidation());
        };
        let v7 = true;
        let v8;
        let v9;
        loop {
            let v10 = if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_perfect_tick(arg1)) {
                let v11 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::load_tick_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::ticks_mut<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::current_tick(arg1));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::set_liquidated(v11, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_debt_factor(&v0));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_raw_debt(v11)
            } else {
                let v12 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v0);
                (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_debt_liquidity(&v12) as u128)
            };
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_debt(arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::debt(arg1) + v10);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_col(arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::col(arg1) + 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v10, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::ratio(arg1)));
            if (v2 == 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::current_tick(arg1) && 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_perfect_tick(arg1) || v7) {
                v7 = false;
                v2 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::fetch_next_tick_liquidate(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::tick_bitmap_mut<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::current_tick(arg1), arg4, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_perfect_tick(arg1));
            };
            let (v13, v14) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_next_ref_tick(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_minima_tick(&v0), v2, arg4);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_ref_tick(arg1, v13);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_ref_tick_status(arg1, v14);
            if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_ref_tick_liquidated(arg1)) {
                let v15 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_data(&v0);
                let v16 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_connected_branch_id(&v15));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_base_branch_data(&mut v0, v16);
                let (v17, v18) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_current_partials_ratio(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::minima_tick_partials(v16), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_ratio_at_tick(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::ref_tick(arg1)));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_ref_ratio(arg1, v17);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_partials(arg2, v18);
            } else {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_ref_ratio(arg1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_ratio_at_tick(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::ref_tick(arg1)));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::mark_ref_tick_unliquidated(arg2);
            };
            let v19 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::get_debt_liquidated(arg1, arg3);
            v9 = v19;
            if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::debt(arg1) == v19) {
                v9 = v19 - 1;
            };
            v8 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v9, arg3, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision());
            if (v9 >= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::debt_remaining(arg1) || 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_ref_tick_liquidation_threshold(arg1)) {
                break
            };
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::reduce_debt_remaining(arg1, v9);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::update_totals(arg1, v9, v8);
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::update_branch_debt_factor(&mut v0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::get_debt_factor(arg1, v9));
            if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::is_ref_tick_liquidated(arg1)) {
                let v20 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::base_branch_data(&v0);
                let v21 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_state_debt_factor(&v20);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::merge_with_base_branch(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v0)), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::div_big_number(v21, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_debt_factor(&v0)));
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::set_branch_debt_factor(&mut v0, v21);
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::update_branch_to_base_branch(&mut v0);
            };
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::update_next_iterations_with_ref(arg1);
        };
        let (_, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::end_liquidate(arg1, arg2, &mut v0, v9, v8, arg3, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::get_minimum_branch_debt(arg5));
        let v24 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_id(&v0);
        let v25 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::tick_memory_tick(arg2);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::update_state_at_liq_end(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch_mut(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::branches_mut<T0, T1>(arg0), v24), v25, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::tick_memory_partials(arg2), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::debt(arg1), (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils::branch_debt_factor(&v0) as u128));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::update_state_at_liq_end<T0, T1>(arg0, v25, v24);
    }

    // decompiled from Move bytecode v7
}

