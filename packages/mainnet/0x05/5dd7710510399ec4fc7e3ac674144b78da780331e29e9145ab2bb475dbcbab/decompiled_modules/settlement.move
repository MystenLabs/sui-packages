module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::settlement {
    struct EngineCapability has store, key {
        id: 0x2::object::UID,
        engine_address: address,
    }

    struct SettlementLog has key {
        id: 0x2::object::UID,
        settled_trades: 0x2::table::Table<u64, bool>,
        trade_count: u64,
    }

    struct TradeSettled has copy, drop {
        trade_id: u64,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        maker: address,
        taker: address,
        price: u64,
        quantity: u64,
        maker_side: u8,
        taker_fee: u64,
        maker_rebate: u64,
        timestamp_ms: u64,
    }

    struct MakerRebateCredited has copy, drop {
        maker: address,
        market_id: 0x2::object::ID,
        amount: u64,
        trade_id: u64,
    }

    struct EngineCapabilityCreated has copy, drop {
        engine_address: address,
    }

    struct RealizedPnl has copy, drop, store {
        user: address,
        market_id: 0x2::object::ID,
        pnl_value: u64,
        pnl_is_negative: bool,
        closed_quantity: u64,
        close_price: u64,
        entry_price: u64,
        timestamp_ms: u64,
    }

    struct FillOutcome has copy, drop {
        user: address,
        fill_direction: u8,
        existing_entry_price: u64,
        close_size: u64,
        open_size: u64,
        pnl_value: u64,
        pnl_is_negative: bool,
        released_collateral: u64,
        slashed_collateral: u64,
        residual_collateral_to_lock: u64,
        long_oi_add: u64,
        long_oi_sub: u64,
        short_oi_add: u64,
        short_oi_sub: u64,
    }

    fun add_u64_saturating(arg0: u64, arg1: u64) : u64 {
        u128_to_u64_saturating((arg0 as u128) + (arg1 as u128))
    }

    fun apply_close_outcome<T0>(arg0: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: FillOutcome, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        if (arg2.close_size == 0) {
            return
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg0, arg2.user, arg3);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::reduce_position<T0>(arg0, arg1, arg2.user, arg3, arg2.close_size, arg2.released_collateral, arg2.slashed_collateral, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v0), arg5);
        if (arg2.pnl_is_negative && arg2.pnl_value > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::record_realized_pnl_debit<T0>(arg1, arg2.user, arg2.pnl_value);
        };
        let v1 = RealizedPnl{
            user            : arg2.user,
            market_id       : arg3,
            pnl_value       : arg2.pnl_value,
            pnl_is_negative : arg2.pnl_is_negative,
            closed_quantity : arg2.close_size,
            close_price     : arg4,
            entry_price     : arg2.existing_entry_price,
            timestamp_ms    : arg5,
        };
        0x2::event::emit<RealizedPnl>(v1);
    }

    fun apply_open_outcome<T0>(arg0: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: FillOutcome, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: u128, arg10: u64) {
        if (arg2.open_size == 0) {
            return
        };
        if (arg2.residual_collateral_to_lock > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::lock_collateral<T0>(arg1, arg2.user, arg2.residual_collateral_to_lock);
        };
        update_or_create_position(arg0, arg2.user, arg3, arg2.fill_direction, arg2.open_size, arg4, arg2.residual_collateral_to_lock, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun apply_positive_pnl<T0>(arg0: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg1: FillOutcome) {
        let v0 = if (arg1.close_size > 0) {
            if (!arg1.pnl_is_negative) {
                arg1.pnl_value > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::credit_realized_pnl_from_insurance<T0>(arg0, arg1.user, arg1.pnl_value, false);
        };
    }

    fun assert_outcome_risk(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::RiskParams, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(arg2 > 0, 11);
        let v0 = notional_u64(arg1, arg3);
        assert!((v0 as u128) <= (arg2 as u128) * (arg4 as u128), 12);
        assert!((v0 as u128) <= (arg5 as u128) * (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::max_position_size_bps(arg0) as u128) / 10000, 13);
    }

    fun assert_price_deviation(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::RiskParams, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_mark_price(arg1, arg2);
        let v1 = if (arg3 >= v0) {
            arg3 - v0
        } else {
            v0 - arg3
        };
        assert!((v1 as u128) * 10000 <= (v0 as u128) * (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::max_price_deviation_bps(arg0) as u128), 10);
    }

    fun close_collateral_slice(arg0: u64, arg1: u64, arg2: u64) : u64 {
        u128_to_u64_saturating((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    fun close_pnl(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : (u64, bool) {
        let v0 = if (arg2 >= arg1) {
            arg2 - arg1
        } else {
            arg1 - arg2
        };
        let v1 = arg0 == 0 && arg2 < arg1 || arg2 > arg1;
        (u128_to_u64_saturating((v0 as u128) * (arg3 as u128) / 100000000), v1)
    }

    public fun create_engine_capability(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EngineCapability{
            id             : 0x2::object::new(arg2),
            engine_address : arg1,
        };
        0x2::transfer::transfer<EngineCapability>(v0, arg1);
        let v1 = EngineCapabilityCreated{engine_address: arg1};
        0x2::event::emit<EngineCapabilityCreated>(v1);
    }

    public fun create_settlement_log(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SettlementLog{
            id             : 0x2::object::new(arg1),
            settled_trades : 0x2::table::new<u64, bool>(arg1),
            trade_count    : 0,
        };
        0x2::transfer::share_object<SettlementLog>(v0);
    }

    public fun engine_address(arg0: &EngineCapability) : address {
        arg0.engine_address
    }

    public fun is_trade_settled(arg0: &SettlementLog, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.settled_trades, arg1)
    }

    public fun maker_rebate_credited_amount(arg0: &MakerRebateCredited) : u64 {
        arg0.amount
    }

    public fun maker_rebate_credited_maker(arg0: &MakerRebateCredited) : address {
        arg0.maker
    }

    public fun maker_rebate_credited_market_id(arg0: &MakerRebateCredited) : 0x2::object::ID {
        arg0.market_id
    }

    public fun maker_rebate_credited_trade_id(arg0: &MakerRebateCredited) : u64 {
        arg0.trade_id
    }

    fun notional_u64(arg0: u64, arg1: u64) : u64 {
        u128_to_u64_saturating((arg0 as u128) * (arg1 as u128) / 100000000)
    }

    fun open_outcome(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: u64) : FillOutcome {
        let (v0, v1) = if (arg1 == 0) {
            (notional_u64(arg2, arg3), 0)
        } else {
            (0, notional_u64(arg2, arg3))
        };
        FillOutcome{
            user                        : arg0,
            fill_direction              : arg1,
            existing_entry_price        : 0,
            close_size                  : 0,
            open_size                   : arg2,
            pnl_value                   : 0,
            pnl_is_negative             : false,
            released_collateral         : 0,
            slashed_collateral          : 0,
            residual_collateral_to_lock : arg4,
            long_oi_add                 : v0,
            long_oi_sub                 : 0,
            short_oi_add                : v1,
            short_oi_sub                : 0,
        }
    }

    fun plan_fill(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg1: address, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: u64) : (FillOutcome, u64, u64) {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg0, arg1, arg2)) {
            return (open_outcome(arg1, arg3, arg4, arg5, arg6), arg4, arg6)
        };
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg0, arg1, arg2);
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v0);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v0);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v0);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v0);
        if (v1 == arg3) {
            return (open_outcome(arg1, arg3, arg4, arg5, arg6), add_u64_saturating(v2, arg4), add_u64_saturating(v4, arg6))
        };
        let v5 = if (arg4 < v2) {
            arg4
        } else {
            v2
        };
        let v6 = arg4 - v5;
        let (v7, v8) = close_pnl(v1, v3, arg5, v5);
        let (v9, v10, v11) = release_and_slash(v4, close_collateral_slice(v4, v5, v2), v7, v8);
        assert!(v11 == 0, 7);
        let v12 = (((arg6 as u128) * (v6 as u128) / (arg4 as u128)) as u64);
        let (v13, v14) = if (v1 == 0) {
            (notional_u64(v5, arg5), 0)
        } else {
            (0, notional_u64(v5, arg5))
        };
        let (v15, v16) = if (arg3 == 0) {
            (notional_u64(v6, arg5), 0)
        } else {
            (0, notional_u64(v6, arg5))
        };
        let (v17, v18) = if (v6 > 0) {
            (v6, v12)
        } else {
            (v2 - v5, v4 - v9 - v10)
        };
        let v19 = FillOutcome{
            user                        : arg1,
            fill_direction              : arg3,
            existing_entry_price        : v3,
            close_size                  : v5,
            open_size                   : v6,
            pnl_value                   : v7,
            pnl_is_negative             : v8,
            released_collateral         : v9,
            slashed_collateral          : v10,
            residual_collateral_to_lock : v12,
            long_oi_add                 : v15,
            long_oi_sub                 : v13,
            short_oi_add                : v16,
            short_oi_sub                : v14,
        };
        (v19, v17, v18)
    }

    fun read_current_funding_indices(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg1: vector<u8>) : (u128, bool, u128) {
        if (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::funding_state_exists(arg0, arg1)) {
            let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::borrow_funding_state(arg0, arg1);
            (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index(v3), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index_is_negative(v3), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_short_borrow_index(v3))
        } else {
            (0, false, 0)
        }
    }

    public fun realized_pnl_close_price(arg0: &RealizedPnl) : u64 {
        arg0.close_price
    }

    public fun realized_pnl_closed_quantity(arg0: &RealizedPnl) : u64 {
        arg0.closed_quantity
    }

    public fun realized_pnl_entry_price(arg0: &RealizedPnl) : u64 {
        arg0.entry_price
    }

    public fun realized_pnl_is_negative(arg0: &RealizedPnl) : bool {
        arg0.pnl_is_negative
    }

    public fun realized_pnl_market_id(arg0: &RealizedPnl) : 0x2::object::ID {
        arg0.market_id
    }

    public fun realized_pnl_timestamp_ms(arg0: &RealizedPnl) : u64 {
        arg0.timestamp_ms
    }

    public fun realized_pnl_user(arg0: &RealizedPnl) : address {
        arg0.user
    }

    public fun realized_pnl_value(arg0: &RealizedPnl) : u64 {
        arg0.pnl_value
    }

    fun release_and_slash(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        if (!arg3 || arg2 == 0) {
            return (arg1, 0, 0)
        };
        if (arg2 <= arg1) {
            return (arg1 - arg2, arg2, 0)
        };
        let v0 = if (arg2 > arg0) {
            arg0
        } else {
            arg2
        };
        (0, v0, arg2 - v0)
    }

    public fun settle_trade<T0>(arg0: &EngineCapability, arg1: &mut SettlementLog, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg4: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg6: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg7: vector<u8>, arg8: u64, arg9: address, arg10: address, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        abort 9
    }

    public fun settle_trade_v3<T0>(arg0: &EngineCapability, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::RiskParams, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg4: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg5: &mut SettlementLog, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg7: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg8: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg9: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg10: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg11: vector<u8>, arg12: u64, arg13: address, arg14: address, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u64, arg20: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg22) == arg0.engine_address, 1);
        assert!(arg13 != arg14, 6);
        assert!(arg15 > 0, 4);
        assert!(arg16 > 0, 5);
        assert!(arg17 == 0 || arg17 == 1, 3);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg20);
        assert!(!0x2::table::contains<u64, bool>(&arg5.settled_trades, arg12), 0);
        let v0 = 0x2::clock::timestamp_ms(arg21);
        let v1 = if (arg17 == 0) {
            1
        } else {
            0
        };
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::get_market_id(arg6, arg11);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::assert_not_emergency(arg2, arg11);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::assert_fresh_by_market(arg3, v2, arg21);
        assert_price_deviation(arg1, arg3, v2, arg15);
        let (v3, v4, v5) = read_current_funding_indices(arg4, arg11);
        let v6 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_mark_price(arg3, v2);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::settle_position_funding_v4<T0>(arg7, arg8, arg14, v2, v6, v3, v4, v5, v0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::settle_position_funding_v4<T0>(arg7, arg8, arg13, v2, v6, v3, v4, v5, v0);
        let v7 = notional_u64(arg16, arg15);
        let v8 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::collect_taker_fee(arg9, arg14, v2, arg11, v7);
        let v9 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::pay_maker_rebate(arg9, arg13, v2, arg11, v7);
        let v10 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::borrow_market(arg10, arg11);
        let v11 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_initial_margin_ratio_bps(v10);
        let v12 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_maintenance_margin_ratio_bps(v10);
        let (v13, v14, v15) = plan_fill(arg7, arg14, v2, v1, arg16, arg15, arg18);
        let v16 = v13;
        let (v17, v18, v19) = plan_fill(arg7, arg13, v2, arg17, arg16, arg15, arg19);
        let v20 = v17;
        let v21 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_max_leverage(v10);
        let v22 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_total_oi_cap(v10);
        assert_outcome_risk(arg1, v14, v15, arg15, v21, v22);
        assert_outcome_risk(arg1, v18, v19, arg15, v21, v22);
        apply_close_outcome<T0>(arg7, arg8, v16, v2, arg15, v0);
        apply_close_outcome<T0>(arg7, arg8, v20, v2, arg15, v0);
        apply_open_outcome<T0>(arg7, arg8, v16, v2, arg15, v11, v12, v3, v4, v5, v0);
        apply_open_outcome<T0>(arg7, arg8, v20, v2, arg15, v11, v12, v3, v4, v5, v0);
        apply_positive_pnl<T0>(arg8, v16);
        apply_positive_pnl<T0>(arg8, v20);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::ensure_balance_exists<T0>(arg8, arg14, arg22);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::ensure_balance_exists<T0>(arg8, arg13, arg22);
        let v23 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::credit_fee_rebate<T0>(arg8, arg14, arg13, v9);
        if (v23 > 0) {
            let v24 = MakerRebateCredited{
                maker     : arg13,
                market_id : v2,
                amount    : v23,
                trade_id  : arg12,
            };
            0x2::event::emit<MakerRebateCredited>(v24);
        };
        let (v25, v26) = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::split_fee(arg9, v8 - v9);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::collect_insurance<T0>(arg8, arg14, v26);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::collect_fee<T0>(arg8, arg14, v25);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::set_long_oi(arg10, arg11, add_u64_saturating(sub_oi_saturating(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_long_oi(v10), add_u64_saturating(v16.long_oi_sub, v20.long_oi_sub)), add_u64_saturating(v16.long_oi_add, v20.long_oi_add)));
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::set_short_oi(arg10, arg11, add_u64_saturating(sub_oi_saturating(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_short_oi(v10), add_u64_saturating(v16.short_oi_sub, v20.short_oi_sub)), add_u64_saturating(v16.short_oi_add, v20.short_oi_add)));
        0x2::table::add<u64, bool>(&mut arg5.settled_trades, arg12, true);
        arg5.trade_count = arg5.trade_count + 1;
        let v27 = TradeSettled{
            trade_id     : arg12,
            market_id    : v2,
            symbol       : arg11,
            maker        : arg13,
            taker        : arg14,
            price        : arg15,
            quantity     : arg16,
            maker_side   : arg17,
            taker_fee    : v8,
            maker_rebate : v9,
            timestamp_ms : v0,
        };
        0x2::event::emit<TradeSettled>(v27);
    }

    public fun settle_trade_v4<T0>(arg0: &EngineCapability, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::RiskParams, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg4: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg5: &mut SettlementLog, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::perp_controller::ControllerRegistry, arg7: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg8: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg9: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg10: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg11: vector<u8>, arg12: u64, arg13: address, arg14: address, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u8, arg20: u64, arg21: u64, arg22: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        assert!(arg17 != 2, 42001);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg22);
        settle_trade_v3<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
    }

    fun sub_oi_saturating(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun trade_count(arg0: &SettlementLog) : u64 {
        arg0.trade_count
    }

    fun u128_to_u64_saturating(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (arg0 as u64)
        }
    }

    fun update_or_create_position(arg0: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg1: address, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: bool, arg11: u128, arg12: u64) {
        if (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::has_position(arg0, arg1, arg2)) {
            let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::get_position(arg0, arg1, arg2);
            assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_direction(v0) == arg3, 8);
            let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_size(v0);
            let v2 = v1 + arg4;
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::update_position(arg0, arg1, arg2, v2, ((((v1 as u128) * (0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_entry_price(v0) as u128) + (arg4 as u128) * (arg5 as u128)) / (v2 as u128)) as u64), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_collateral(v0) + arg6, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_global_funding_index_snapshot_is_negative(v0), 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::pos_short_borrow_index_snapshot(v0), arg12);
        } else {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::open_position(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg10, arg11, arg7, arg8, arg12);
        };
    }

    // decompiled from Move bytecode v7
}

