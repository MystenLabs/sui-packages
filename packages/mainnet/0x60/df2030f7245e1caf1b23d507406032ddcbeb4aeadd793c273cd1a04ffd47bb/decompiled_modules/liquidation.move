module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::liquidation {
    struct LiquidationDryRunResult has copy, drop {
        found: bool,
        liquidatable: bool,
        health_factor: u128,
        realized_pnl_usd: 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::SignedValue,
        collateral_slashed: u64,
        insurance_fund_debit: u64,
        liquidator_fee: u64,
        insurance_insufficient: bool,
        error_code: u64,
    }

    struct PositionLiquidated has copy, drop {
        trader: address,
        symbol: vector<u8>,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        mark_price: u64,
        entry_price: u64,
        collateral: u64,
        notional_value: u64,
        unrealized_pnl_value: u64,
        unrealized_pnl_is_negative: bool,
        realized_pnl_value: u64,
        realized_pnl_is_negative: bool,
        maintenance_margin_required: u64,
        account_equity_value: u64,
        account_equity_is_negative: bool,
        liquidation_fee: u64,
        remaining_collateral: u64,
        deficit_amount: u64,
        insurance_fund_covered: u64,
        timestamp_ms: u64,
    }

    struct LiquidationFeeAccrued has copy, drop {
        trader: address,
        market_id: 0x2::object::ID,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    fun compute_health_factor(arg0: u64, arg1: u64, arg2: bool) : u128 {
        if (arg2 || arg0 == 0) {
            return 0
        };
        (arg1 as u128) * 1000000000 / (arg0 as u128)
    }

    public fun compute_liquidation_fee(arg0: u64) : u64 {
        (((arg0 as u128) * (50 as u128) / 10000) as u64)
    }

    public fun compute_liquidation_outcome<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg2: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock) : LiquidationDryRunResult {
        if (!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::has_position(arg0, arg3, arg4)) {
            return LiquidationDryRunResult{
                found                  : false,
                liquidatable           : false,
                health_factor          : 0,
                realized_pnl_usd       : 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_unrealized_pnl(0, 0, 0, true),
                collateral_slashed     : 0,
                insurance_fund_debit   : 0,
                liquidator_fee         : 0,
                insurance_insufficient : false,
                error_code             : 0,
            }
        };
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::get_position(arg0, arg3, arg4);
        let v1 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_collateral(v0);
        let v2 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_margin_summary(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_size(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_entry_price(v0), arg5, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_direction(v0) == 0, v1, 0, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_initial_margin_ratio_bps_at_open(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_maintenance_margin_ratio_bps_at_open(v0));
        let v3 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_account_equity(&v2);
        let v4 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v3);
        let v5 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v3);
        if (!!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_meets_maintenance_margin(&v2)) {
            return LiquidationDryRunResult{
                found                  : true,
                liquidatable           : false,
                health_factor          : compute_health_factor(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_maintenance_margin_required(&v2), v4, v5),
                realized_pnl_usd       : 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_unrealized_pnl(&v2),
                collateral_slashed     : 0,
                insurance_fund_debit   : 0,
                liquidator_fee         : 0,
                insurance_insufficient : false,
                error_code             : 1,
            }
        };
        let v6 = compute_liquidation_fee(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_notional_value(&v2));
        let (v7, v8) = compute_liquidation_waterfall(v4, v5, v6);
        let v9 = min_u64(v8, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::balance(arg2));
        LiquidationDryRunResult{
            found                  : true,
            liquidatable           : true,
            health_factor          : compute_health_factor(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_maintenance_margin_required(&v2), v4, v5),
            realized_pnl_usd       : 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_unrealized_pnl(&v2),
            collateral_slashed     : min_u64(v1 - v7, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::get_locked_balance<T0>(arg1, arg3)),
            insurance_fund_debit   : v9,
            liquidator_fee         : v6,
            insurance_insufficient : v9 < v8,
            error_code             : 0,
        }
    }

    fun compute_liquidation_waterfall(arg0: u64, arg1: bool, arg2: u64) : (u64, u64) {
        if (arg1) {
            return (0, arg0 + arg2)
        };
        if (arg0 >= arg2) {
            (arg0 - arg2, 0)
        } else {
            (0, arg2 - arg0)
        }
    }

    public fun is_liquidatable(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg2: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg3: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg4: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: address) : bool {
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::get_market_id(arg0, arg6);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::assert_fresh_by_market(arg3, v0, arg5);
        if (!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::has_position(arg1, arg7, v0)) {
            return false
        };
        let v1 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::get_position(arg1, arg7, v0);
        let v2 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_size(v1);
        let v3 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_direction(v1);
        let v4 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::get_mark_price(arg3, v0);
        let (v5, v6, v7) = read_funding_indices(arg4, arg6);
        let (v8, _, _, _) = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_settlement::compute_settlement(v3, v2, v4, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_collateral(v1), v5, v6, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot_is_negative(v1), v7, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_short_borrow_index_snapshot(v1));
        let v12 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_margin_summary(v2, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_entry_price(v1), v4, v3 == 0, v8, 0, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v13 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_account_equity(&v12);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v13) || 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v13) < 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_maintenance_margin_required(&v12)
    }

    public fun liquidate_position<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg2: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg3: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg4: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg5: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg6: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg7: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg8: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg9: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::FeeCollector, arg10: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg11: u8, arg12: &0x2::clock::Clock, arg13: vector<u8>, arg14: address) {
        assert!(arg11 != 2, 42001);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::assert_not_paused(arg6);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::trade_validator::assert_trade_allowed(arg6, arg2, arg5, arg13, true);
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::get_market_id(arg1, arg13);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::assert_fresh_by_market(arg7, v0, arg12);
        assert!(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::has_position(arg3, arg14, v0), 0);
        assert!(!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_locked_for_liquidation(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::get_position(arg3, arg14, v0)), 3);
        let v1 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::get_position(arg3, arg14, v0);
        let v2 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_size(v1);
        let v3 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_direction(v1);
        let v4 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_entry_price(v1);
        let v5 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_collateral(v1);
        let v6 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::get_mark_price(arg7, v0);
        let (v7, v8, v9) = read_funding_indices(arg8, arg13);
        let (v10, _, _, _) = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_settlement::compute_settlement(v3, v2, v6, v5, v7, v8, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot_is_negative(v1), v9, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_short_borrow_index_snapshot(v1));
        if (v10 < v5) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::slash_locked<T0>(arg4, arg14, v5 - v10);
        };
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::update_position(arg3, arg14, v0, v2, v4, v10, v7, v8, v9, 0x2::clock::timestamp_ms(arg12));
        let v14 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::borrow_market(arg2, arg13);
        let v15 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_long_oi(v14);
        let v16 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_short_oi(v14);
        let v17 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_margin_summary(v2, v4, v6, v3 == 0, v10, 0, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v18 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_maintenance_margin_required(&v17);
        let v19 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_unrealized_pnl(&v17);
        let v20 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_account_equity(&v17);
        let v21 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v19);
        let v22 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v19);
        let v23 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v20);
        let v24 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v20);
        assert!(v24 || v23 < v18, 1);
        let v25 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_notional_value(&v17);
        let v26 = compute_liquidation_fee(v25);
        let (v27, v28) = compute_liquidation_waterfall(v23, v24, v26);
        if (v28 > 0) {
            assert!(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::balance(arg10) >= v28, 2);
        };
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::close_position_for_liquidation<T0>(arg3, arg4, arg14, v0, v27, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::lock_for_liquidation(arg3, arg14, v0));
        if (v3 == 0) {
            let v29 = if (v25 > v15) {
                0
            } else {
                v15 - v25
            };
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::set_long_oi(arg2, arg13, v29);
        } else {
            let v30 = if (v25 > v16) {
                0
            } else {
                v16 - v25
            };
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::set_short_oi(arg2, arg13, v30);
        };
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::accrue_liquidation_fee(arg9, arg14, v0, arg13, v25, v26);
        let v31 = LiquidationFeeAccrued{
            trader       : arg14,
            market_id    : v0,
            fee_amount   : v26,
            timestamp_ms : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<LiquidationFeeAccrued>(v31);
        let v32 = if (v28 > 0) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::cover_deficit(arg10, v28, arg12)
        } else {
            0
        };
        let v33 = PositionLiquidated{
            trader                      : arg14,
            symbol                      : arg13,
            market_id                   : v0,
            direction                   : v3,
            size                        : v2,
            mark_price                  : v6,
            entry_price                 : v4,
            collateral                  : v10,
            notional_value              : v25,
            unrealized_pnl_value        : v21,
            unrealized_pnl_is_negative  : v22,
            realized_pnl_value          : v21,
            realized_pnl_is_negative    : v22,
            maintenance_margin_required : v18,
            account_equity_value        : v23,
            account_equity_is_negative  : v24,
            liquidation_fee             : v26,
            remaining_collateral        : v27,
            deficit_amount              : v28,
            insurance_fund_covered      : v32,
            timestamp_ms                : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<PositionLiquidated>(v33);
    }

    public fun liquidate_position_canonical<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg2: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg3: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg4: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg5: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg6: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg7: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg8: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg9: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::FeeCollector, arg10: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg11: &0x2::clock::Clock, arg12: vector<u8>, arg13: address) {
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::assert_not_paused(arg6);
        liquidate_position<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0, arg11, arg12, arg13);
    }

    public fun liquidation_fee_bps() : u64 {
        50
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun read_funding_indices(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg1: vector<u8>) : (u128, bool, u128) {
        if (!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::funding_state_exists(arg0, arg1)) {
            return (0, false, 0)
        };
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::borrow_funding_state(arg0, arg1);
        (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::state_global_funding_index(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::state_global_funding_index_is_negative(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::state_short_borrow_index(v0))
    }

    // decompiled from Move bytecode v7
}

