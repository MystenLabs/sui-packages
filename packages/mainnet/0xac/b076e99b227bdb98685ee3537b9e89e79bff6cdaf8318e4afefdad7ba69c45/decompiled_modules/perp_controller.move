module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::perp_controller {
    struct ControllerRegistry has key {
        id: 0x2::object::UID,
        market_ids: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct OrderExecuted has copy, drop {
        trader: address,
        symbol: vector<u8>,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        price: u64,
        collateral: u64,
        fee_amount: u64,
        order_type: u8,
    }

    struct MarketRegisteredForTrading has copy, drop {
        symbol: vector<u8>,
        market_id: 0x2::object::ID,
    }

    public fun assert_market_fully_initialized(arg0: &ControllerRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::MarkPriceRegistry, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg3: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::risk_engine::RiskRegistry, arg4: vector<u8>, arg5: 0x2::object::ID) {
        let v0 = if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.market_ids, arg4)) {
            if (*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.market_ids, arg4) == arg5) {
                if (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::has_mark_price(arg1, arg5)) {
                    if (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::funding_state_exists(arg2, arg4)) {
                        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::risk_engine::is_registered(arg3, arg4)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
    }

    public fun close_position(arg0: &ControllerRegistry, arg1: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::PositionRegistry, arg3: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::VaultRegistry, arg4: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg5: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::GlobalParams, arg6: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::MarkPriceRegistry, arg7: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg8: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::fee_manager::FeeCollector, arg9: vector<u8>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 11);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::assert_not_paused(arg5);
        let v0 = get_market_id(arg0, arg9);
        let v1 = 0x2::tx_context::sender(arg11);
        validate_pre_trade(arg1, arg4, arg5, arg9, true);
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_exists(arg2, v1, v0), 8);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::borrow_position(arg2, v1, v0);
        let v3 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_size(v2);
        let v4 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_direction(v2);
        assert!(arg10 <= v3, 12);
        let v5 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::get_mark_price(arg6, v0);
        let (v6, v7, v8) = read_funding_indices(arg7, arg9);
        let (v9, v10, v11, v12) = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_settlement::compute_settlement(v4, v3, v5, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_collateral(v2), v6, v7, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot_is_negative(v2), v8, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_short_borrow_index_snapshot(v2));
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::settle_funding(arg2, v1, v0, v9, v10, v12, v11, v6, v7, v8);
        let v13 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg1, arg9);
        let v14 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_notional_value(arg10, v5);
        let v15 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::fee_manager::collect_taker_fee(arg8, v1, v0, arg9, v14);
        let v16 = if (arg10 == v3) {
            v9
        } else {
            (((v9 as u128) * (arg10 as u128) / (v3 as u128)) as u64)
        };
        let v17 = if (v15 >= v16) {
            0
        } else {
            v16 - v15
        };
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::reduce_position(arg2, v1, v0, arg10, v6, v7, v8);
        update_oi_on_close(arg1, arg9, v4, v14, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_long_oi(v13), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_short_oi(v13));
        if (v16 > 0 && 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::vault_exists(arg3, v1, v0)) {
            let v18 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::vault_balance(arg3, v1, v0);
            let v19 = if (v16 > v18) {
                v18
            } else {
                v16
            };
            if (v19 > 0) {
                0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::withdraw(arg3, v1, v0, v19);
            };
        };
        let v20 = OrderExecuted{
            trader     : v1,
            symbol     : arg9,
            market_id  : v0,
            direction  : v4,
            size       : arg10,
            price      : v5,
            collateral : v17,
            fee_amount : v15,
            order_type : 1,
        };
        0x2::event::emit<OrderExecuted>(v20);
    }

    public fun deposit_collateral(arg0: &ControllerRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::PositionRegistry, arg3: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::VaultRegistry, arg4: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg5: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::GlobalParams, arg6: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 7);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::assert_not_paused(arg5);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::trade_validator::assert_trade_allowed(arg5, arg1, arg4, arg7, false);
        let v0 = get_market_id(arg0, arg7);
        let v1 = 0x2::tx_context::sender(arg9);
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_exists(arg2, v1, v0), 8);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::borrow_position(arg2, v1, v0);
        let (v3, v4, v5) = read_funding_indices(arg6, arg7);
        let (v6, v7, v8, v9) = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_settlement::compute_settlement(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_direction(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_size(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_entry_price(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_collateral(v2), v3, v4, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot_is_negative(v2), v5, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_short_borrow_index_snapshot(v2));
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::settle_funding(arg2, v1, v0, v6, v7, v9, v8, v3, v4, v5);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::deposit(arg3, v1, v0, arg8);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::modify_collateral(arg2, v1, v0, v6 + arg8, v3, v4, v5);
    }

    public fun get_market_id(arg0: &ControllerRegistry, arg1: vector<u8>) : 0x2::object::ID {
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.market_ids, arg1), 0);
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.market_ids, arg1)
    }

    public fun increase_position(arg0: &ControllerRegistry, arg1: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::PositionRegistry, arg3: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::VaultRegistry, arg4: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg5: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::GlobalParams, arg6: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::MarkPriceRegistry, arg7: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg8: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::fee_manager::FeeCollector, arg9: &0x2::clock::Clock, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: u8, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 > 0, 6);
        assert!(arg13 == 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::session_open(), 42002);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::assert_not_paused(arg5);
        let v0 = get_market_id(arg0, arg10);
        let v1 = 0x2::tx_context::sender(arg14);
        validate_pre_trade(arg1, arg4, arg5, arg10, false);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::assert_fresh_by_market(arg6, v0, arg9);
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_exists(arg2, v1, v0), 8);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::borrow_position(arg2, v1, v0);
        let v3 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_direction(v2);
        let v4 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_size(v2);
        let v5 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::get_mark_price(arg6, v0);
        let (v6, v7, v8) = read_funding_indices(arg7, arg10);
        let (v9, v10, v11, v12) = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_settlement::compute_settlement(v3, v4, v5, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_collateral(v2), v6, v7, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot_is_negative(v2), v8, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_short_borrow_index_snapshot(v2));
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::settle_funding(arg2, v1, v0, v9, v10, v12, v11, v6, v7, v8);
        let v13 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_notional_value(arg11, v5);
        let v14 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::fee_manager::collect_taker_fee(arg8, v1, v0, arg10, v13);
        let v15 = if (v14 >= arg12) {
            0
        } else {
            arg12 - v14
        };
        let v16 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg1, arg10);
        let v17 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_long_oi(v16);
        let v18 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_short_oi(v16);
        validate_margin(v4 + arg11, v5, v9 + v15, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_initial_margin_ratio_bps(v16), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_max_leverage(v16));
        validate_oi(v3, v13, v17, v18, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_total_oi_cap(v16));
        if (v15 > 0) {
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::deposit(arg3, v1, v0, v15);
        };
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::increase_position(arg2, v1, v0, arg11, v5, v15, v6, v7, v8);
        update_oi_on_open(arg1, arg10, v3, v13, v17, v18);
        let v19 = OrderExecuted{
            trader     : v1,
            symbol     : arg10,
            market_id  : v0,
            direction  : v3,
            size       : arg11,
            price      : v5,
            collateral : v15,
            fee_amount : v14,
            order_type : 2,
        };
        0x2::event::emit<OrderExecuted>(v19);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ControllerRegistry{
            id         : 0x2::object::new(arg0),
            market_ids : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ControllerRegistry>(v0);
    }

    public fun is_market_registered(arg0: &ControllerRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.market_ids, arg1)
    }

    public fun open_position(arg0: &ControllerRegistry, arg1: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::PositionRegistry, arg3: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::VaultRegistry, arg4: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg5: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::GlobalParams, arg6: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::MarkPriceRegistry, arg7: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg8: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::fee_manager::FeeCollector, arg9: &0x2::clock::Clock, arg10: vector<u8>, arg11: u8, arg12: u64, arg13: u64, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0, 6);
        assert!(arg13 > 0, 7);
        assert!(arg11 == 0 || arg11 == 1, 10);
        assert!(arg14 == 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::session_open(), 42002);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::assert_not_paused(arg5);
        let v0 = get_market_id(arg0, arg10);
        let v1 = 0x2::tx_context::sender(arg15);
        validate_pre_trade(arg1, arg4, arg5, arg10, false);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::assert_fresh_by_market(arg6, v0, arg9);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::get_mark_price(arg6, v0);
        let v3 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_notional_value(arg12, v2);
        let v4 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::fee_manager::collect_taker_fee(arg8, v1, v0, arg10, v3);
        assert!(v4 < arg13, 15);
        let v5 = arg13 - v4;
        let v6 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg1, arg10);
        let v7 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_long_oi(v6);
        let v8 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_short_oi(v6);
        let (v9, v10, v11) = read_funding_indices(arg7, arg10);
        validate_margin(arg12, v2, v5, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_initial_margin_ratio_bps(v6), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_max_leverage(v6));
        validate_oi(arg11, v3, v7, v8, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_total_oi_cap(v6));
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::create_vault(arg3, v1, v0, v5);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::open_position(arg2, v1, v0, arg11, arg12, v2, v5, v9, v10, v11);
        update_oi_on_open(arg1, arg10, arg11, v3, v7, v8);
        let v12 = OrderExecuted{
            trader     : v1,
            symbol     : arg10,
            market_id  : v0,
            direction  : arg11,
            size       : arg12,
            price      : v2,
            collateral : v5,
            fee_amount : v4,
            order_type : 0,
        };
        0x2::event::emit<OrderExecuted>(v12);
    }

    fun read_funding_indices(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg1: vector<u8>) : (u128, bool, u128) {
        if (!0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::funding_state_exists(arg0, arg1)) {
            return (0, false, 0)
        };
        let v0 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::borrow_funding_state(arg0, arg1);
        (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::state_global_funding_index(v0), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::state_global_funding_index_is_negative(v0), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::state_short_borrow_index(v0))
    }

    public fun register_market(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut ControllerRegistry, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg3: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::MarkPriceRegistry, arg4: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg5: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::risk_engine::RiskRegistry, arg6: vector<u8>, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_exists(arg2, arg6), 0);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.market_ids, arg6), 14);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.market_ids, arg6, arg7);
        assert_market_fully_initialized(arg1, arg3, arg4, arg5, arg6, arg7);
        let v0 = MarketRegisteredForTrading{
            symbol    : arg6,
            market_id : arg7,
        };
        0x2::event::emit<MarketRegisteredForTrading>(v0);
    }

    fun update_oi_on_close(arg0: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        if (arg2 == 0) {
            let v0 = if (arg3 > arg4) {
                0
            } else {
                arg4 - arg3
            };
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::set_long_oi(arg0, arg1, v0);
        } else {
            let v1 = if (arg3 > arg5) {
                0
            } else {
                arg5 - arg3
            };
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::set_short_oi(arg0, arg1, v1);
        };
    }

    fun update_oi_on_open(arg0: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        if (arg2 == 0) {
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::set_long_oi(arg0, arg1, arg4 + arg3);
        } else {
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::set_short_oi(arg0, arg1, arg5 + arg3);
        };
    }

    fun validate_margin(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_notional_value(arg0, arg1);
        assert!(arg2 >= 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_initial_margin(v0, arg3), 3);
        assert!((v0 as u128) <= (arg4 as u128) * (arg2 as u128), 5);
    }

    fun validate_oi(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!((arg2 as u128) + (arg3 as u128) + (arg1 as u128) <= (arg4 as u128), 4);
    }

    fun validate_pre_trade(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::GlobalParams, arg3: vector<u8>, arg4: bool) {
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::trade_validator::assert_trade_allowed(arg2, arg0, arg1, arg3, arg4);
        if (!arg4) {
            assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_session_flag(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg0, arg3)) == 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::session_open(), 2);
        };
    }

    public fun withdraw_collateral(arg0: &ControllerRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::PositionRegistry, arg3: &mut 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::VaultRegistry, arg4: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg5: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::GlobalParams, arg6: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::MarkPriceRegistry, arg7: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index::FundingRegistry, arg8: vector<u8>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 > 0, 7);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::assert_not_paused(arg5);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::trade_validator::assert_trade_allowed(arg5, arg1, arg4, arg8, true);
        let v0 = get_market_id(arg0, arg8);
        let v1 = 0x2::tx_context::sender(arg10);
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_exists(arg2, v1, v0), 8);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::borrow_position(arg2, v1, v0);
        let v3 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_size(v2);
        let v4 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_direction(v2);
        let v5 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mark_price::get_mark_price(arg6, v0);
        let (v6, v7, v8) = read_funding_indices(arg7, arg8);
        let (v9, v10, v11, v12) = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_settlement::compute_settlement(v4, v3, v5, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_collateral(v2), v6, v7, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot(v2), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_global_funding_index_snapshot_is_negative(v2), v8, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_short_borrow_index_snapshot(v2));
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::settle_funding(arg2, v1, v0, v9, v10, v12, v11, v6, v7, v8);
        assert!(arg9 < v9, 13);
        let v13 = v9 - arg9;
        let v14 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_maintenance_margin_ratio_bps(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg1, arg8));
        let v15 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_margin_summary(v3, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::position_entry_price(v2), v5, v4 == 0, v13, 0, v14, v14);
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::summary_meets_maintenance_margin(&v15), 3);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault::withdraw(arg3, v1, v0, arg9);
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::position::modify_collateral(arg2, v1, v0, v13, v6, v7, v8);
    }

    // decompiled from Move bytecode v7
}

