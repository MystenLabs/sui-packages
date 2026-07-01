module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events {
    struct PositionOpened has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        position_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        leverage_bps: u64,
        entry_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        open_fee_amount: u64,
        volume_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        entry_borrow_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        entry_funding_sign: bool,
        entry_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        unrealized_borrow_fee: u64,
        unrealized_funding_sign: bool,
        unrealized_funding_fee: u64,
        memo: 0x1::string::String,
    }

    struct PositionClosed has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        position_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_type: 0x1::type_name::TypeName,
        exit_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        pnl_amount: u64,
        pnl_is_profit: bool,
        close_fee_amount: u64,
        funding_fee_amount: u64,
        funding_fee_is_cost: bool,
        borrow_fee_amount: u64,
        volume_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        memo: 0x1::string::String,
    }

    struct PositionModified has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        position_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        is_increase: bool,
        delta_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        new_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        is_deposit: bool,
        delta_collateral_amount: u64,
        new_collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        execution_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        realized_pnl_amount: u64,
        pnl_is_profit: bool,
        fee_amount: u64,
        close_fee_amount: u64,
        funding_fee_amount: u64,
        funding_fee_is_cost: bool,
        borrow_fee_amount: u64,
        volume_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        entry_borrow_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        entry_funding_sign: bool,
        entry_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        unrealized_borrow_fee: u64,
        unrealized_funding_sign: bool,
        unrealized_funding_fee: u64,
        memo: 0x1::string::String,
    }

    struct PositionLiquidated has copy, drop {
        account_object_address: address,
        liquidator_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        liquidator_fee_amount: u64,
        insurance_fee_amount: u64,
        lp_pool_amount: u64,
        funding_fee_amount: u64,
        funding_fee_is_cost: bool,
        borrow_fee_amount: u64,
        mark_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        volume_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        memo: 0x1::string::String,
    }

    struct PositionLinkedOrderModified has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        order_id: u64,
        linked_order_price_key: u128,
        is_added: bool,
        memo: 0x1::string::String,
    }

    struct OrderCreated has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        order_type: u8,
        is_long: bool,
        reduce_only: bool,
        linked_position_id: 0x1::option::Option<u64>,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        trigger_price: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>,
        collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        memo: 0x1::string::String,
    }

    struct OrderCancelled has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        withdrawal_collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        memo: 0x1::string::String,
    }

    struct OrderUpdated has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        order_type: u8,
        is_long: bool,
        reduce_only: bool,
        linked_position_id: 0x1::option::Option<u64>,
        old_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        new_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        old_trigger_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        new_trigger_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        memo: 0x1::string::String,
    }

    struct OrderFilled has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        order_type: u8,
        is_long: bool,
        is_increase: bool,
        reduce_only: bool,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        position_id: u64,
        filled_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        filled_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        fee_amount: u64,
        volume_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_type: 0x1::type_name::TypeName,
        new_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        new_collateral_amount: u64,
        entry_borrow_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        entry_funding_sign: bool,
        entry_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        unrealized_borrow_fee: u64,
        unrealized_funding_sign: bool,
        unrealized_funding_fee: u64,
        memo: 0x1::string::String,
    }

    struct PreOrderCreated has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        main_order_id: u64,
        pre_order_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        order_type: u8,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        trigger_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        memo: 0x1::string::String,
    }

    struct PreOrderCancelled has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        main_order_id: u64,
        pre_order_id: u64,
        symbol: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        order_type: u8,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        trigger_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        memo: 0x1::string::String,
    }

    struct ProtocolFeeCollected has copy, drop {
        amount: u64,
        market_id: 0x2::object::ID,
        memo: 0x1::string::String,
    }

    struct WlpEquityChanged has copy, drop {
        market_ticker: 0x1::string::String,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        is_profit: bool,
        memo: 0x1::string::String,
    }

    struct WlpMinted has copy, drop {
        account_object_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        wlp_amount: u64,
        fee_amount: u64,
        share_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        memo: 0x1::string::String,
    }

    struct WlpRedeemRequested has copy, drop {
        account_object_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        wlp_amount: u64,
        request_id: u64,
        memo: 0x1::string::String,
    }

    struct WlpRedeemCancelled has copy, drop {
        account_object_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        request_id: u64,
        wlp_amount: u64,
        memo: 0x1::string::String,
    }

    struct WlpRedeemRejected has copy, drop {
        account_object_address: address,
        operator_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        request_id: u64,
        wlp_amount: u64,
        memo: 0x1::string::String,
    }

    struct WlpRedeemSettled has copy, drop {
        account_object_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        request_id: u64,
        redeem_amount: u64,
        fee_amount: u64,
        share_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        memo: 0x1::string::String,
    }

    struct FundingRateUpdated has copy, drop {
        market_id: 0x2::object::ID,
        funding_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        funding_rate_sign: bool,
        cumulative_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        cumulative_funding_sign: bool,
        long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        memo: 0x1::string::String,
    }

    struct BorrowRateUpdated has copy, drop {
        token_type: 0x1::type_name::TypeName,
        borrow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        cumulative_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        utilization_bps: u64,
        memo: 0x1::string::String,
    }

    struct MarketConfigUpdated has copy, drop {
        market_id: 0x2::object::ID,
        is_paused: bool,
        max_leverage_bps: u64,
        min_coll_value: u64,
        trading_fee: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_impact_fee: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        allocated_lp_exposure_bps: u64,
        impact_fee_curvature: u64,
        impact_fee_scale: u64,
        maintenance_margin: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        cooldown_ms: u64,
        order_price_tick: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_pre_orders: u64,
        basic_funding_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        funding_interval_ms: u64,
        request_checklist: vector<0x1::type_name::TypeName>,
        position_locker: 0x2::vec_set::VecSet<u64>,
        long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        long_avg_entry_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_avg_entry_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        next_position_id: u64,
        next_order_id: u64,
        last_funding_timestamp: u64,
        cumulative_funding_sign: bool,
        cumulative_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        memo: 0x1::string::String,
    }

    struct TokenPoolInfoUpdated has copy, drop {
        token_type: 0x1::type_name::TypeName,
        token_decimal: u8,
        target_weight_bps: u64,
        mint_fee_bps: u64,
        burn_fee_bps: u64,
        max_capacity: u64,
        min_deposit: u64,
        basic_borrow_rate_0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        basic_borrow_rate_1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        basic_borrow_rate_2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        utilization_threshold_0_bps: u64,
        utilization_threshold_1_bps: u64,
        borrow_interval_ms: u64,
        max_reserve_ratio_bps: u64,
        memo: 0x1::string::String,
    }

    public(friend) fun emit_borrow_rate_updated(arg0: 0x1::type_name::TypeName, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: u64) {
        let v0 = BorrowRateUpdated{
            token_type      : arg0,
            borrow_rate     : arg1,
            cumulative_rate : arg2,
            utilization_bps : arg3,
            memo            : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::borrow_rate_updated(),
        };
        0x2::event::emit<BorrowRateUpdated>(v0);
    }

    public(friend) fun emit_funding_rate_updated(arg0: 0x2::object::ID, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: bool, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg4: bool, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = FundingRateUpdated{
            market_id               : arg0,
            funding_rate            : arg1,
            funding_rate_sign       : arg2,
            cumulative_index        : arg3,
            cumulative_funding_sign : arg4,
            long_oi                 : arg5,
            short_oi                : arg6,
            memo                    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::funding_rate_updated(),
        };
        0x2::event::emit<FundingRateUpdated>(v0);
    }

    public(friend) fun emit_market_config_updated(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: u64, arg7: u64, arg8: u64, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg12: u64, arg13: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg14: u64, arg15: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg16: u64, arg17: vector<0x1::type_name::TypeName>, arg18: 0x2::vec_set::VecSet<u64>, arg19: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg20: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg21: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg22: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg23: u64, arg24: u64, arg25: u64, arg26: bool, arg27: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = MarketConfigUpdated{
            market_id                 : arg0,
            is_paused                 : arg1,
            max_leverage_bps          : arg2,
            min_coll_value            : arg3,
            trading_fee               : arg4,
            max_impact_fee            : arg5,
            allocated_lp_exposure_bps : arg6,
            impact_fee_curvature      : arg7,
            impact_fee_scale          : arg8,
            maintenance_margin        : arg9,
            max_long_oi               : arg10,
            max_short_oi              : arg11,
            cooldown_ms               : arg12,
            order_price_tick          : arg13,
            max_pre_orders            : arg14,
            basic_funding_rate        : arg15,
            funding_interval_ms       : arg16,
            request_checklist         : arg17,
            position_locker           : arg18,
            long_oi                   : arg19,
            short_oi                  : arg20,
            long_avg_entry_price      : arg21,
            short_avg_entry_price     : arg22,
            next_position_id          : arg23,
            next_order_id             : arg24,
            last_funding_timestamp    : arg25,
            cumulative_funding_sign   : arg26,
            cumulative_funding_index  : arg27,
            memo                      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::market_config_updated(),
        };
        0x2::event::emit<MarketConfigUpdated>(v0);
    }

    public(friend) fun emit_order_cancelled(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x1::type_name::TypeName, arg7: 0x1::string::String) {
        let v0 = OrderCancelled{
            account_object_address       : arg0,
            market_id                    : arg1,
            order_id                     : arg2,
            symbol                       : arg3,
            wlp_type                     : arg4,
            withdrawal_collateral_amount : arg5,
            collateral_type              : arg6,
            memo                         : arg7,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    public(friend) fun emit_order_created(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: u8, arg6: bool, arg7: bool, arg8: 0x1::option::Option<u64>, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, arg11: u64, arg12: 0x1::type_name::TypeName) {
        let v0 = OrderCreated{
            account_object_address : arg0,
            market_id              : arg1,
            order_id               : arg2,
            symbol                 : arg3,
            wlp_type               : arg4,
            order_type             : arg5,
            is_long                : arg6,
            reduce_only            : arg7,
            linked_position_id     : arg8,
            size                   : arg9,
            trigger_price          : arg10,
            collateral_amount      : arg11,
            collateral_type        : arg12,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::order_created(),
        };
        0x2::event::emit<OrderCreated>(v0);
    }

    public(friend) fun emit_order_filled(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: bool, arg5: bool, arg6: bool, arg7: 0x1::string::String, arg8: 0x1::type_name::TypeName, arg9: u64, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg12: u64, arg13: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg14: 0x1::type_name::TypeName, arg15: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg16: u64, arg17: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg18: bool, arg19: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg20: u64, arg21: bool, arg22: u64) {
        let v0 = OrderFilled{
            account_object_address  : arg0,
            market_id               : arg1,
            order_id                : arg2,
            order_type              : arg3,
            is_long                 : arg4,
            is_increase             : arg5,
            reduce_only             : arg6,
            symbol                  : arg7,
            wlp_type                : arg8,
            position_id             : arg9,
            filled_price            : arg10,
            filled_size             : arg11,
            fee_amount              : arg12,
            volume_usd              : arg13,
            collateral_type         : arg14,
            new_size                : arg15,
            new_collateral_amount   : arg16,
            entry_borrow_index      : arg17,
            entry_funding_sign      : arg18,
            entry_funding_index     : arg19,
            unrealized_borrow_fee   : arg20,
            unrealized_funding_sign : arg21,
            unrealized_funding_fee  : arg22,
            memo                    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::order_filled(),
        };
        0x2::event::emit<OrderFilled>(v0);
    }

    public(friend) fun emit_order_updated(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: u8, arg6: bool, arg7: bool, arg8: 0x1::option::Option<u64>, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg12: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = OrderUpdated{
            account_object_address : arg0,
            market_id              : arg1,
            order_id               : arg2,
            symbol                 : arg3,
            wlp_type               : arg4,
            order_type             : arg5,
            is_long                : arg6,
            reduce_only            : arg7,
            linked_position_id     : arg8,
            old_size               : arg9,
            new_size               : arg10,
            old_trigger_price      : arg11,
            new_trigger_price      : arg12,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::order_updated(),
        };
        0x2::event::emit<OrderUpdated>(v0);
    }

    public(friend) fun emit_position_closed(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::type_name::TypeName, arg6: bool, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: 0x1::type_name::TypeName, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = PositionClosed{
            account_object_address : arg0,
            market_id              : arg1,
            order_id               : arg2,
            position_id            : arg3,
            symbol                 : arg4,
            wlp_type               : arg5,
            is_long                : arg6,
            size                   : arg7,
            collateral_type        : arg8,
            exit_price             : arg9,
            pnl_amount             : arg10,
            pnl_is_profit          : arg11,
            close_fee_amount       : arg12,
            funding_fee_amount     : arg13,
            funding_fee_is_cost    : arg14,
            borrow_fee_amount      : arg15,
            volume_usd             : arg16,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::position_closed(),
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_position_linked_order_modified(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u128, arg7: bool) {
        let v0 = PositionLinkedOrderModified{
            account_object_address : arg0,
            market_id              : arg1,
            position_id            : arg2,
            symbol                 : arg3,
            wlp_type               : arg4,
            order_id               : arg5,
            linked_order_price_key : arg6,
            is_added               : arg7,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::position_linked_order_modified(arg7),
        };
        0x2::event::emit<PositionLinkedOrderModified>(v0);
    }

    public(friend) fun emit_position_liquidated(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::type_name::TypeName, arg6: bool, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: u64, arg9: 0x1::type_name::TypeName, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg17: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = PositionLiquidated{
            account_object_address : arg0,
            liquidator_address     : arg1,
            market_id              : arg2,
            position_id            : arg3,
            symbol                 : arg4,
            wlp_type               : arg5,
            is_long                : arg6,
            size                   : arg7,
            collateral_amount      : arg8,
            collateral_type        : arg9,
            liquidator_fee_amount  : arg10,
            insurance_fee_amount   : arg11,
            lp_pool_amount         : arg12,
            funding_fee_amount     : arg13,
            funding_fee_is_cost    : arg14,
            borrow_fee_amount      : arg15,
            mark_price             : arg16,
            volume_usd             : arg17,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::position_liquidated(),
        };
        0x2::event::emit<PositionLiquidated>(v0);
    }

    public(friend) fun emit_position_modified(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::type_name::TypeName, arg6: bool, arg7: bool, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: bool, arg11: u64, arg12: u64, arg13: 0x1::type_name::TypeName, arg14: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: bool, arg21: u64, arg22: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg23: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg24: bool, arg25: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg26: u64, arg27: bool, arg28: u64) {
        let v0 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg8, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::collateral_modified(arg10)
        } else {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::position_modified(arg7)
        };
        let v1 = PositionModified{
            account_object_address  : arg0,
            market_id               : arg1,
            order_id                : arg2,
            position_id             : arg3,
            symbol                  : arg4,
            wlp_type                : arg5,
            is_long                 : arg6,
            is_increase             : arg7,
            delta_size              : arg8,
            new_size                : arg9,
            is_deposit              : arg10,
            delta_collateral_amount : arg11,
            new_collateral_amount   : arg12,
            collateral_type         : arg13,
            execution_price         : arg14,
            realized_pnl_amount     : arg15,
            pnl_is_profit           : arg16,
            fee_amount              : arg17,
            close_fee_amount        : arg18,
            funding_fee_amount      : arg19,
            funding_fee_is_cost     : arg20,
            borrow_fee_amount       : arg21,
            volume_usd              : arg22,
            entry_borrow_index      : arg23,
            entry_funding_sign      : arg24,
            entry_funding_index     : arg25,
            unrealized_borrow_fee   : arg26,
            unrealized_funding_sign : arg27,
            unrealized_funding_fee  : arg28,
            memo                    : v0,
        };
        0x2::event::emit<PositionModified>(v1);
    }

    public(friend) fun emit_position_opened(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::type_name::TypeName, arg6: bool, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: u64, arg9: 0x1::type_name::TypeName, arg10: u64, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg12: u64, arg13: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg14: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg15: bool, arg16: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg17: u64, arg18: bool, arg19: u64) {
        let v0 = PositionOpened{
            account_object_address  : arg0,
            market_id               : arg1,
            order_id                : arg2,
            position_id             : arg3,
            symbol                  : arg4,
            wlp_type                : arg5,
            is_long                 : arg6,
            size                    : arg7,
            collateral_amount       : arg8,
            collateral_type         : arg9,
            leverage_bps            : arg10,
            entry_price             : arg11,
            open_fee_amount         : arg12,
            volume_usd              : arg13,
            entry_borrow_index      : arg14,
            entry_funding_sign      : arg15,
            entry_funding_index     : arg16,
            unrealized_borrow_fee   : arg17,
            unrealized_funding_sign : arg18,
            unrealized_funding_fee  : arg19,
            memo                    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::position_opened(),
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public(friend) fun emit_pre_order_cancelled(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::type_name::TypeName, arg6: u8, arg7: bool, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = PreOrderCancelled{
            account_object_address : arg0,
            market_id              : arg1,
            main_order_id          : arg2,
            pre_order_id           : arg3,
            symbol                 : arg4,
            wlp_type               : arg5,
            order_type             : arg6,
            is_long                : arg7,
            size                   : arg8,
            trigger_price          : arg9,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::pre_order_cancelled(),
        };
        0x2::event::emit<PreOrderCancelled>(v0);
    }

    public(friend) fun emit_pre_order_created(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::type_name::TypeName, arg6: u8, arg7: bool, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = PreOrderCreated{
            account_object_address : arg0,
            market_id              : arg1,
            main_order_id          : arg2,
            pre_order_id           : arg3,
            symbol                 : arg4,
            wlp_type               : arg5,
            order_type             : arg6,
            is_long                : arg7,
            size                   : arg8,
            trigger_price          : arg9,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::pre_order_created(),
        };
        0x2::event::emit<PreOrderCreated>(v0);
    }

    public(friend) fun emit_protocol_fee_collected(arg0: u64, arg1: 0x2::object::ID) {
        let v0 = ProtocolFeeCollected{
            amount    : arg0,
            market_id : arg1,
            memo      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::protocol_fee_collected(),
        };
        0x2::event::emit<ProtocolFeeCollected>(v0);
    }

    public(friend) fun emit_token_pool_info_updated(arg0: 0x1::type_name::TypeName, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        let v0 = TokenPoolInfoUpdated{
            token_type                  : arg0,
            token_decimal               : arg1,
            target_weight_bps           : arg2,
            mint_fee_bps                : arg3,
            burn_fee_bps                : arg4,
            max_capacity                : arg5,
            min_deposit                 : arg6,
            basic_borrow_rate_0         : arg7,
            basic_borrow_rate_1         : arg8,
            basic_borrow_rate_2         : arg9,
            utilization_threshold_0_bps : arg10,
            utilization_threshold_1_bps : arg11,
            borrow_interval_ms          : arg12,
            max_reserve_ratio_bps       : arg13,
            memo                        : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::token_pool_info_updated(),
        };
        0x2::event::emit<TokenPoolInfoUpdated>(v0);
    }

    public(friend) fun emit_wlp_equity_changed(arg0: 0x1::string::String, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: bool, arg5: 0x1::string::String) {
        let v0 = WlpEquityChanged{
            market_ticker : arg0,
            wlp_type      : arg1,
            token_type    : arg2,
            amount        : arg3,
            is_profit     : arg4,
            memo          : arg5,
        };
        0x2::event::emit<WlpEquityChanged>(v0);
    }

    public(friend) fun emit_wlp_minted(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = WlpMinted{
            account_object_address : arg0,
            wlp_type               : arg1,
            token_type             : arg2,
            deposit_amount         : arg3,
            wlp_amount             : arg4,
            fee_amount             : arg5,
            share_price            : arg6,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::wlp_minted(),
        };
        0x2::event::emit<WlpMinted>(v0);
    }

    public(friend) fun emit_wlp_redeem_cancelled(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) {
        let v0 = WlpRedeemCancelled{
            account_object_address : arg0,
            wlp_type               : arg1,
            token_type             : arg2,
            request_id             : arg3,
            wlp_amount             : arg4,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::wlp_redeem_cancelled(),
        };
        0x2::event::emit<WlpRedeemCancelled>(v0);
    }

    public(friend) fun emit_wlp_redeem_rejected(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64) {
        let v0 = WlpRedeemRejected{
            account_object_address : arg0,
            operator_address       : arg1,
            wlp_type               : arg2,
            token_type             : arg3,
            request_id             : arg4,
            wlp_amount             : arg5,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::wlp_redeem_rejected(),
        };
        0x2::event::emit<WlpRedeemRejected>(v0);
    }

    public(friend) fun emit_wlp_redeem_requested(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) {
        let v0 = WlpRedeemRequested{
            account_object_address : arg0,
            wlp_type               : arg1,
            token_type             : arg2,
            wlp_amount             : arg3,
            request_id             : arg4,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::wlp_redeem_requested(),
        };
        0x2::event::emit<WlpRedeemRequested>(v0);
    }

    public(friend) fun emit_wlp_redeem_settled(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = WlpRedeemSettled{
            account_object_address : arg0,
            wlp_type               : arg1,
            token_type             : arg2,
            request_id             : arg3,
            redeem_amount          : arg4,
            fee_amount             : arg5,
            share_price            : arg6,
            memo                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo::wlp_redeem_settled(),
        };
        0x2::event::emit<WlpRedeemSettled>(v0);
    }

    // decompiled from Move bytecode v7
}

