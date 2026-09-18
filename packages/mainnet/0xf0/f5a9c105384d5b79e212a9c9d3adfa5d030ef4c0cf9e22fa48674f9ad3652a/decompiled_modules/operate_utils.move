module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::operate_utils {
    struct OldState has drop {
        old_col_raw: u128,
        old_net_debt_raw: u128,
        old_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
    }

    struct OperateMemoryVars has drop {
        col_raw: u128,
        debt_raw: u128,
        dust_debt_raw: u128,
        tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        tick_id: u32,
    }

    public(friend) fun add_debt_to_tick(arg0: &mut 0x2::table::Table<0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::Tick>, arg1: &mut 0x2::table::Table<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::TickIdLiquidationKey, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::TickIdLiquidation>, arg2: &mut 0x2::table::Table<u16, u256>, arg3: u128, arg4: u128, arg5: u128) : (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, u32, u128, u128) {
        assert!(arg4 >= arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_user_debt_too_low());
        let (v0, v1, v2) = compute_placement(arg4, arg3);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::ensure_tick(arg0, v0);
        let v3 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::load_tick(arg0, v0);
        let v4 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::total_ids(v3);
        let v5 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_raw_debt(v3);
        let v6 = v4;
        let v7 = if (v4 > 0 && !0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_liquidated(v3)) {
            if (v5 == 0) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::update_tick_has_debt(arg2, v0, true);
            };
            v5 + v1
        } else {
            if (v4 > 0) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::set_tick_status(arg1, v0, v4, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_fully_liquidated(v3), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::liquidation_branch_id(v3), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::debt_factor(v3));
            };
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::update_tick_has_debt(arg2, v0, true);
            let v8 = v4 + 1;
            v6 = v8;
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::set_total_ids(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::load_tick_mut(arg0, v0), v8);
            v1
        };
        assert!(v7 >= arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_tick_debt_too_low());
        let v9 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::load_tick_mut(arg0, v0);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::reset_liquidation_data(v9);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::set_raw_debt(v9, v7);
        (v0, v6, v1, v2)
    }

    public(friend) fun check_if_position_safe<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::view::PriceQuote, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, arg3: u128, arg4: u128, arg5: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::ScaledAmount, arg6: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::ScaledAmount) {
        let (v0, v1) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::oracle::get_both_exchange_rate<T0, T1>(arg0, arg1);
        let (v2, v3, v4) = if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::get_scaled_is_negative(arg5) || 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::get_scaled_is_positive(arg6)) {
            (v1, (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::collateral_factor<T0, T1>(arg0) as u128), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_position_above_cf())
        } else {
            (v0, (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) as u128), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_position_above_liquidation_threshold())
        };
        let (v5, _) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_tick_at_ratio(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(get_sanitized_exchange_rate(v2, arg3, arg4) * v3 / 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::three_decimals(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision()));
        assert!(!0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(arg2, v5), v4);
    }

    public fun check_if_ratio_safe_for_deposit(arg0: &OperateMemoryVars, arg1: &OldState, arg2: u128) {
        assert!(!(get_new_ratio(arg0, arg2) > get_old_ratio(arg1)), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_payback_or_deposit());
    }

    public fun check_if_withdrawal_safe_for_withdrawal_gap(arg0: u16, arg1: u128, arg2: u128, arg3: u128, arg4: u128) {
        if (arg0 == 0) {
            return
        };
        if (arg3 == 0) {
            return
        };
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::three_decimals();
        let v1 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg4, v0 - (arg0 as u128), v0);
        let v2 = if (v1 > arg3) {
            v1 - arg3
        } else {
            0
        };
        assert!(v2 >= 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::exchange_prices_precision(), arg2), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_withdraw_more_than_operate_limit());
    }

    public fun check_operate_amount(arg0: bool, arg1: bool, arg2: u64, arg3: u8) {
        if (arg0 || arg1) {
            return
        };
        let v0 = if (arg3 >= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::lower_decimals_operate()) {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::min_operate()
        } else {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::min_operate_lower_decimals_amount()
        };
        let v1 = arg2 < v0 || arg2 > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_operate();
        assert!(!v1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_operate_amount());
    }

    public fun col_raw(arg0: &OperateMemoryVars) : u128 {
        arg0.col_raw
    }

    public fun compute_placement(arg0: u128, arg1: u128) : (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, u128, u128) {
        let (v0, v1) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_tick_at_ratio(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), arg1));
        let v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::add_u32(v0, 1);
        assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::is_in_bounds(v2), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_tick_has_debt_out_of_range());
        let v3 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::tick_spacing(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::four_decimals()) * arg1 >> 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::shift();
        (v2, v3, v3 - arg0)
    }

    public fun debt_raw(arg0: &OperateMemoryVars) : u128 {
        arg0.debt_raw
    }

    public fun dust_debt_raw(arg0: &OperateMemoryVars) : u128 {
        arg0.dust_debt_raw
    }

    public(friend) fun fetch_latest_position(arg0: &mut OperateMemoryVars, arg1: &0x2::table::Table<0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::Tick>, arg2: &0x2::table::Table<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::TickIdLiquidationKey, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::TickIdLiquidation>, arg3: &0x2::table::Table<u64, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::Branch>) : u64 {
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::load_tick(arg1, arg0.tick);
        let (v1, v2, v3) = if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::total_ids(v0) == arg0.tick_id) {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_tick_status(v0)
        } else {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_tick_status_at_id(arg2, arg0.tick, arg0.tick_id)
        };
        let v4 = v2;
        let v5 = arg0.debt_raw;
        let v6 = 0;
        let v7 = if (v1) {
            arg0.tick = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick();
            0
        } else {
            let v8 = v3;
            let v9 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(arg3, v2);
            while (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::is_merged(v9)) {
                let v10 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::mul_big_number(v8, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::branch_debt_factor(v9));
                v8 = v10;
                if (v10 == 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::max_mask_debt_factor()) {
                    break
                };
                let v11 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::connected_branch_id(v9);
                v4 = v11;
                v9 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(arg3, v11);
            };
            if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::is_closed(v9) || v8 == 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::max_mask_debt_factor()) {
                arg0.tick = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick();
                0
            } else {
                let v12 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::load_branch(arg3, v4);
                let v13 = (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::mul_div_normal((v5 as u64), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::branch_debt_factor(v12), v8) as u128);
                let v7 = if (v13 > v5 / 100) {
                    let v14 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::four_decimals();
                    0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v13, v14 - 1, v14)
                } else {
                    0
                };
                if (v7 > 0) {
                    arg0.tick = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::minima_tick(v12);
                    let v15 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_ratio_at_tick(arg0.tick);
                    let v16 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v15, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::four_decimals(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::tick_spacing());
                    v6 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v7, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), v16 + 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v15 - v16, (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::minima_tick_partials(v12) as u128), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::x30()));
                } else {
                    arg0.tick = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick();
                };
                v7
            }
        };
        arg0.debt_raw = v7;
        arg0.col_raw = v6;
        v4
    }

    public fun get_net_debt_raw(arg0: &OperateMemoryVars) : u128 {
        arg0.debt_raw - arg0.dust_debt_raw
    }

    public fun get_new_ratio(arg0: &OperateMemoryVars, arg1: u128) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), arg0.col_raw)
    }

    public fun get_old_ratio(arg0: &OldState) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0.old_net_debt_raw, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), arg0.old_col_raw)
    }

    public fun get_sanitized_exchange_rate(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 <= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_oracle_price() && arg0 >= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::min_oracle_price(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_oracle_price());
        let v0 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0, arg1, arg2);
        let v1 = v0;
        assert!(v0 != 0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_oracle_price());
        if (v0 > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_oracle_price_after_ex_price()) {
            v1 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_oracle_price_after_ex_price();
        };
        v1
    }

    public fun get_scaled_debt(arg0: &OperateMemoryVars) : u128 {
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::billion();
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0.debt_raw, v0 + 1, v0) + 1
    }

    public fun memory_tick(arg0: &OperateMemoryVars) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.tick
    }

    public fun memory_tick_id(arg0: &OperateMemoryVars) : u32 {
        arg0.tick_id
    }

    public(friend) fun new_old_state(arg0: u128, arg1: u128, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) : OldState {
        OldState{
            old_col_raw      : arg0,
            old_net_debt_raw : arg1,
            old_tick         : arg2,
        }
    }

    public(friend) fun new_operate_memory_vars(arg0: u128, arg1: u128, arg2: u128, arg3: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, arg4: u32) : OperateMemoryVars {
        OperateMemoryVars{
            col_raw       : arg0,
            debt_raw      : arg1,
            dust_debt_raw : arg2,
            tick          : arg3,
            tick_id       : arg4,
        }
    }

    public fun old_col_raw(arg0: &OldState) : u128 {
        arg0.old_col_raw
    }

    public fun old_net_debt_raw(arg0: &OldState) : u128 {
        arg0.old_net_debt_raw
    }

    public fun old_tick(arg0: &OldState) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.old_tick
    }

    public(friend) fun set_col_raw(arg0: &mut OperateMemoryVars, arg1: u128) {
        arg0.col_raw = arg1;
    }

    public(friend) fun set_debt_raw(arg0: &mut OperateMemoryVars, arg1: u128) {
        arg0.debt_raw = arg1;
    }

    public(friend) fun set_dust_debt_raw(arg0: &mut OperateMemoryVars, arg1: u128) {
        arg0.dust_debt_raw = arg1;
    }

    public(friend) fun set_memory_tick(arg0: &mut OperateMemoryVars, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        arg0.tick = arg1;
    }

    public(friend) fun set_memory_tick_id(arg0: &mut OperateMemoryVars, arg1: u32) {
        arg0.tick_id = arg1;
    }

    // decompiled from Move bytecode v7
}

