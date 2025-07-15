module 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::fee {
    struct TradingFeeConfig has key {
        id: 0x2::object::UID,
        default_fees: PoolFeeConfig,
        pool_specific_fees: 0x2::table::Table<0x2::object::ID, PoolFeeConfig>,
    }

    struct PoolFeeConfig has copy, drop, store {
        deep_fee_type_taker_rate: u64,
        deep_fee_type_maker_rate: u64,
        input_coin_fee_type_taker_rate: u64,
        input_coin_fee_type_maker_rate: u64,
        max_deep_fee_discount_rate: u64,
    }

    struct DefaultFeesUpdated has copy, drop {
        new_fees: PoolFeeConfig,
    }

    struct PoolFeesUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        new_fees: PoolFeeConfig,
    }

    public(friend) fun calculate_deep_reserves_coverage_order_fee(arg0: u64, arg1: u64) : u64 {
        0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg1, arg0)
    }

    public(friend) fun calculate_fee_by_rate(arg0: u64, arg1: u64) : u64 {
        0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_input_coin_deepbook_fee(arg0: u64, arg1: u64) : u64 {
        calculate_fee_by_rate(arg0, 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()))
    }

    public(friend) fun calculate_protocol_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64) {
        assert!(arg0 + arg1 <= 1000000000, 6);
        assert!(arg4 > 0, 7);
        let v0 = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::apply_discount(calculate_fee_by_rate(0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg4, arg0), arg2), arg5);
        let v1 = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::apply_discount(calculate_fee_by_rate(0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg4, arg1), arg3), arg5);
        (v0 + v1, v0, v1)
    }

    public(friend) fun charge_swap_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_fee_by_rate(0x2::balance::value<T0>(v0), arg1))
    }

    public fun deep_fee_type_rates(arg0: PoolFeeConfig) : (u64, u64) {
        (arg0.deep_fee_type_taker_rate, arg0.deep_fee_type_maker_rate)
    }

    public fun estimate_full_fee_limit<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &TradingFeeConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        let v0 = get_pool_fee_config<T0, T1>(arg4, arg0);
        let (v1, _) = deep_fee_type_rates(v0);
        let v3 = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::calculate_deep_required<T0, T1>(arg0, arg7, arg8);
        let (v4, v5, v6, v7) = estimate_full_order_fee_core(arg5, arg6, v3, 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::get_sui_per_deep<T2, T3>(arg2, arg3, arg1, arg10), v1, 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::calculate_order_amount(arg7, arg8, arg9), max_deep_fee_discount_rate(v0));
        (v4, v5, v6, v3, v7)
    }

    public fun estimate_full_fee_market<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &TradingFeeConfig, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        let v0 = get_pool_fee_config<T0, T1>(arg4, arg0);
        let (v1, _) = deep_fee_type_rates(v0);
        let (_, v4) = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::calculate_market_order_params<T0, T1>(arg0, arg7, arg8, arg9);
        let (v5, v6, v7, v8) = estimate_full_order_fee_core(arg5, arg6, v4, 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::get_sui_per_deep<T2, T3>(arg2, arg3, arg1, arg9), v1, arg7, max_deep_fee_discount_rate(v0));
        (v5, v6, v7, v4, v8)
    }

    public(friend) fun estimate_full_order_fee_core(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64, u64, u64) {
        let v0 = if (arg0 + arg1 < arg2) {
            arg2 - arg0 - arg1
        } else {
            0
        };
        let v1 = calculate_deep_reserves_coverage_order_fee(arg3, v0);
        let v2 = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper::calculate_discount_rate(arg6, v0, arg2);
        let (v3, _, _) = calculate_protocol_fees(1000000000, 0, arg4, 0, arg5, v2);
        (v1 + v3, v1, v3, v2)
    }

    public fun get_pool_fee_config<T0, T1>(arg0: &TradingFeeConfig, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : PoolFeeConfig {
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1);
        if (0x2::table::contains<0x2::object::ID, PoolFeeConfig>(&arg0.pool_specific_fees, v0)) {
            *0x2::table::borrow<0x2::object::ID, PoolFeeConfig>(&arg0.pool_specific_fees, v0)
        } else {
            arg0.default_fees
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolFeeConfig{
            deep_fee_type_taker_rate       : 600000,
            deep_fee_type_maker_rate       : 300000,
            input_coin_fee_type_taker_rate : 500000,
            input_coin_fee_type_maker_rate : 200000,
            max_deep_fee_discount_rate     : 250000000,
        };
        let v1 = TradingFeeConfig{
            id                 : 0x2::object::new(arg0),
            default_fees       : v0,
            pool_specific_fees : 0x2::table::new<0x2::object::ID, PoolFeeConfig>(arg0),
        };
        0x2::transfer::share_object<TradingFeeConfig>(v1);
    }

    public fun input_coin_fee_type_rates(arg0: PoolFeeConfig) : (u64, u64) {
        (arg0.input_coin_fee_type_taker_rate, arg0.input_coin_fee_type_maker_rate)
    }

    public fun max_deep_fee_discount_rate(arg0: PoolFeeConfig) : u64 {
        arg0.max_deep_fee_discount_rate
    }

    public fun new_pool_fee_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : PoolFeeConfig {
        let v0 = PoolFeeConfig{
            deep_fee_type_taker_rate       : arg0,
            deep_fee_type_maker_rate       : arg1,
            input_coin_fee_type_taker_rate : arg2,
            input_coin_fee_type_maker_rate : arg3,
            max_deep_fee_discount_rate     : arg4,
        };
        validate_pool_fee_config(&v0);
        v0
    }

    public fun update_default_fees(arg0: &mut TradingFeeConfig, arg1: 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::ticket::AdminTicket, arg2: PoolFeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_pool_fee_config(&arg2);
        0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::ticket::validate_ticket(&arg1, 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::ticket::update_default_fees_ticket_type(), arg3, arg4);
        0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::ticket::destroy_ticket(arg1);
        arg0.default_fees = arg2;
        let v0 = DefaultFeesUpdated{new_fees: arg2};
        0x2::event::emit<DefaultFeesUpdated>(v0);
    }

    public fun update_pool_specific_fees<T0, T1>(arg0: &mut TradingFeeConfig, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: PoolFeeConfig) {
        validate_pool_fee_config(&arg2);
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1);
        if (0x2::table::contains<0x2::object::ID, PoolFeeConfig>(&arg0.pool_specific_fees, v0)) {
            0x2::table::remove<0x2::object::ID, PoolFeeConfig>(&mut arg0.pool_specific_fees, v0);
        };
        0x2::table::add<0x2::object::ID, PoolFeeConfig>(&mut arg0.pool_specific_fees, v0, arg2);
        let v1 = PoolFeesUpdated{
            pool_id  : v0,
            new_fees : arg2,
        };
        0x2::event::emit<PoolFeesUpdated>(v1);
    }

    fun validate_discount_rate(arg0: u64) {
        assert!(arg0 % 1000 == 0, 4);
        assert!(arg0 >= 0 && arg0 <= 1000000000, 5);
    }

    fun validate_fee_pair(arg0: u64, arg1: u64) {
        assert!(arg0 % 1000 == 0, 1);
        assert!(arg1 % 1000 == 0, 1);
        assert!(arg0 >= 0 && arg0 <= 2000000, 2);
        assert!(arg1 >= 0 && arg1 <= 1000000, 2);
        assert!(arg1 <= arg0, 3);
    }

    fun validate_pool_fee_config(arg0: &PoolFeeConfig) {
        validate_fee_pair(arg0.deep_fee_type_taker_rate, arg0.deep_fee_type_maker_rate);
        validate_fee_pair(arg0.input_coin_fee_type_taker_rate, arg0.input_coin_fee_type_maker_rate);
        validate_discount_rate(arg0.max_deep_fee_discount_rate);
    }

    // decompiled from Move bytecode v6
}

