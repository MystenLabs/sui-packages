module 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::liquidation {
    struct LiquidationDryRunResult has copy, drop {
        found: bool,
        liquidatable: bool,
        health_factor: u128,
        realized_pnl_usd: 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::SignedValue,
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

    struct PositionLiquidatedVault has copy, drop {
        trader: address,
        symbol: vector<u8>,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        mark_price: u64,
        entry_price: u64,
        collateral: u64,
        notional_value: u64,
        liquidation_fee: u64,
        remaining_collateral: u64,
        deficit_amount: u64,
        vault_covered: u64,
        insurance_fund_covered: u64,
        timestamp_ms: u64,
    }

    struct LiquidationFeeAccrued has copy, drop {
        trader: address,
        market_id: 0x2::object::ID,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    struct InsuranceExhausted has copy, drop {
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        trader: address,
        deficit_uncovered: u64,
        timestamp: u64,
    }

    struct BatchLiquidationSummary has copy, drop {
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        attempted: u64,
        liquidated: u64,
        skipped_not_liquidatable: u64,
        skipped_insurance: u64,
        skipped_other: u64,
        skipped_duplicate: u64,
        timestamp_ms: u64,
    }

    fun assert_liquidation_outcome(arg0: u8) {
        if (arg0 == 0) {
            return
        } else if (arg0 == 1) {
            abort 0
        } else if (arg0 == 2) {
            abort 3
        } else {
            assert!(arg0 == 3, 2);
            abort 1
        };
    }

    fun assert_market_liquidatable(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg4: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg5: u8, arg6: &0x2::clock::Clock, arg7: vector<u8>) : 0x2::object::ID {
        assert!(arg5 != 2, 42001);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg3);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::trade_validator::assert_trade_allowed(arg3, arg1, arg2, arg7, true);
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::get_market_id(arg0, arg7);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::assert_fresh_by_market(arg4, v0, arg6);
        v0
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

    public fun compute_liquidation_outcome<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock) : LiquidationDryRunResult {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg0, arg3, arg4)) {
            return LiquidationDryRunResult{
                found                  : false,
                liquidatable           : false,
                health_factor          : 0,
                realized_pnl_usd       : 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::compute_unrealized_pnl(0, 0, 0, true),
                collateral_slashed     : 0,
                insurance_fund_debit   : 0,
                liquidator_fee         : 0,
                insurance_insufficient : false,
                error_code             : 0,
            }
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg0, arg3, arg4);
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v0);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::compute_margin_summary(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v0), arg5, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v0) == 0, v1, 0, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_initial_margin_ratio_bps_at_open(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_maintenance_margin_ratio_bps_at_open(v0));
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_account_equity(&v2);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_value(&v3);
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_is_negative(&v3);
        if (!!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_meets_maintenance_margin(&v2)) {
            return LiquidationDryRunResult{
                found                  : true,
                liquidatable           : false,
                health_factor          : compute_health_factor(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_maintenance_margin_required(&v2), v4, v5),
                realized_pnl_usd       : 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_unrealized_pnl(&v2),
                collateral_slashed     : 0,
                insurance_fund_debit   : 0,
                liquidator_fee         : 0,
                insurance_insufficient : false,
                error_code             : 1,
            }
        };
        let v6 = compute_liquidation_fee(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_notional_value(&v2));
        let (v7, v8) = compute_liquidation_waterfall(v4, v5, v6);
        let v9 = min_u64(v8, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::balance(arg2));
        LiquidationDryRunResult{
            found                  : true,
            liquidatable           : true,
            health_factor          : compute_health_factor(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_maintenance_margin_required(&v2), v4, v5),
            realized_pnl_usd       : 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_unrealized_pnl(&v2),
            collateral_slashed     : min_u64(v1 - v7, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_locked_balance<T0>(arg1, arg3)),
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

    public fun is_liquidatable(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg4: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: address) : bool {
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::get_market_id(arg0, arg6);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::assert_fresh_by_market(arg3, v0, arg5);
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg1, arg7, v0)) {
            return false
        };
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg1, arg7, v0);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v1);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v1);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_mark_price(arg3, v0);
        let (v5, v6, v7) = read_funding_indices(arg4, arg6);
        let v8 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::compute_margin_summary(v2, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v1), v4, v3 == 0, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_settlement::compute_accrued_funding_cost_v4(v3, v2, v4, v5, v6, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v1), v7, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v1)), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v9 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_account_equity(&v8);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_is_negative(&v9) || 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_value(&v9) < 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_maintenance_margin_required(&v8)
    }

    public fun liquidate_market_batch_v2<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg7: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg8: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg9: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg10: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg11: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg12: u8, arg13: &0x2::clock::Clock, arg14: vector<u8>, arg15: vector<address>) {
        assert!(0x1::vector::length<address>(&arg15) <= 50, 4);
        let v0 = assert_market_liquidatable(arg2, arg3, arg6, arg7, arg8, arg12, arg13, arg14);
        let v1 = 0x1::vector::length<address>(&arg15);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0x1::vector::empty<address>();
        let v8 = 0;
        while (v8 < v1) {
            let v9 = *0x1::vector::borrow<address>(&arg15, v8);
            v8 = v8 + 1;
            if (0x1::vector::contains<address>(&v7, &v9)) {
                v6 = v6 + 1;
                continue
            };
            0x1::vector::push_back<address>(&mut v7, v9);
            let v10 = try_liquidate_one<T0>(arg0, arg1, arg3, arg4, arg5, arg8, arg9, arg10, arg11, v0, true, arg13, arg14, v9);
            if (v10 == 0) {
                v2 = v2 + 1;
                continue
            };
            if (v10 == 3) {
                v3 = v3 + 1;
                continue
            };
            if (v10 == 4) {
                v4 = v4 + 1;
                continue
            };
            v5 = v5 + 1;
        };
        let v11 = BatchLiquidationSummary{
            market_id                : v0,
            symbol                   : arg14,
            attempted                : v1,
            liquidated               : v2,
            skipped_not_liquidatable : v3,
            skipped_insurance        : v4,
            skipped_other            : v5,
            skipped_duplicate        : v6,
            timestamp_ms             : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<BatchLiquidationSummary>(v11);
    }

    fun liquidate_position_impl<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg7: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg8: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg9: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg10: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg11: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg12: u8, arg13: &0x2::clock::Clock, arg14: vector<u8>, arg15: address) {
        let v0 = assert_market_liquidatable(arg2, arg3, arg6, arg7, arg8, arg12, arg13, arg14);
        assert_liquidation_outcome(try_liquidate_one<T0>(arg0, arg1, arg3, arg4, arg5, arg8, arg9, arg10, arg11, v0, false, arg13, arg14, arg15));
    }

    public fun liquidate_position_v2<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg7: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg8: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg9: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg10: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg11: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg12: u8, arg13: &0x2::clock::Clock, arg14: vector<u8>, arg15: address) {
        liquidate_position_impl<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun liquidate_position_v2_vault<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg7: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg8: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg9: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg10: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg11: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg12: &0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopRegistry, arg13: u8, arg14: &0x2::clock::Clock, arg15: vector<u8>, arg16: address) {
        let v0 = assert_market_liquidatable(arg2, arg3, arg6, arg7, arg8, arg13, arg14, arg15);
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg4, arg16, v0), 0);
        assert!(!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_locked_for_liquidation(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg4, arg16, v0)), 3);
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg4, arg16, v0);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v1);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v1);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v1);
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v1);
        let v6 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_mark_price(arg8, v0);
        let (v7, v8, v9) = read_funding_indices(arg9, arg15);
        let v10 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::borrow_market(arg3, arg15);
        let v11 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_long_oi(v10);
        let v12 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_short_oi(v10);
        let v13 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::compute_margin_summary(v2, v4, v6, v3 == 0, v5, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_settlement::compute_accrued_funding_cost_v4(v3, v2, v6, v7, v8, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v1), v9, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v1)), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_initial_margin_ratio_bps_at_open(v1), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_maintenance_margin_ratio_bps_at_open(v1));
        let v14 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_account_equity(&v13);
        let v15 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_value(&v14);
        let v16 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_is_negative(&v14);
        assert!(v16 || v15 < 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_maintenance_margin_required(&v13), 1);
        let v17 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_notional_value(&v13);
        let v18 = compute_liquidation_fee(v17);
        let (v19, v20) = compute_liquidation_waterfall(v15, v16, v18);
        let v21 = min_u64(v19, v5);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::close_position_for_liquidation_authorized<T0>(arg0, arg1, arg4, arg5, arg16, v0, v21, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::lock_for_liquidation_authorized(arg0, arg1, arg4, arg16, v0));
        if (v3 == 0) {
            let v22 = if (v17 > v11) {
                0
            } else {
                v11 - v17
            };
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::set_long_oi_authorized(arg0, arg1, arg3, arg15, v22);
        } else {
            let v23 = if (v17 > v12) {
                0
            } else {
                v12 - v17
            };
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::set_short_oi_authorized(arg0, arg1, arg3, arg15, v23);
        };
        let v24 = if (v16) {
            v15
        } else {
            0
        };
        let (v25, v26) = try_vault_deficit_coverage<T0>(arg0, arg1, arg5, arg12, arg14, arg15, arg16, v24, v20);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::accrue_liquidation_fee_authorized(arg0, arg1, arg10, arg16, v0, arg15, v17, v18);
        let v27 = LiquidationFeeAccrued{
            trader       : arg16,
            market_id    : v0,
            fee_amount   : v18,
            timestamp_ms : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<LiquidationFeeAccrued>(v27);
        if (v26 > 0) {
            let v28 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::balance(arg11) >= v26;
            let v29 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::insurance_pool_balance<T0>(arg5) >= v26;
            if (!v28 || !v29) {
                let v30 = InsuranceExhausted{
                    market_id         : v0,
                    symbol            : arg15,
                    trader            : arg16,
                    deficit_uncovered : v26,
                    timestamp         : 0x2::clock::timestamp_ms(arg14),
                };
                0x2::event::emit<InsuranceExhausted>(v30);
            };
            assert!(v28, 2);
            assert!(v29, 2);
        };
        let v31 = if (v26 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::cover_deficit_authorized(arg0, arg1, arg11, v26, arg14)
        } else {
            0
        };
        let v32 = PositionLiquidatedVault{
            trader                 : arg16,
            symbol                 : arg15,
            market_id              : v0,
            direction              : v3,
            size                   : v2,
            mark_price             : v6,
            entry_price            : v4,
            collateral             : v5,
            notional_value         : v17,
            liquidation_fee        : v18,
            remaining_collateral   : v21,
            deficit_amount         : v20,
            vault_covered          : v25,
            insurance_fund_covered : v31,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<PositionLiquidatedVault>(v32);
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

    fun read_funding_indices(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg1: vector<u8>) : (u128, bool, u128) {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::funding_state_exists(arg0, arg1)) {
            return (0, false, 0)
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::borrow_funding_state(arg0, arg1);
        (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index_is_negative(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_short_borrow_index(v0))
    }

    fun try_liquidate_one<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg5: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg7: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg8: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg9: 0x2::object::ID, arg10: bool, arg11: &0x2::clock::Clock, arg12: vector<u8>, arg13: address) : u8 {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg3, arg13, arg9)) {
            return 1
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg3, arg13, arg9);
        if (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_locked_for_liquidation(v0)) {
            return 2
        };
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v0);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v0);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v0);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v0);
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_mark_price(arg5, arg9);
        let (v6, v7, v8) = read_funding_indices(arg6, arg12);
        let v9 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::compute_margin_summary(v1, v3, v5, v2 == 0, v4, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_settlement::compute_accrued_funding_cost_v4(v2, v1, v5, v6, v7, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v0), v8, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v0)), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_initial_margin_ratio_bps_at_open(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_maintenance_margin_ratio_bps_at_open(v0));
        let v10 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_maintenance_margin_required(&v9);
        let v11 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_unrealized_pnl(&v9);
        let v12 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_account_equity(&v9);
        let v13 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_value(&v11);
        let v14 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_is_negative(&v11);
        let v15 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_value(&v12);
        let v16 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::signed_is_negative(&v12);
        let v17 = v16 || v15 < v10;
        if (!v17) {
            return 3
        };
        let v18 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_calculator::summary_notional_value(&v9);
        let v19 = compute_liquidation_fee(v18);
        let (v20, v21) = compute_liquidation_waterfall(v15, v16, v19);
        let v22 = min_u64(v20, v4);
        if (v21 > 0) {
            let v23 = !arg10 || 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::insurance_pool_balance<T0>(arg4) >= v21;
            if (!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::balance(arg8) >= v21) || !v23) {
                let v24 = InsuranceExhausted{
                    market_id         : arg9,
                    symbol            : arg12,
                    trader            : arg13,
                    deficit_uncovered : v21,
                    timestamp         : 0x2::clock::timestamp_ms(arg11),
                };
                0x2::event::emit<InsuranceExhausted>(v24);
                return 4
            };
        };
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::close_position_for_liquidation_authorized<T0>(arg0, arg1, arg3, arg4, arg13, arg9, v22, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::lock_for_liquidation_authorized(arg0, arg1, arg3, arg13, arg9));
        let v25 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::borrow_market(arg2, arg12);
        let v26 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_long_oi(v25);
        let v27 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_short_oi(v25);
        if (v2 == 0) {
            let v28 = if (v18 > v26) {
                0
            } else {
                v26 - v18
            };
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::set_long_oi_authorized(arg0, arg1, arg2, arg12, v28);
        } else {
            let v29 = if (v18 > v27) {
                0
            } else {
                v27 - v18
            };
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::set_short_oi_authorized(arg0, arg1, arg2, arg12, v29);
        };
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::accrue_liquidation_fee_authorized(arg0, arg1, arg7, arg13, arg9, arg12, v18, v19);
        let v30 = LiquidationFeeAccrued{
            trader       : arg13,
            market_id    : arg9,
            fee_amount   : v19,
            timestamp_ms : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<LiquidationFeeAccrued>(v30);
        let v31 = if (v21 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::cover_deficit_authorized(arg0, arg1, arg8, v21, arg11)
        } else {
            0
        };
        let v32 = PositionLiquidated{
            trader                      : arg13,
            symbol                      : arg12,
            market_id                   : arg9,
            direction                   : v2,
            size                        : v1,
            mark_price                  : v5,
            entry_price                 : v3,
            collateral                  : v4,
            notional_value              : v18,
            unrealized_pnl_value        : v13,
            unrealized_pnl_is_negative  : v14,
            realized_pnl_value          : v13,
            realized_pnl_is_negative    : v14,
            maintenance_margin_required : v10,
            account_equity_value        : v15,
            account_equity_is_negative  : v16,
            liquidation_fee             : v19,
            remaining_collateral        : v22,
            deficit_amount              : v21,
            insurance_fund_covered      : v31,
            timestamp_ms                : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<PositionLiquidated>(v32);
        0
    }

    fun try_vault_deficit_coverage<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg3: &0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopRegistry, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: address, arg7: u64, arg8: u64) : (u64, u64) {
        if (arg8 == 0) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_zero_deficit(), 0x2::clock::timestamp_ms(arg4));
            return (0, 0)
        };
        let v0 = 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::get_config(arg3, arg5);
        if (0x1::option::is_none<0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopConfig>(&v0)) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_no_config(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        let v1 = 0x1::option::borrow<0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::VaultBackstopConfig>(&v0);
        if (!0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_enabled(v1)) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_disabled(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        if (0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_pause_absorptions(v1)) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_paused(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        let v2 = 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_vault_account(v1);
        if (v2 == arg6) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_vault_is_trader(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        if (arg7 == 0) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_zero_deficit(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_available_balance<T0>(arg2, v2);
        if (v3 == 0) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_insufficient_margin(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        let v4 = min_u64(min_u64(arg7, (((0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::config_capacity_cap_bps(v1) as u128) * (v3 as u128) / 10000) as u64)), v3);
        if (v4 == 0) {
            0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_skipped(arg5, 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::skip_zero_fill(), 0x2::clock::timestamp_ms(arg4));
            return (0, arg8)
        };
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate::collect_insurance_authorized<T0>(arg0, arg1, arg2, v2, v4);
        let v6 = if (v5 >= arg8) {
            0
        } else {
            arg8 - v5
        };
        0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop::emit_deficit_covered(arg5, v2, v5, v6, 0x2::clock::timestamp_ms(arg4));
        (v5, v6)
    }

    // decompiled from Move bytecode v7
}

