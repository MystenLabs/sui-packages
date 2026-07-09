module 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::adl {
    struct AdlExecuted has copy, drop {
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        bankrupt_trader: address,
        counterparty: address,
        counterparty_direction: u8,
        deleveraged_size: u64,
        bankruptcy_price: u64,
        mark_price: u64,
        counterparty_realized_pnl: u64,
        counterparty_foregone_pnl: u64,
        deficit_absorbed: u64,
        timestamp_ms: u64,
    }

    struct AdlSummary has copy, drop {
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        bankrupt_trader: address,
        bankruptcy_price: u64,
        mark_price: u64,
        deficit: u64,
        deficit_absorbed: u64,
        bankrupt_size_before: u64,
        bankrupt_size_remaining: u64,
        counterparties_attempted: u64,
        counterparties_deleveraged: u64,
        skipped_wrong_side: u64,
        skipped_not_profitable: u64,
        skipped_pool_short: u64,
        skipped_other: u64,
        skipped_duplicate: u64,
        timestamp_ms: u64,
    }

    fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun adl_deleverage<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg7: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg8: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg9: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg10: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg11: &0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopRegistry, arg12: u8, arg13: &0x2::clock::Clock, arg14: vector<u8>, arg15: address, arg16: vector<address>) {
        assert!(0x1::vector::length<address>(&arg16) <= 50, 3);
        assert!(arg12 != 2, 42001);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg7);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::trade_validator::assert_trade_allowed(arg7, arg3, arg6, arg14, true);
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::get_market_id(arg2, arg14);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::assert_fresh_by_market(arg8, v0, arg13);
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg4, arg15, v0), 0);
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg4, arg15, v0);
        assert!(!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_locked_for_liquidation(v1), 4);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v1);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v1);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v1);
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v1);
        let v6 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_mark_price(arg8, v0);
        let (v7, v8, v9) = read_funding_indices(arg9, arg14);
        let v10 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_settlement::compute_accrued_funding_cost_v4(v2, v3, v6, v7, v8, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v1), v9, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v1));
        let v11 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::compute_margin_summary(v3, v4, v6, v2 == 0, v5, v10, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v12 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_account_equity(&v11);
        let v13 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_value(&v12);
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_is_negative(&v12), 1);
        assert!(vault_capacity_for<T0>(arg5, arg11, arg14, arg15) < v13, 5);
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::balance(arg10) < v13 && 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::insurance_pool_balance<T0>(arg5) < v13, 2);
        let v14 = compute_bankruptcy_price(v2, v4, v3, v5, v10);
        let v15 = 0x1::vector::length<address>(&arg16);
        let v16 = 0;
        let v17 = 0;
        let v18 = 0;
        let v19 = 0;
        let v20 = 0;
        let v21 = 0;
        let v22 = 0;
        let v23 = 0x1::vector::empty<address>();
        let v24 = 0;
        while (v24 < v15) {
            let v25 = *0x1::vector::borrow<address>(&arg16, v24);
            v24 = v24 + 1;
            if (0x1::vector::contains<address>(&v23, &v25)) {
                v21 = v21 + 1;
                continue
            };
            0x1::vector::push_back<address>(&mut v23, v25);
            let v26 = &mut v22;
            let v27 = try_deleverage_one<T0>(arg0, arg1, arg3, arg4, arg5, v0, arg14, arg15, v2, v14, v6, v25, arg13, v26);
            if (v27 == 0) {
                v16 = v16 + 1;
                continue
            };
            if (v27 == 2) {
                v17 = v17 + 1;
                continue
            };
            if (v27 == 3) {
                v18 = v18 + 1;
                continue
            };
            if (v27 == 5) {
                v19 = v19 + 1;
                continue
            };
            v20 = v20 + 1;
        };
        let v28 = if (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg4, arg15, v0)) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg4, arg15, v0))
        } else {
            0
        };
        let v29 = AdlSummary{
            market_id                  : v0,
            symbol                     : arg14,
            bankrupt_trader            : arg15,
            bankruptcy_price           : v14,
            mark_price                 : v6,
            deficit                    : v13,
            deficit_absorbed           : v22,
            bankrupt_size_before       : v3,
            bankrupt_size_remaining    : v28,
            counterparties_attempted   : v15,
            counterparties_deleveraged : v16,
            skipped_wrong_side         : v17,
            skipped_not_profitable     : v18,
            skipped_pool_short         : v19,
            skipped_other              : v20,
            skipped_duplicate          : v21,
            timestamp_ms               : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<AdlSummary>(v29);
    }

    fun close_collateral_slice(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun close_pnl(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : (u64, bool) {
        let v0 = arg0 == 0 && arg2 < arg1 || arg2 > arg1;
        (mul_div_price(arg3, abs_diff(arg2, arg1)), v0)
    }

    fun compute_bankruptcy_price(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let (v0, v1) = if (arg3 >= arg4) {
            (arg3 - arg4, false)
        } else {
            (arg4 - arg3, true)
        };
        let v2 = (v0 as u128) * 1000000000 / (arg2 as u128);
        let v3 = arg0 == 0 && v1 || !v1;
        let v4 = (arg1 as u128);
        if (v3) {
            let v6 = v4 + v2;
            let v7 = 18446744073709551615;
            if (v6 > v7) {
                (v7 as u64)
            } else {
                (v6 as u64)
            }
        } else if (v2 >= v4) {
            0
        } else {
            ((v4 - v2) as u64)
        }
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul_div_price(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    fun notional_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    fun read_funding_indices(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg1: vector<u8>) : (u128, bool, u128) {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::funding_state_exists(arg0, arg1)) {
            return (0, false, 0)
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::borrow_funding_state(arg0, arg1);
        (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index_is_negative(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_short_borrow_index(v0))
    }

    fun sub_market_oi(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: vector<u8>, arg4: u8, arg5: u64) {
        if (arg4 == 0) {
            let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_long_oi(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::borrow_market(arg2, arg3));
            let v1 = if (arg5 > v0) {
                0
            } else {
                v0 - arg5
            };
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::set_long_oi_authorized(arg0, arg1, arg2, arg3, v1);
        } else {
            let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_short_oi(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::borrow_market(arg2, arg3));
            let v3 = if (arg5 > v2) {
                0
            } else {
                v2 - arg5
            };
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::set_short_oi_authorized(arg0, arg1, arg2, arg3, v3);
        };
    }

    fun try_deleverage_one<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: address, arg8: u8, arg9: u64, arg10: u64, arg11: address, arg12: &0x2::clock::Clock, arg13: &mut u64) : u8 {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg3, arg7, arg5)) {
            return 6
        };
        if (arg11 == arg7) {
            return 2
        };
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg3, arg11, arg5)) {
            return 1
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg3, arg11, arg5);
        if (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_locked_for_liquidation(v0)) {
            return 4
        };
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v0);
        if (v1 == arg8) {
            return 2
        };
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v0);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v0);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v0);
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg3, arg7, arg5);
        let v6 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v5);
        let (v7, v8) = close_pnl(v1, v3, arg9, v2);
        if (v8 || v7 == 0) {
            return 3
        };
        let v9 = min_u64(v6, v2);
        let v10 = if (v9 == v6) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v5)
        } else {
            close_collateral_slice(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v5), v9, v6)
        };
        let (v11, v12) = close_pnl(v1, v3, arg9, v9);
        let v13 = if (v9 == v2) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v0)
        } else {
            close_collateral_slice(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v0), v9, v2)
        };
        let v14 = if (v12) {
            0
        } else {
            v11
        };
        if (v14 > 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::insurance_pool_balance<T0>(arg4) + v10) {
            return 5
        };
        let v15 = 0x2::clock::timestamp_ms(arg12);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::reduce_position_authorized<T0>(arg0, arg1, arg3, arg4, arg7, arg5, v9, 0, v10, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v5), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v5), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v5), v15);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::record_realized_pnl_debit_authorized<T0>(arg0, arg1, arg4, arg7, v10);
        sub_market_oi(arg0, arg1, arg2, arg6, arg8, notional_u64(v9, arg9));
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::reduce_position_authorized<T0>(arg0, arg1, arg3, arg4, arg11, arg5, v9, v13, 0, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v0), v4, v15);
        if (v14 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::credit_realized_pnl_from_insurance_authorized<T0>(arg0, arg1, arg4, arg11, v14, false);
        };
        sub_market_oi(arg0, arg1, arg2, arg6, v1, notional_u64(v9, arg9));
        let v16 = mul_div_price(v9, abs_diff(arg9, arg10));
        *arg13 = *arg13 + v16;
        let v17 = AdlExecuted{
            market_id                 : arg5,
            symbol                    : arg6,
            bankrupt_trader           : arg7,
            counterparty              : arg11,
            counterparty_direction    : v1,
            deleveraged_size          : v9,
            bankruptcy_price          : arg9,
            mark_price                : arg10,
            counterparty_realized_pnl : v14,
            counterparty_foregone_pnl : v16,
            deficit_absorbed          : v16,
            timestamp_ms              : v15,
        };
        0x2::event::emit<AdlExecuted>(v17);
        0
    }

    fun vault_capacity_for<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg1: &0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopRegistry, arg2: vector<u8>, arg3: address) : u64 {
        let v0 = 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::get_config(arg1, arg2);
        if (0x1::option::is_none<0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopConfig>(&v0)) {
            0x1::option::destroy_none<0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopConfig>(v0);
            return 0
        };
        let v1 = 0x1::option::destroy_some<0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopConfig>(v0);
        if (!0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_enabled(&v1) || 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_pause_absorptions(&v1)) {
            return 0
        };
        let v2 = 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_vault_account(&v1);
        if (v2 == arg3) {
            return 0
        };
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_available_balance<T0>(arg0, v2);
        min_u64((((v3 as u128) * (0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_capacity_cap_bps(&v1) as u128) / 10000) as u64), v3)
    }

    // decompiled from Move bytecode v7
}

