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
        let v8 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_margin_summary(v2, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_entry_price(v1), v4, v3 == 0, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_collateral(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_settlement::compute_accrued_funding_cost_v4(v3, v2, v4, v5, v6, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot_is_negative(v1), v7, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_short_borrow_index_snapshot(v1)), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v9 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_account_equity(&v8);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v9) || 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v9) < 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_maintenance_margin_required(&v8)
    }

    public fun liquidate_position<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg2: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg3: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg4: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg5: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg6: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg7: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg8: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg9: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::FeeCollector, arg10: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg11: u8, arg12: &0x2::clock::Clock, arg13: vector<u8>, arg14: address) {
        liquidate_position_impl<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun liquidate_position_canonical<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg2: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg3: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg4: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg5: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg6: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg7: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg8: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg9: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::FeeCollector, arg10: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg11: &0x2::clock::Clock, arg12: vector<u8>, arg13: address) {
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::assert_not_paused(arg6);
        liquidate_position<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0, arg11, arg12, arg13);
    }

    fun liquidate_position_impl<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg1: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg2: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg3: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg4: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg5: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg6: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg7: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg8: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::FeeCollector, arg9: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg10: u8, arg11: &0x2::clock::Clock, arg12: vector<u8>, arg13: address) {
        assert!(arg10 != 2, 42001);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::assert_not_paused(arg5);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::trade_validator::assert_trade_allowed(arg5, arg1, arg4, arg12, true);
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::get_market_id(arg0, arg12);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::assert_fresh_by_market(arg6, v0, arg11);
        assert!(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::has_position(arg2, arg13, v0), 0);
        assert!(!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_locked_for_liquidation(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::get_position(arg2, arg13, v0)), 3);
        let v1 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::get_position(arg2, arg13, v0);
        let v2 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_size(v1);
        let v3 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_direction(v1);
        let v4 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_entry_price(v1);
        let v5 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_collateral(v1);
        let v6 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::get_mark_price(arg6, v0);
        let (v7, v8, v9) = read_funding_indices(arg7, arg12);
        let v10 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::borrow_market(arg1, arg12);
        let v11 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_long_oi(v10);
        let v12 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_short_oi(v10);
        let v13 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_margin_summary(v2, v4, v6, v3 == 0, v5, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_settlement::compute_accrued_funding_cost_v4(v3, v2, v6, v7, v8, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_global_funding_index_snapshot_is_negative(v1), v9, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_short_borrow_index_snapshot(v1)), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v14 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_maintenance_margin_required(&v13);
        let v15 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_unrealized_pnl(&v13);
        let v16 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_account_equity(&v13);
        let v17 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v15);
        let v18 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v15);
        let v19 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_value(&v16);
        let v20 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::signed_is_negative(&v16);
        assert!(v20 || v19 < v14, 1);
        let v21 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::summary_notional_value(&v13);
        let v22 = compute_liquidation_fee(v21);
        let (v23, v24) = compute_liquidation_waterfall(v19, v20, v22);
        if (v24 > 0) {
            assert!(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::balance(arg9) >= v24, 2);
        };
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::close_position_for_liquidation<T0>(arg2, arg3, arg13, v0, v23, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::lock_for_liquidation(arg2, arg13, v0));
        if (v3 == 0) {
            let v25 = if (v21 > v11) {
                0
            } else {
                v11 - v21
            };
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::set_long_oi(arg1, arg12, v25);
        } else {
            let v26 = if (v21 > v12) {
                0
            } else {
                v12 - v21
            };
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::set_short_oi(arg1, arg12, v26);
        };
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::accrue_liquidation_fee(arg8, arg13, v0, arg12, v21, v22);
        let v27 = LiquidationFeeAccrued{
            trader       : arg13,
            market_id    : v0,
            fee_amount   : v22,
            timestamp_ms : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<LiquidationFeeAccrued>(v27);
        let v28 = if (v24 > 0) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::cover_deficit(arg9, v24, arg11)
        } else {
            0
        };
        let v29 = PositionLiquidated{
            trader                      : arg13,
            symbol                      : arg12,
            market_id                   : v0,
            direction                   : v3,
            size                        : v2,
            mark_price                  : v6,
            entry_price                 : v4,
            collateral                  : v5,
            notional_value              : v21,
            unrealized_pnl_value        : v17,
            unrealized_pnl_is_negative  : v18,
            realized_pnl_value          : v17,
            realized_pnl_is_negative    : v18,
            maintenance_margin_required : v14,
            account_equity_value        : v19,
            account_equity_is_negative  : v20,
            liquidation_fee             : v22,
            remaining_collateral        : v23,
            deficit_amount              : v24,
            insurance_fund_covered      : v28,
            timestamp_ms                : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<PositionLiquidated>(v29);
    }

    public fun liquidate_position_v2<T0>(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::LiquidatorCap, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::perp_controller::ControllerRegistry, arg2: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg3: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg4: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg5: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg6: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg7: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price::MarkPriceRegistry, arg8: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_index::FundingRegistry, arg9: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager::FeeCollector, arg10: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund::InsuranceFundState, arg11: u8, arg12: &0x2::clock::Clock, arg13: vector<u8>, arg14: address) {
        liquidate_position_impl<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
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

