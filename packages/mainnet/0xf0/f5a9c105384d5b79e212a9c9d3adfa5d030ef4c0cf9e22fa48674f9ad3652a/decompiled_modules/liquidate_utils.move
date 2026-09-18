module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_utils {
    struct CurrentLiquidity has drop {
        debt_remaining: u128,
        debt: u128,
        col: u128,
        total_debt_liq: u128,
        total_col_liq: u128,
        tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        ratio: u128,
        tick_status: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::TickStatus,
        ref_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        ref_ratio: u128,
        ref_tick_status: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::RefTickStatus,
    }

    struct TickMemoryVars has drop {
        tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        partials: u128,
    }

    struct BranchState has copy, drop {
        minima_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        minima_tick_partials: u32,
        debt_liquidity: u64,
        debt_factor: u64,
        connected_branch_id: u64,
        connected_minima_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
    }

    struct BranchMemoryVars has drop {
        id: u64,
        data: BranchState,
        debt_factor: u64,
        minima_tick: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick,
        base_branch_data: BranchState,
    }

    public fun branch_debt_factor(arg0: &BranchMemoryVars) : u64 {
        arg0.debt_factor
    }

    public(friend) fun absorb_dust_amount_for_liquidate<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &mut CurrentLiquidity) {
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::absorbed_debt_amount<T0, T1>(arg0);
        let v1 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::absorbed_col_amount<T0, T1>(arg0);
        let v2 = arg1.debt_remaining;
        if (v0 > v2) {
            let v3 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v1, v2, v0);
            arg1.total_col_liq = v3;
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_absorbed_amounts<T0, T1>(arg0, v0 - v2, v1 - v3);
            arg1.total_debt_liq = v2;
            arg1.debt_remaining = 0;
        } else {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::reset_absorbed_amounts<T0, T1>(arg0);
            arg1.debt_remaining = v2 - v0;
            arg1.total_debt_liq = v0;
            arg1.total_col_liq = v1;
        };
    }

    public fun base_branch_data(arg0: &BranchMemoryVars) : BranchState {
        arg0.base_branch_data
    }

    public fun branch_data(arg0: &BranchMemoryVars) : BranchState {
        arg0.data
    }

    public fun branch_id(arg0: &BranchMemoryVars) : u64 {
        arg0.id
    }

    public fun branch_minima_tick(arg0: &BranchMemoryVars) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.minima_tick
    }

    public fun branch_state_connected_branch_id(arg0: &BranchState) : u64 {
        arg0.connected_branch_id
    }

    public fun branch_state_connected_minima_tick(arg0: &BranchState) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.connected_minima_tick
    }

    public fun branch_state_debt_factor(arg0: &BranchState) : u64 {
        arg0.debt_factor
    }

    public fun branch_state_debt_liquidity(arg0: &BranchState) : u64 {
        arg0.debt_liquidity
    }

    public fun branch_state_minima_tick(arg0: &BranchState) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.minima_tick
    }

    public fun branch_state_minima_tick_partials(arg0: &BranchState) : u32 {
        arg0.minima_tick_partials
    }

    fun branch_state_of(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::Branch) : BranchState {
        BranchState{
            minima_tick           : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::minima_tick(arg0),
            minima_tick_partials  : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::minima_tick_partials(arg0),
            debt_liquidity        : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::debt_liquidity(arg0),
            debt_factor           : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::branch_debt_factor(arg0),
            connected_branch_id   : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::connected_branch_id(arg0),
            connected_minima_tick : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::connected_minima_tick(arg0),
        }
    }

    public fun check_is_ref_partials_safe_for_tick(arg0: u128, arg1: u128) {
        let v0 = arg0 > 0 && arg0 >= arg1;
        assert!(!v0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_liquidation_reverts());
    }

    public fun col(arg0: &CurrentLiquidity) : u128 {
        arg0.col
    }

    public fun current_tick(arg0: &CurrentLiquidity) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.tick
    }

    public fun debt(arg0: &CurrentLiquidity) : u128 {
        arg0.debt
    }

    public fun debt_remaining(arg0: &CurrentLiquidity) : u128 {
        arg0.debt_remaining
    }

    fun default_branch_state() : BranchState {
        BranchState{
            minima_tick           : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick(),
            minima_tick_partials  : 0,
            debt_liquidity        : 0,
            debt_factor           : 0,
            connected_branch_id   : 0,
            connected_minima_tick : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick(),
        }
    }

    public(friend) fun end_liquidate(arg0: &mut CurrentLiquidity, arg1: &mut TickMemoryVars, arg2: &mut BranchMemoryVars, arg3: u128, arg4: u128, arg5: u128, arg6: u128) : (u128, u128) {
        let v0 = arg3;
        let v1 = arg4;
        if (arg3 >= arg0.debt_remaining) {
            let v2 = arg0.debt_remaining;
            v0 = v2;
            let v3 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision());
            v1 = v3;
            let v4 = get_final_ratio(arg0, v3, v2);
            let (v5, v6) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_tick_at_ratio(v4);
            if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::lt(v5, arg0.ref_tick) && arg1.partials == 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::x30()) {
                set_tick(arg1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::add_u32(v5, 2));
                set_partials(arg1, 1);
            } else {
                let v7 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::add_u32(v5, 1);
                let v8 = if (is_ref_tick_liquidated(arg0) && v7 == arg0.ref_tick) {
                    arg1.partials
                } else {
                    0
                };
                set_partials(arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_tick_partials(v6, v4));
                check_is_ref_partials_safe_for_tick(v8, arg1.partials);
                set_tick(arg1, v7);
            };
        } else {
            set_tick(arg1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::add_u32(arg0.ref_tick, 1));
            set_partials(arg1, 1);
        };
        let v9 = get_debt_factor(arg0, v0);
        update_totals(arg0, v0, v1);
        update_branch_debt_factor(arg2, v9);
        assert!(arg0.debt >= arg6, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_branch_debt_too_low());
        (v0, v1)
    }

    public(friend) fun get_actual_amounts(arg0: &CurrentLiquidity, arg1: u128, arg2: u128, arg3: u128, arg4: u64) : (u128, u128) {
        let v0 = get_normal_debt_liq(arg0, arg1);
        let v1 = v0;
        let v2 = get_normal_col_liq(arg0, arg2);
        let v3 = v2;
        if (v0 > arg3) {
            let v4 = v0 - arg3;
            if (v4 > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_liquidation_rounding_diff()) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_liquidation_rounding_diff(arg4, (v0 as u64), (arg3 as u64), (v4 as u64));
                abort 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_liquidation()
            };
            v3 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, arg3, v0);
            v1 = arg3;
        };
        assert!(v1 != 0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_liquidation());
        (v1, v3)
    }

    public fun get_col_from_ratios(arg0: &CurrentLiquidity, arg1: u128) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg1, arg0.ref_ratio, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio())
    }

    public fun get_current_ratio_from_minima_tick(arg0: &BranchMemoryVars) : u128 {
        let (v0, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::get_current_partials_ratio(arg0.data.minima_tick_partials, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_ratio_at_tick(arg0.minima_tick));
        v0
    }

    public fun get_debt_factor(arg0: &CurrentLiquidity, arg1: u128) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::two_power_64(), arg0.debt - arg1, arg0.debt)
    }

    public fun get_debt_from_ratios(arg0: &CurrentLiquidity) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0.ref_ratio, arg0.debt, arg0.ratio)
    }

    public fun get_debt_liquidated(arg0: &CurrentLiquidity, arg1: u128) : u128 {
        (arg0.debt - get_debt_from_ratios(arg0)) * 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision() / (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision() - get_col_from_ratios(arg0, arg1))
    }

    public fun get_final_ratio(arg0: &CurrentLiquidity, arg1: u128, arg2: u128) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0.debt - arg2, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), arg0.col - arg1)
    }

    fun get_normal_col_liq(arg0: &CurrentLiquidity, arg1: u128) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0.total_col_liq, arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::exchange_prices_precision())
    }

    fun get_normal_debt_liq(arg0: &CurrentLiquidity, arg1: u128) : u128 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil_u128(arg0.total_debt_liq, arg1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::exchange_prices_precision())
    }

    public(friend) fun get_ticks_from_oracle_price<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::view::PriceQuote, arg2: u128, arg3: u128) : (u128, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::oracle::get_exchange_rate_liquidate<T0, T1>(arg0, arg1);
        let v1 = v0 > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_oracle_price() || v0 == 0;
        assert!(!v1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_oracle_price());
        let v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v0, arg2, arg3);
        let v3 = v2;
        assert!(v2 != 0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_oracle_price());
        if (v2 > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_oracle_price_after_ex_price()) {
            v3 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_oracle_price_after_ex_price();
        };
        let v4 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::four_decimals();
        let v5 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::zero_tick_scaled_ratio(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision());
        let v6 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::three_decimals();
        let (v7, _) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_tick_at_ratio(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v5, (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) as u128), v6));
        let (v9, _) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::get_tick_at_ratio(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v5, (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_max_limit<T0, T1>(arg0) as u128), v6));
        (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::rate_output_precision_squared() / 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil_u128(v0, arg2, arg3), v4 + (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_penalty<T0, T1>(arg0) as u128), v4), v7, v9)
    }

    public fun is_liquidated_tick(arg0: &CurrentLiquidity) : bool {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_liquidated_tick_status(&arg0.tick_status)
    }

    public fun is_perfect_tick(arg0: &CurrentLiquidity) : bool {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_perfect_tick_status(&arg0.tick_status)
    }

    public fun is_ref_tick_liquidated(arg0: &CurrentLiquidity) : bool {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_ref_tick_liquidated(&arg0.ref_tick_status)
    }

    public fun is_ref_tick_liquidation_threshold(arg0: &CurrentLiquidity) : bool {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_ref_tick_liquidation_threshold(&arg0.ref_tick_status)
    }

    public fun is_ref_tick_perfect(arg0: &CurrentLiquidity) : bool {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::is_ref_tick_perfect(&arg0.ref_tick_status)
    }

    public(friend) fun mark_ref_tick_unliquidated(arg0: &mut TickMemoryVars) {
        arg0.partials = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::x30();
    }

    public(friend) fun new_branch_memory_vars() : BranchMemoryVars {
        BranchMemoryVars{
            id               : 0,
            data             : default_branch_state(),
            debt_factor      : 0,
            minima_tick      : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick(),
            base_branch_data : default_branch_state(),
        }
    }

    public(friend) fun new_current_liquidity() : CurrentLiquidity {
        CurrentLiquidity{
            debt_remaining  : 0,
            debt            : 0,
            col             : 0,
            total_debt_liq  : 0,
            total_col_liq   : 0,
            tick            : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick(),
            ratio           : 0,
            tick_status     : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::tick_status_perfect(),
            ref_tick        : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick(),
            ref_ratio       : 0,
            ref_tick_status : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::ref_tick_status_perfect(),
        }
    }

    public(friend) fun new_tick_memory_vars(arg0: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) : TickMemoryVars {
        TickMemoryVars{
            tick     : arg0,
            partials : 0,
        }
    }

    public fun ratio(arg0: &CurrentLiquidity) : u128 {
        arg0.ratio
    }

    public(friend) fun reduce_debt_remaining(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.debt_remaining = arg0.debt_remaining - arg1;
    }

    public fun ref_ratio(arg0: &CurrentLiquidity) : u128 {
        arg0.ref_ratio
    }

    public fun ref_tick(arg0: &CurrentLiquidity) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.ref_tick
    }

    public(friend) fun reset_branch_data(arg0: &mut BranchMemoryVars) {
        arg0.data = default_branch_state();
    }

    public(friend) fun set_base_branch_data(arg0: &mut BranchMemoryVars, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::Branch) {
        arg0.base_branch_data = branch_state_of(arg1);
    }

    public(friend) fun set_branch_data(arg0: &mut BranchMemoryVars, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::Branch) {
        arg0.data = branch_state_of(arg1);
    }

    public(friend) fun set_branch_data_in_memory(arg0: &mut BranchMemoryVars, arg1: u64, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::branch::Branch) {
        arg0.id = arg1;
        set_branch_data(arg0, arg2);
        arg0.debt_factor = arg0.data.debt_factor;
        if (arg0.debt_factor == 0) {
            arg0.debt_factor = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::initial_branch_debt_factor();
        };
        arg0.minima_tick = arg0.data.connected_minima_tick;
    }

    public(friend) fun set_branch_debt_factor(arg0: &mut BranchMemoryVars, arg1: u64) {
        arg0.debt_factor = arg1;
    }

    public(friend) fun set_branch_id(arg0: &mut BranchMemoryVars, arg1: u64) {
        arg0.id = arg1;
    }

    public(friend) fun set_branch_minima_tick(arg0: &mut BranchMemoryVars, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        arg0.minima_tick = arg1;
    }

    public(friend) fun set_col(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.col = arg1;
    }

    public(friend) fun set_current_tick(arg0: &mut CurrentLiquidity, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        arg0.tick = arg1;
    }

    public(friend) fun set_debt(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.debt = arg1;
    }

    public(friend) fun set_debt_remaining(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.debt_remaining = arg1;
    }

    public(friend) fun set_partials(arg0: &mut TickMemoryVars, arg1: u128) {
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::x30();
        let v1 = if (arg1 == 0) {
            1
        } else if (arg1 >= v0) {
            v0 - 1
        } else {
            arg1
        };
        arg0.partials = v1;
    }

    public(friend) fun set_ratio(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.ratio = arg1;
    }

    public(friend) fun set_ref_ratio(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.ref_ratio = arg1;
    }

    public(friend) fun set_ref_tick(arg0: &mut CurrentLiquidity, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        arg0.ref_tick = arg1;
    }

    public(friend) fun set_ref_tick_status(arg0: &mut CurrentLiquidity, arg1: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::RefTickStatus) {
        arg0.ref_tick_status = arg1;
    }

    public(friend) fun set_tick(arg0: &mut TickMemoryVars, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        arg0.tick = arg1;
    }

    public(friend) fun set_tick_status(arg0: &mut CurrentLiquidity, arg1: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::TickStatus) {
        arg0.tick_status = arg1;
    }

    public(friend) fun set_total_col_liq(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.total_col_liq = arg1;
    }

    public(friend) fun set_total_debt_liq(arg0: &mut CurrentLiquidity, arg1: u128) {
        arg0.total_debt_liq = arg1;
    }

    public fun tick_memory_partials(arg0: &TickMemoryVars) : u128 {
        arg0.partials
    }

    public fun tick_memory_tick(arg0: &TickMemoryVars) : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick {
        arg0.tick
    }

    public fun total_col_liq(arg0: &CurrentLiquidity) : u128 {
        arg0.total_col_liq
    }

    public fun total_debt_liq(arg0: &CurrentLiquidity) : u128 {
        arg0.total_debt_liq
    }

    public(friend) fun update_branch_debt_factor(arg0: &mut BranchMemoryVars, arg1: u128) {
        arg0.debt_factor = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::mul_div_big_number(arg0.debt_factor, arg1);
    }

    public(friend) fun update_branch_to_base_branch(arg0: &mut BranchMemoryVars) {
        arg0.id = arg0.data.connected_branch_id;
        arg0.data = arg0.base_branch_data;
        arg0.minima_tick = arg0.base_branch_data.connected_minima_tick;
    }

    public(friend) fun update_next_iterations_with_ref(arg0: &mut CurrentLiquidity) {
        arg0.tick = arg0.ref_tick;
        arg0.tick_status = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::tick::ref_tick_status_as_tick_status(&arg0.ref_tick_status);
        arg0.ratio = arg0.ref_ratio;
    }

    public(friend) fun update_totals(arg0: &mut CurrentLiquidity, arg1: u128, arg2: u128) {
        arg0.col = arg0.col - arg2;
        arg0.total_col_liq = arg0.total_col_liq + arg2;
        arg0.total_debt_liq = arg0.total_debt_liq + arg1;
        arg0.debt = arg0.debt - arg1;
    }

    // decompiled from Move bytecode v7
}

