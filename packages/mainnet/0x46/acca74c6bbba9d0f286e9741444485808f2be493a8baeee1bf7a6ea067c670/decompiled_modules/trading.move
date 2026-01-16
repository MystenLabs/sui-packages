module 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::trading {
    struct MarketRegistry has key {
        id: 0x2::object::UID,
        referral_registry: 0x2::object::UID,
        markets: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::LinkedObjectTable<u64, Markets>,
        num_market: u64,
        u64_padding: vector<u64>,
    }

    struct Markets has store, key {
        id: 0x2::object::UID,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
        is_active: bool,
        protocol_fee_share_bp: u64,
        symbols: vector<0x1::type_name::TypeName>,
        symbol_markets: 0x2::object_table::ObjectTable<0x1::type_name::TypeName, SymbolMarket>,
        u64_padding: vector<u64>,
    }

    struct SymbolMarket has store, key {
        id: 0x2::object::UID,
        user_positions: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector,
        token_collateral_orders: 0x2::object::UID,
        option_collateral_orders: 0x2::object::UID,
        market_info: MarketInfo,
        market_config: MarketConfig,
    }

    struct MarketInfo has copy, drop, store {
        is_active: bool,
        size_decimal: u64,
        user_long_position_size: u64,
        user_short_position_size: u64,
        next_position_id: u64,
        user_long_order_size: u64,
        user_short_order_size: u64,
        next_order_id: u64,
        last_funding_ts_ms: u64,
        cumulative_funding_rate_index_sign: bool,
        cumulative_funding_rate_index: u64,
        previous_last_funding_ts_ms: u64,
        previous_cumulative_funding_rate_index_sign: bool,
        previous_cumulative_funding_rate_index: u64,
        u64_padding: vector<u64>,
    }

    struct MarketConfig has copy, drop, store {
        oracle_id: address,
        max_leverage_mbp: u64,
        option_collateral_max_leverage_mbp: u64,
        min_size: u64,
        lot_size: u64,
        trading_fee_config: vector<u64>,
        basic_funding_rate: u64,
        funding_interval_ts_ms: u64,
        exp_multiplier: u64,
        u64_padding: vector<u64>,
    }

    struct USD has drop {
        dummy_field: bool,
    }

    struct NewMarketsEvent has copy, drop {
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
        protocol_fee_share_bp: u64,
        u64_padding: vector<u64>,
    }

    struct AddTradingSymbolEvent has copy, drop {
        index: u64,
        base_token_type: 0x1::type_name::TypeName,
        market_info: MarketInfo,
        market_config: MarketConfig,
        u64_padding: vector<u64>,
    }

    struct UpdateProtocolFeeShareBpEvent has copy, drop {
        index: u64,
        previous_protocol_fee_share_bp: u64,
        new_protocol_fee_share_bp: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateMarketConfigEvent has copy, drop {
        index: u64,
        base_token_type: 0x1::type_name::TypeName,
        previous_market_config: MarketConfig,
        new_market_config: MarketConfig,
        u64_padding: vector<u64>,
    }

    struct SuspendMarketEvent has copy, drop {
        index: u64,
        u64_padding: vector<u64>,
    }

    struct ResumeMarketEvent has copy, drop {
        index: u64,
        u64_padding: vector<u64>,
    }

    struct SuspendTradingSymbolEvent has copy, drop {
        index: u64,
        suspended_base_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct ResumeTradingSymbolEvent has copy, drop {
        index: u64,
        resumed_base_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct CreateTradingOrderEvent has copy, drop {
        user: address,
        market_index: u64,
        pool_index: u64,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        order_id: u64,
        linked_position_id: 0x1::option::Option<u64>,
        collateral_amount: u64,
        leverage_mbp: u64,
        reduce_only: bool,
        is_long: bool,
        is_stop_order: bool,
        size: u64,
        trigger_price: u64,
        trading_pair_oracle_price: u64,
        filled: bool,
        filled_price: 0x1::option::Option<u64>,
        u64_padding: vector<u64>,
    }

    struct ManagerCancelOrdersEvent has copy, drop {
        reason: 0x1::string::String,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        order_type_tag: u8,
        order_id: u64,
        order_size: u64,
        order_price: u64,
        u64_padding: vector<u64>,
    }

    struct CancelTradingOrderEvent has copy, drop {
        user: address,
        market_index: u64,
        order_id: u64,
        trigger_price: u64,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        released_collateral_amount: u64,
        u64_padding: vector<u64>,
    }

    struct ReleaseCollateralEvent has copy, drop {
        user: address,
        market_index: u64,
        pool_index: u64,
        position_id: u64,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        released_collateral_amount: u64,
        remaining_collateral_amount: u64,
        u64_padding: vector<u64>,
    }

    struct IncreaseCollateralEvent has copy, drop {
        user: address,
        market_index: u64,
        pool_index: u64,
        position_id: u64,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        increased_collateral_amount: u64,
        remaining_collateral_amount: u64,
        u64_padding: vector<u64>,
    }

    struct CreateTradingOrderWithBidReceiptsEvent has copy, drop {
        user: address,
        market_index: u64,
        pool_index: u64,
        dov_index: u64,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        order_id: u64,
        collateral_in_deposit_token: u64,
        is_long: bool,
        size: u64,
        trigger_price: u64,
        filled: bool,
        filled_price: 0x1::option::Option<u64>,
        u64_padding: vector<u64>,
    }

    struct MatchTradingOrderEvent has copy, drop {
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        matched_order_ids: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct ManagerReducePositionEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        position_id: u64,
        reduced_size: u64,
        collateral_price: u64,
        trading_price: u64,
        cancelled_order_ids: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct ManagerClearPositionEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        position_id: u64,
        removed_size: u64,
        cancelled_order_ids: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct ManagerCloseOptionPositionEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        position_id: u64,
        order_size: u64,
        collateral_price: u64,
        trading_price: u64,
        cancelled_order_ids: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct LiquidationInfo has copy, drop {
        position_id: u64,
        dov_index: 0x1::option::Option<u64>,
        bid_token: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct LiquidateEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        position_id: u64,
        collateral_price: u64,
        trading_price: u64,
        realized_liquidator_fee: u64,
        realized_value_for_lp_pool: u64,
        u64_padding: vector<u64>,
    }

    struct SettleReceiptCollateralEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        position_id: u64,
        realized_liquidator_fee: u64,
        remaining_unrealized_sign: bool,
        remaining_unrealized_value: u64,
        remaining_value_for_lp_pool: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateFundingRateEvent has copy, drop {
        base_token: 0x1::type_name::TypeName,
        new_funding_ts_ms: u64,
        intervals_count: u64,
        previous_cumulative_funding_rate_index_sign: bool,
        previous_cumulative_funding_rate_index: u64,
        cumulative_funding_rate_index_sign: bool,
        cumulative_funding_rate_index: u64,
        u64_padding: vector<u64>,
    }

    struct ExpiredPositionInfo has copy, drop {
        position_id: u64,
        dov_index: u64,
        collateral_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
    }

    struct RealizeOptionPositionEvent has copy, drop {
        position_user: address,
        position_id: u64,
        trading_symbol: 0x1::type_name::TypeName,
        realize_balance_token_type: 0x1::type_name::TypeName,
        exercise_balance_value: u64,
        user_remaining_value: u64,
        user_remaining_in_usd: u64,
        realized_loss_value: u64,
        fee_value: u64,
        realized_trading_fee: u64,
        realized_borrow_fee: u64,
        u64_padding: vector<u64>,
    }

    public fun increase_collateral<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, 0x1::option::some<u64>(arg8), arg10);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).symbol_markets, v1);
        assert!(v2.market_info.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_inactive());
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v3 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v4 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v3, 0x1::type_name::with_defining_ids<T0>());
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v2.user_positions, arg8);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v8, v9) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v10 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(v5);
        let v11 = 0x2::coin::value<T0>(&arg9);
        let v12 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(v5);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::increase_collateral<T0>(v5, 0x2::coin::into_balance<T0>(arg9), v6, v7, v8, v9);
        let v13 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(v5);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_reserve_amount<T0>(v3, v13 > v12, 0x1::u64::diff(v13, v12));
        let (_, _, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v5, v6, v7, v8, v9, v4, v2.market_info.cumulative_funding_rate_index_sign, v2.market_info.cumulative_funding_rate_index);
        let v17 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v3, v0);
        assert!(!0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_position_liquidated(v5, v6, v7, v8, v9, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v2.market_config.u64_padding, 7), v2.market_info.user_long_position_size, v2.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v17, 1), v2.market_info.size_decimal, v8, v9, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v5), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v5), v2.market_config.trading_fee_config), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v2.market_config.u64_padding, 2), v4, v2.market_info.cumulative_funding_rate_index_sign, v2.market_info.cumulative_funding_rate_index), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::remaining_collateral_not_enough());
        let v18 = IncreaseCollateralEvent{
            user                        : 0x2::tx_context::sender(arg10),
            market_index                : arg6,
            pool_index                  : arg7,
            position_id                 : arg8,
            collateral_token            : v0,
            base_token                  : v1,
            increased_collateral_amount : v11,
            remaining_collateral_amount : v10 + v11,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<IncreaseCollateralEvent>(v18);
    }

    public fun release_collateral<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, 0x1::option::some<u64>(arg8), arg10);
        let (v0, v1) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = 0x1::type_name::with_defining_ids<T1>();
        let v6 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).symbol_markets, v5);
        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v6.user_positions, arg8);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v8 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v9 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v8, v4);
        let (_, _, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v7, v0, v1, v2, v3, v9, v6.market_info.cumulative_funding_rate_index_sign, v6.market_info.cumulative_funding_rate_index);
        assert!(get_max_releasing_collateral_amount_(v8, v7, &v6.market_info, &v6.market_config, v4, v0, v1, v2, v3, v9) >= arg9, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_leverage());
        let v13 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(v7);
        assert!(v13 >= arg9, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::remaining_collateral_not_enough());
        let v14 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(v7);
        let v15 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(v7);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_reserve_amount<T0>(v8, v15 > v14, 0x1::u64::diff(v15, v14));
        let v16 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v8, v4);
        assert!(!0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_position_liquidated(v7, v0, v1, v2, v3, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v6.market_config.u64_padding, 7), v6.market_info.user_long_position_size, v6.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v16, 1), v6.market_info.size_decimal, v2, v3, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v7), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v7), v6.market_config.trading_fee_config), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v6.market_config.u64_padding, 2), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v8, v4), v6.market_info.cumulative_funding_rate_index_sign, v6.market_info.cumulative_funding_rate_index), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::remaining_collateral_not_enough());
        let v17 = ReleaseCollateralEvent{
            user                        : 0x2::tx_context::sender(arg10),
            market_index                : arg6,
            pool_index                  : arg7,
            position_id                 : arg8,
            collateral_token            : v4,
            base_token                  : v5,
            released_collateral_amount  : arg9,
            remaining_collateral_amount : v13 - arg9,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ReleaseCollateralEvent>(v17);
        0x2::coin::from_balance<T0>(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::release_collateral<T0>(v7, arg9, v0, v1, v2, v3), arg10)
    }

    entry fun add_trading_symbol<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg21);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_existed());
        validate_trading_fee_config(&arg9);
        validate_trading_fee_config(&arg17);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.symbols, v1);
        let v2 = 0x2::clock::timestamp_ms(arg20) / arg11 * arg11;
        let v3 = MarketInfo{
            is_active                                   : true,
            size_decimal                                : arg3,
            user_long_position_size                     : 0,
            user_short_position_size                    : 0,
            next_position_id                            : 0,
            user_long_order_size                        : 0,
            user_short_order_size                       : 0,
            next_order_id                               : 0,
            last_funding_ts_ms                          : v2,
            cumulative_funding_rate_index_sign          : true,
            cumulative_funding_rate_index               : 0,
            previous_last_funding_ts_ms                 : v2 - arg11,
            previous_cumulative_funding_rate_index_sign : true,
            previous_cumulative_funding_rate_index      : 0,
            u64_padding                                 : 0x1::vector::empty<u64>(),
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg13);
        0x1::vector::push_back<u64>(v5, arg14);
        0x1::vector::push_back<u64>(v5, arg15);
        0x1::vector::push_back<u64>(v5, arg16);
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg17, 0));
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg17, 1));
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg17, 2));
        0x1::vector::push_back<u64>(v5, arg18);
        0x1::vector::push_back<u64>(v5, arg19);
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg17, 3));
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg17, 4));
        let v6 = MarketConfig{
            oracle_id                          : 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4),
            max_leverage_mbp                   : arg5,
            option_collateral_max_leverage_mbp : arg6,
            min_size                           : arg7,
            lot_size                           : arg8,
            trading_fee_config                 : arg9,
            basic_funding_rate                 : arg10,
            funding_interval_ts_ms             : arg11,
            exp_multiplier                     : arg12,
            u64_padding                        : v4,
        };
        let v7 = SymbolMarket{
            id                       : 0x2::object::new(arg21),
            user_positions           : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(1000, arg21),
            token_collateral_orders  : 0x2::object::new(arg21),
            option_collateral_orders : 0x2::object::new(arg21),
            market_info              : v3,
            market_config            : v6,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.option_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.option_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.option_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v7.option_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"), 0x2::vec_map::empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>());
        let v8 = AddTradingSymbolEvent{
            index           : arg2,
            base_token_type : v1,
            market_info     : v7.market_info,
            market_config   : v7.market_config,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<AddTradingSymbolEvent>(v8);
        0x2::object_table::add<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1, v7);
    }

    fun adjust_market_info_user_order_size(arg0: &mut SymbolMarket, arg1: bool, arg2: bool, arg3: u64) {
        if (arg1) {
            let v0 = if (arg2) {
                arg0.market_info.user_long_order_size - arg3
            } else {
                arg0.market_info.user_long_order_size + arg3
            };
            arg0.market_info.user_long_order_size = v0;
        } else {
            let v1 = if (arg2) {
                arg0.market_info.user_short_order_size - arg3
            } else {
                arg0.market_info.user_short_order_size + arg3
            };
            arg0.market_info.user_short_order_size = v1;
        };
    }

    fun adjust_market_info_user_position_size(arg0: &mut SymbolMarket, arg1: bool, arg2: bool, arg3: u64) {
        if (arg2) {
            if (arg1) {
                arg0.market_info.user_short_position_size = arg0.market_info.user_short_position_size - arg3;
            } else {
                arg0.market_info.user_long_position_size = arg0.market_info.user_long_position_size - arg3;
            };
        } else if (arg1) {
            arg0.market_info.user_long_position_size = arg0.market_info.user_long_position_size + arg3;
        } else {
            arg0.market_info.user_short_position_size = arg0.market_info.user_short_position_size + arg3;
        };
    }

    public(friend) fun calculate_trading_fee_rate_mbp(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: vector<u64>) : u64 {
        let (v0, v1) = if (arg1 > arg2) {
            (false, arg1 - arg2)
        } else {
            (true, arg2 - arg1)
        };
        let v2 = if (v0 == arg7) {
            let (v3, v4) = if (v1 > arg8) {
                (v0, v1 - arg8)
            } else {
                (!v0, arg8 - v1)
            };
            let _ = v3;
            v4
        } else {
            let _ = v0;
            v1 + arg8
        };
        if (arg0 == 0) {
            if (v2 <= v1) {
                *0x1::vector::borrow<u64>(&arg9, 0)
            } else {
                let v7 = *0x1::vector::borrow<u64>(&arg9, 0);
                let v8 = *0x1::vector::borrow<u64>(&arg9, 1);
                let v9 = (((arg3 as u128) * (*0x1::vector::borrow<u64>(&arg9, 2) as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128)) as u64);
                if (v9 > 0) {
                    0x1::u64::min(v8, v7 + ((((v8 - v7) as u128) * ((((0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v2 - v1, arg4, arg5, arg6) as u128) * (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128) / (v9 as u128)) as u64) as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128)) as u64))
                } else {
                    v7
                }
            }
        } else if (v2 <= v1) {
            *0x1::vector::borrow<u64>(&arg9, 0)
        } else {
            let v10 = *0x1::vector::borrow<u64>(&arg9, 0);
            let v11 = *0x1::vector::borrow<u64>(&arg9, 1);
            let v12 = (((arg3 as u128) * (*0x1::vector::borrow<u64>(&arg9, 2) as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128)) as u64);
            let v13 = if (v12 > 0) {
                (((0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128) * (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v2 - v1, arg4, arg5, arg6) as u128) / (v12 as u128)) as u64)
            } else {
                0
            };
            let v14 = 0x1::u64::min(v13 / *0x1::vector::borrow<u64>(&arg9, 4), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale());
            let v15 = v14;
            let v16 = 1;
            while (v16 < *0x1::vector::borrow<u64>(&arg9, 3)) {
                let v17 = (v15 as u128) * (v14 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128);
                v15 = (v17 as u64);
                v16 = v16 + 1;
            };
            0x1::u64::min(v11, v10 + ((((v11 - v10) as u128) * (v15 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128)) as u64))
        }
    }

    public fun cancel_linked_orders<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg6);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v3, remove_linked_orders<T0>(arg0, arg2, v2, arg3, arg4, arg5));
        if (0x2::balance::value<T0>(&v3) > 0) {
            return_to_user<T0>(v3, arg5, arg6);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public fun cancel_trading_order<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (0x1::option::is_some<address>(&arg5)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg6);
            0x1::option::extract<address>(&mut arg5)
        } else {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
            0x2::tx_context::sender(arg6)
        };
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v2), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v2);
        let v4 = take_order_by_order_id_and_price(v3, arg4, arg3, true, v0);
        assert!(0x1::option::is_some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v4), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::order_not_found());
        let v5 = 0x1::option::destroy_some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v4);
        let v6 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(&v5);
        adjust_market_info_user_order_size(v3, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_side(&v5), true, v6);
        let v7 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(&v5);
        if (0x1::option::is_some<u64>(&v7)) {
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v3.user_positions, 0x1::option::extract<u64>(&mut v7));
            check_position_user_matched(v8, v0);
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_position_linked_order_info(v8, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_id(&v5));
        };
        let v9 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_order<T0>(arg0, v5);
        let v10 = CancelTradingOrderEvent{
            user                       : v0,
            market_index               : arg2,
            order_id                   : arg3,
            trigger_price              : arg4,
            collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
            base_token                 : v2,
            released_collateral_amount : 0x2::balance::value<T0>(&v9),
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CancelTradingOrderEvent>(v10);
        if (v0 != 0x2::tx_context::sender(arg6)) {
            let v11 = ManagerCancelOrdersEvent{
                reason           : 0x1::string::utf8(b"manager"),
                collateral_token : 0x1::type_name::with_defining_ids<T0>(),
                base_token       : v2,
                order_type_tag   : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_type_tag(&v5),
                order_id         : arg3,
                order_size       : v6,
                order_price      : arg4,
                u64_padding      : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<ManagerCancelOrdersEvent>(v11);
        };
        0x2::coin::from_balance<T0>(v9, arg6)
    }

    fun check_collateral_enough_when_adding_position<T0>(arg0: &SymbolMarket, arg1: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
            check_position_user_matched(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(arg1));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(v2)
        } else {
            0
        };
        let (v3, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_trading_fee(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(arg1), arg0.market_info.size_decimal, arg2, arg3, arg4, arg5, arg6, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_token_decimal(arg1));
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_amount<T0>(arg1) + v1 > v3
    }

    fun check_collateral_enough_when_reducing_position<T0>(arg0: &SymbolMarket, arg1: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(arg1);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
        check_position_user_matched(v1, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(arg1));
        let (v2, v3, v4) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_unrealized_pnl(v1, arg4, arg5, arg6);
        let (v5, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_trading_fee(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(arg1), arg0.market_info.size_decimal, arg2, arg3, arg4, arg5, arg6, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_token_decimal(arg1));
        v2 && 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_amount<T0>(arg1) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(v1) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount(v3 + v4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_decimal(v1), arg2, arg3) > v5 || v3 >= v4 && 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_amount<T0>(arg1) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(v1) > 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount(v3 - v4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_decimal(v1), arg2, arg3) + v5 || 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_amount<T0>(arg1) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(v1) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount(v4 - v3, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_decimal(v1), arg2, arg3) > v5
    }

    fun check_option_collateral_enough<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &SymbolMarket, arg4: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock) : bool {
        let v0 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(arg4);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&arg3.user_positions, 0x1::option::extract<u64>(&mut v0));
            check_position_user_matched(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(arg4));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_option_position_collateral_amount<T0>(arg0, arg1, arg2, v2, arg10)
        } else {
            0
        };
        let (v3, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_trading_fee(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(arg4), arg3.market_info.size_decimal, arg5, arg6, arg7, arg8, arg9, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_token_decimal(arg4));
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_option_collateral_order_collateral_amount<T0>(arg0, arg1, arg2, arg4, arg10) + v1 > v3
    }

    fun check_position_user_matched(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position, arg1: address) {
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(arg0) == arg1, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::user_mismatched());
    }

    fun check_reserve_enough<T0>(arg0: &SymbolMarket, arg1: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::LiquidityPool, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_reduce_only(arg2)) {
            true
        } else {
            let v1 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(arg1, 0x1::type_name::with_defining_ids<T0>());
            let v2 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(arg2);
            let v3 = 0;
            let v4 = if (0x1::option::is_some<u64>(&v2)) {
                let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v2));
                v3 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(v5);
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v5) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(arg2), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size_decimal(v5), arg5, arg6)
            } else {
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(arg2), arg0.market_info.size_decimal, arg5, arg6)
            };
            let v6 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount(v4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_token_decimal(arg2), arg3, arg4);
            v6 > v3 && *0x1::vector::borrow<u64>(&v1, 0) >= *0x1::vector::borrow<u64>(&v1, 2) + v6 - v3 || true
        }
    }

    public fun collect_position_funding_fee<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, 0x1::option::some<u64>(arg8), arg9);
        let v0 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).symbol_markets, 0x1::type_name::with_defining_ids<T1>());
        assert!(v0.market_info.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_inactive());
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v1 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v2 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v1, 0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v0.user_positions, arg8);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let (_, _, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v3, v4, v5, v6, v7, v2, v0.market_info.cumulative_funding_rate_index_sign, v0.market_info.cumulative_funding_rate_index);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::realize_funding_fee<T0>(v1, v3, v4, v5, arg9);
        let v11 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v1, 0x1::type_name::with_defining_ids<T0>());
        assert!(!0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_position_liquidated(v3, v4, v5, v6, v7, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v0.market_config.u64_padding, 7), v0.market_info.user_long_position_size, v0.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v11, 1), v0.market_info.size_decimal, v6, v7, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v3), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v3), v0.market_config.trading_fee_config), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v0.market_config.u64_padding, 2), v2, v0.market_info.cumulative_funding_rate_index_sign, v0.market_info.cumulative_funding_rate_index), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::remaining_collateral_not_enough());
    }

    public fun create_trading_order<T0, T1>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x2::coin::Coin<T0>, arg10: bool, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg15);
        if (!arg10) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::check_token_pool_status<T0>(arg2, arg7, true);
        };
        if (arg10) {
            assert!(0x1::option::is_some<u64>(&arg8), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::position_id_needed_with_reduce_only_order());
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        let v4 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v3.symbol_markets, v1);
        assert!(v4.market_info.is_active || !v4.market_info.is_active && arg10, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_inactive());
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let (v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v7, v8) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v9 = 0x2::coin::into_balance<T0>(arg9);
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::with_defining_ids<T0>());
        let v12 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v10, v11, v5, v6);
        let v13 = if (arg11) {
            if (arg12) {
                0x1::u64::max(arg14, v7)
            } else {
                0x1::u64::min(arg14, v7)
            }
        } else if (arg12) {
            0x1::u64::min(arg14, v7)
        } else {
            0x1::u64::max(arg14, v7)
        };
        let v14 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(arg13, v4.market_info.size_decimal, v13, v8);
        let v15 = if (v12 > 0) {
            let v16 = (((v14 as u128) * (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128) / (v12 as u128)) as u64);
            assert!(v4.market_config.max_leverage_mbp >= v16, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_leverage());
            v16
        } else {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale()
        };
        assert!(arg10 && 0x1::option::is_some<u64>(&arg8) && arg13 % v4.market_config.lot_size == 0 || arg13 >= v4.market_config.min_size && arg13 % v4.market_config.lot_size == 0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::invalid_order_size());
        let v17 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v18 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount(v14, v11, v5, v6);
        let v19 = if (0x1::option::is_some<u64>(&arg8)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_amount<T0>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v4.user_positions, *0x1::option::borrow<u64>(&arg8)))
        } else {
            0
        };
        let v20 = if (v10 + v19 >= v18) {
            0
        } else {
            v18 - v10 - v19
        };
        assert!(!arg10 && 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::check_trading_order_size_valid(v17, v2, v20) || true, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::reach_max_single_order_reserve_usage());
        let v21 = v4.market_info.next_order_id;
        if (0x1::option::is_some<u64>(&arg8)) {
            let v22 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v4.user_positions, *0x1::option::borrow<u64>(&arg8));
            check_position_user_matched(v22, v0);
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::add_position_linked_order_info(v22, v21, arg14);
        } else if (arg11) {
            assert!(v4.market_info.user_long_position_size + arg13 <= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v4.market_config.u64_padding, 0), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_open_interest());
        } else {
            assert!(v4.market_info.user_short_position_size + arg13 <= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v4.market_config.u64_padding, 1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_open_interest());
        };
        let v23 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::create_order<T0>(arg0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::symbol::create(v1, v3.quote_token_type), v15, arg10, arg11, arg12, arg13, v4.market_info.size_decimal, arg14, v9, v11, arg8, v21, v7, arg5, arg15);
        let v24 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v17, v2);
        if (arg10) {
            assert!(check_collateral_enough_when_reducing_position<T0>(v4, &v23, v5, v6, v7, v8, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v4.market_config.u64_padding, 7), v4.market_info.user_long_position_size, v4.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v24, 1), v4.market_info.size_decimal, v7, v8, arg11, arg13, v4.market_config.trading_fee_config)), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::token_collateral_not_enough());
        } else {
            assert!(check_collateral_enough_when_adding_position<T0>(v4, &v23, v5, v6, v7, v8, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v4.market_config.u64_padding, 7), v4.market_info.user_long_position_size, v4.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v24, 1), v4.market_info.size_decimal, v7, v8, arg11, arg13, v4.market_config.trading_fee_config)), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::token_collateral_not_enough());
        };
        assert!(check_reserve_enough<T0>(v4, v17, &v23, v5, v6, v7, v8), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_pool_reserve_not_enough());
        v4.market_info.next_order_id = v4.market_info.next_order_id + 1;
        let v25 = CreateTradingOrderEvent{
            user                      : v0,
            market_index              : arg6,
            pool_index                : arg7,
            collateral_token          : 0x1::type_name::with_defining_ids<T0>(),
            base_token                : v1,
            order_id                  : v21,
            linked_position_id        : arg8,
            collateral_amount         : v10,
            leverage_mbp              : v15,
            reduce_only               : arg10,
            is_long                   : arg11,
            is_stop_order             : arg12,
            size                      : arg13,
            trigger_price             : arg14,
            trading_pair_oracle_price : v7,
            filled                    : false,
            filled_price              : 0x1::option::none<u64>(),
            u64_padding               : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderEvent>(v25);
        adjust_market_info_user_order_size(v4, arg11, false, arg13);
        let v26 = get_mut_orders(v4, true, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_type_tag(&v23));
        if (!0x2::vec_map::contains<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v26, &arg14)) {
            0x2::vec_map::insert<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v26, arg14, 0x1::vector::singleton<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v23));
        } else {
            0x1::vector::push_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(0x2::vec_map::get_mut<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v26, &arg14), v23);
        };
    }

    public fun create_trading_order_with_bid_receipt<T0, T1, T2>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg14: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt, arg15: bool, arg16: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T2>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, 0x1::option::none<u64>(), arg16);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_info.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_inactive());
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_token_decimal(arg2, arg8, v3);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::check_token_pool_status<T0>(arg2, arg8, true);
        let (_, v6, v7) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_bid_receipt_info(&arg14);
        let v8 = v7;
        let v9 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::verify_bid_receipt_collateral_trading_order_v2<T0, T2>(arg3, arg5, arg4, &arg14, arg15, arg6);
        if (v9 == b"E_BID_RECEIPT_HAS_BEEN_EXPIRED") {
            abort 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::bid_receipt_has_been_expired()
        };
        if (v9 == b"E_AUCTION_NOT_YET_ENDED") {
            abort 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::auction_not_yet_ended()
        };
        if (v9 == b"E_BID_RECEIPT_NOT_ITM") {
            abort 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::bid_receipt_not_itm()
        };
        if (v9 == b"E_BASE_TOKEN_MISMATCHED") {
            abort 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::base_token_mismatched()
        };
        if (v9 == b"E_INVALID_ORDER_SIDE") {
            abort 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::invalid_order_side()
        };
        if (v9 == b"E_COLLATERAL_TOKEN_TYPE_MISMATCHED") {
            abort 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::collateral_token_type_mismatched()
        };
        let v10 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_receipt_intrinsic_value_v2<T0>(arg3, arg5, arg4, &arg14, arg6);
        let v11 = *0x1::vector::borrow<u64>(&v8, 0);
        assert!(v11 >= v2.market_config.min_size && v11 % v2.market_config.lot_size == 0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::invalid_order_size());
        if (arg15) {
            assert!(v2.market_info.user_long_position_size + v11 <= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v2.market_config.u64_padding, 0), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_open_interest());
        } else {
            assert!(v2.market_info.user_short_position_size + v11 <= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v2.market_config.u64_padding, 1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_open_interest());
        };
        let (v12, v13) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v14, v15) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v16 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v11, v2.market_info.size_decimal, v14, v15), v4, v12, v13);
        let v17 = if (v10 >= v16) {
            0
        } else {
            v16 - v10
        };
        let v18 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::check_trading_order_size_valid(v18, v3, v17), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::reach_max_single_order_reserve_usage());
        let v19 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v18, v3);
        let v20 = calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v2.market_config.u64_padding, 7), v2.market_info.user_long_position_size, v2.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v19, 1), v2.market_info.size_decimal, v14, v15, arg15, v11, get_trading_fee_config(&v2.market_config, true));
        assert!(v16 < ((((v10 - (((v16 as u128) * (v20 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128)) as u64)) as u128) * (v2.market_config.option_collateral_max_leverage_mbp as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale() as u128)) as u64), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::exceed_max_leverage());
        assert!(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_token(arg3, v6) == 0x1::type_name::with_defining_ids<T1>(), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::bid_token_mismatched());
        let v21 = v2.market_info.next_order_id;
        let v22 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>();
        0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v22, arg14);
        let v23 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::create_order_with_bid_receipts(arg0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::symbol::create(v1, v0.quote_token_type), v6, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_deposit_token(arg3, v6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale(), false, arg15, false, v11, v2.market_info.size_decimal, v14, v22, v4, 0x1::option::none<u64>(), v21, v14, 0x2::tx_context::sender(arg16), arg6, arg16);
        assert!(check_option_collateral_enough<T0>(arg3, arg5, arg4, v2, &v23, v12, v13, v14, v15, v20, arg6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::option_collateral_not_enough());
        assert!(check_reserve_enough<T0>(v2, v18, &v23, v12, v13, v14, v15), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_pool_reserve_not_enough());
        v2.market_info.next_order_id = v2.market_info.next_order_id + 1;
        let v24 = CreateTradingOrderWithBidReceiptsEvent{
            user                        : 0x2::tx_context::sender(arg16),
            market_index                : arg7,
            pool_index                  : arg8,
            dov_index                   : v6,
            collateral_token            : 0x1::type_name::with_defining_ids<T0>(),
            base_token                  : v1,
            order_id                    : v21,
            collateral_in_deposit_token : v10,
            is_long                     : arg15,
            size                        : v11,
            trigger_price               : v14,
            filled                      : true,
            filled_price                : 0x1::option::some<u64>(v14),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderWithBidReceiptsEvent>(v24);
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_order_filled(&v23, v14), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::option_collateral_order_not_filled());
        execute_option_collateral_order_<T0, T1>(arg0, arg3, arg5, arg4, v2, v18, v23, v0.protocol_fee_share_bp, v12, v13, v14, v15, v20, arg9, arg10, arg11, arg12, arg13, arg6, arg16);
    }

    fun deprecated() {
        abort 0
    }

    fun execute_option_collateral_order_<T0, T1>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &mut SymbolMarket, arg5: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::LiquidityPool, arg6: 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg14: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg15: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg16: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg17: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = prepare_order_execution<T0>(arg4, arg5, &arg6);
        let (v4, v5, v6, v7, v8, v9) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::order_filled_with_bid_receipts_collateral<T0, T1>(arg0, arg13, arg15, arg16, arg17, arg5, arg1, arg2, arg3, arg6, v1, arg4.market_info.next_position_id, arg8, arg9, arg10, arg11, v3, arg4.market_info.cumulative_funding_rate_index_sign, arg4.market_info.cumulative_funding_rate_index, arg12, arg18, arg19);
        let v10 = v6;
        let v11 = v5;
        let v12 = v4;
        0x2::balance::destroy_zero<T0>(v7);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v10, (((0x2::balance::value<T0>(&v10) as u128) * (arg7 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_bp_scale() as u128)) as u64)));
        0x2::balance::join<T0>(&mut v11, v10);
        let v13 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(&v12);
        let v14 = if (v13 > v2) {
            v13 - v2
        } else {
            v2 - v13
        };
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::order_filled<T0>(arg5, v13 > v2, v14, v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg19), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(&v12));
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::add_tails_exp_and_leaderboard(arg0, arg13, arg14, arg15, v0, v9, arg4.market_config.exp_multiplier, arg18, arg19);
        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v12) == arg4.market_info.next_position_id) {
            arg4.market_info.next_position_id = arg4.market_info.next_position_id + 1;
        };
        adjust_market_info_user_position_size(arg4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_side(&arg6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_reduce_only(&arg6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(&arg6));
        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(&v12) > 0) {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut arg4.user_positions, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v12), v12);
        } else {
            let v15 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_type(&v12);
            let v16 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_symbol(&v12);
            let v17 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v12);
            let v18 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_decimal(&v12);
            let (v19, _, _, v22, v23, v24, v25, v26, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_position_with_bid_receipts(arg0, v12);
            let (v28, v29) = exercise_bid_receipts<T0, T1>(arg1, v19, arg19);
            let v30 = v29;
            let v31 = v28;
            if (0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&v30) > 0) {
                while (0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&v30) > 0) {
                    0x2::transfer::public_transfer<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(0x1::vector::pop_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v30), v0);
                };
                0x2::balance::destroy_zero<T0>(v31);
                0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v30);
            } else {
                0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v30);
                let v32 = 0x2::balance::value<T0>(&v31);
                if (v24 > 0) {
                    let v33 = if (v23) {
                        let v34 = if (v32 >= v24) {
                            v24
                        } else {
                            v32
                        };
                        let v35 = 0x2::balance::split<T0>(&mut v31, v34);
                        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_collateral<T0>(arg5, v35, arg8, arg9);
                        0x2::balance::value<T0>(&v35)
                    } else {
                        let v36 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::request_collateral<T0>(arg5, v24, arg8, arg9);
                        0x2::balance::join<T0>(&mut v31, v36);
                        0x2::balance::value<T0>(&v36)
                    };
                    0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::emit_realized_funding_event(v0, v15, v16, v17, v23, v33, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v33, v18, arg8, arg9), 0x1::vector::empty<u64>());
                };
                assert!(0x2::balance::value<T0>(&v31) >= v22, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::balance_not_enough_for_paying_fee());
                let v37 = 0x2::balance::value<T0>(&v31) - v22;
                let v38 = if (v37 >= v25 + v26) {
                    v25 + v26
                } else {
                    v37
                };
                let v39 = v37 - v38;
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v31, (((v38 as u128) * (arg7 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_bp_scale() as u128)) as u64)));
                let v40 = 0x2::balance::split<T0>(&mut v31, v39);
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_collateral<T0>(arg5, v31, arg8, arg9);
                let v41 = RealizeOptionPositionEvent{
                    position_user              : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(&v12),
                    position_id                : v17,
                    trading_symbol             : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::symbol::base_token(&v16),
                    realize_balance_token_type : v15,
                    exercise_balance_value     : v32,
                    user_remaining_value       : v39,
                    user_remaining_in_usd      : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v39, v18, arg8, arg9),
                    realized_loss_value        : v22,
                    fee_value                  : v38,
                    realized_trading_fee       : v25,
                    realized_borrow_fee        : v26,
                    u64_padding                : 0x1::vector::empty<u64>(),
                };
                0x2::event::emit<RealizeOptionPositionEvent>(v41);
                if (0x2::balance::value<T0>(&v40) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v40, arg19), v0);
                } else {
                    0x2::balance::destroy_zero<T0>(v40);
                };
            };
        };
    }

    fun execute_order_<T0>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::LiquidityPool, arg4: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::profit_vault::ProfitVault, arg5: 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg12: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg13: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg14: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg15: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<u64>, vector<u64>) {
        let (v0, v1, v2, v3) = prepare_order_execution<T0>(arg2, arg3, &arg5);
        let v4 = v1;
        let v5 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_side(&arg5);
        let (v6, v7) = if (0x1::option::is_some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v4)) {
            (0x1::option::some<u64>(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(0x1::option::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v4))), 0x1::option::some<bool>(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(0x1::option::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v4))))
        } else {
            (0x1::option::none<u64>(), 0x1::option::none<bool>())
        };
        let v8 = v7;
        let v9 = v6;
        let v10 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(&arg5);
        let v11 = if (0x1::option::is_some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v4)) {
            let v12 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(0x1::option::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v4));
            if (v12 > v10) {
                v10
            } else {
                v12
            }
        } else {
            v10
        };
        let v13 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(arg3, 0x1::type_name::with_defining_ids<T0>());
        let (v14, v15, v16, v17) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::order_filled<T0>(arg0, arg11, arg13, arg14, arg15, arg5, v4, arg2.market_info.next_position_id, arg7, arg8, arg9, arg10, v3, arg2.market_info.cumulative_funding_rate_index_sign, arg2.market_info.cumulative_funding_rate_index, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg2.market_config.u64_padding, 7), arg2.market_info.user_long_position_size, arg2.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v13, 1), arg2.market_info.size_decimal, arg9, arg10, v5, v11, arg2.market_config.trading_fee_config), arg16, arg17);
        let v18 = v14;
        let v19 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::realize_position_pnl_and_fee<T0>(arg0, arg3, &mut v18, v16, v15, v2, arg6, arg7, arg8);
        let v20 = if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg2.market_config.u64_padding, 8) == 1) {
            if (!0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::profit_vault::is_whitelist(arg4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(&v18))) {
                0x2::balance::value<T0>(&v19) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v20) {
            let v21 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_symbol(&v18);
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::profit_vault::put_user_profit<T0>(arg4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(&v18), 0x2::balance::split<T0>(&mut v19, 0x2::balance::value<T0>(&v19)), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::symbol::base_token(&v21), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v18), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_id(&arg5), arg16);
        };
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::add_tails_exp_and_leaderboard(arg0, arg11, arg12, arg13, v0, v17, arg2.market_config.exp_multiplier, arg16, arg17);
        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v18) == arg2.market_info.next_position_id) {
            arg2.market_info.next_position_id = arg2.market_info.next_position_id + 1;
        };
        if (0x1::option::is_some<u64>(&v9)) {
            adjust_market_info_user_position_size(arg2, !*0x1::option::borrow<bool>(&v8), true, *0x1::option::borrow<u64>(&v9));
            let v22 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(&v18);
            if (v22 > 0) {
                adjust_market_info_user_position_size(arg2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(&v18), false, v22);
            };
        } else {
            adjust_market_info_user_position_size(arg2, v5, false, v10);
        };
        let (v23, v24) = if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(&v18) == 0) {
            let (v25, v26, v27, v28) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_position<T0>(arg0, v18);
            0x2::balance::join<T0>(&mut v19, v25);
            0x2::balance::join<T0>(&mut v19, remove_linked_orders<T0>(arg0, arg1, arg2, v27, v28, v0));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_collateral<T0>(arg3, v26, arg7, arg8);
            (v27, v28)
        } else {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut arg2.user_positions, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v18), v18);
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        (v19, v23, v24)
    }

    fun exercise_bid_receipts<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>();
        while (0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&arg1) > 0) {
            let v2 = 0x1::vector::pop_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut arg1);
            if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::check_bid_receipt_expired(arg0, &v2)) {
                let (_, v4, _) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_bid_receipt_info(&v2);
                let (v6, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_user_entry::exercise<T0, T1>(arg0, v4, 0x1::vector::singleton<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v2), arg2);
                0x2::balance::join<T0>(&mut v0, v6);
                continue
            };
            0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v1, v2);
        };
        0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(arg1);
        (v0, v1)
    }

    public(friend) fun get_active_orders_by_order_tag<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: u8) : vector<vector<u8>> {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = get_orders(0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2).symbol_markets, 0x1::type_name::with_defining_ids<T0>()), true, arg3);
        let v2 = 0x2::vec_map::keys<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v1);
        while (0x1::vector::length<u64>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v2);
            let v4 = 0x2::vec_map::get<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v1, &v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v4)) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(0x1::vector::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v4, v5)));
                v5 = v5 + 1;
            };
        };
        v0
    }

    public(friend) fun get_all_positions<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: u64, arg4: u64) : vector<vector<u8>> {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2).symbol_markets, 0x1::type_name::with_defining_ids<T0>()).user_positions;
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v1);
        let v3 = if (v2 / arg3 * arg3 == v2) {
            v2 / arg3
        } else {
            v2 / arg3 + 1
        };
        let v4 = v3;
        if (v2 == 0) {
            let v5 = 0;
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u64>(&v5));
            return v0
        };
        let v6 = (arg4 - 1) * arg3;
        while (v6 <= arg4 * arg3 - 1) {
            if (v6 < v2) {
                let (_, v8) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v1, v6);
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v8));
                v6 = v6 + 1;
            } else {
                break
            };
        };
        if (v2 > 0) {
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u64>(&v4));
        };
        v0
    }

    public(friend) fun get_estimated_liquidation_price_and_pnl<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : (u64, bool, u64, bool, u64, bool, u64, u64, u64) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).symbol_markets, 0x1::type_name::with_defining_ids<T1>());
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v0.user_positions, arg9);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg8, 0);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg8, 0);
        let v6 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_pool(arg2, arg7);
        let v7 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v1);
        let v8 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v6, 0x1::type_name::with_defining_ids<T0>());
        let v9 = calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v0.market_config.u64_padding, 7), v0.market_info.user_long_position_size, v0.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v8, 1), v0.market_info.size_decimal, v4, v5, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v1), get_trading_fee_config(&v0.market_config, v7));
        if (v7) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_option_position_collateral_amount<T0>(arg3, arg5, arg4, v1, arg8);
        };
        let (v10, v11, v12) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v1, v2, v3, v4, v5, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v6, 0x1::type_name::with_defining_ids<T0>()), v0.market_info.cumulative_funding_rate_index_sign, v0.market_info.cumulative_funding_rate_index);
        let v13 = if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v1)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v0.market_config.u64_padding, 3)
        } else {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v0.market_config.u64_padding, 2)
        };
        let (v14, v15) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_unrealized_cost(v1);
        let v16 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::with_defining_ids<T0>());
        let (v17, v18, v19) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_unrealized_pnl(v1, v4, v5, v9);
        (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_estimated_liquidation_price(v1, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), v2, v3, v5, v9, v13), v17, v18, v14, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v15, v16, v2, v3), v11, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v12, v16, v2, v3), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v10, v16, v2, v3), v19)
    }

    public(friend) fun get_expired_position_info(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg6);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg4);
        assert!(v0.lp_token_type == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_lp_token_type(arg2, arg5), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_token_type_mismatched());
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = v0.symbols;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v5 = &0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v0.symbol_markets, v4).user_positions;
            let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v5);
            if (v6 > 0) {
                let v7 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v5) as u64);
                let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v5, 0);
                let v9 = 0;
                while (v9 < v6) {
                    let (v10, v11) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v8, v9 % v7);
                    if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v11)) {
                        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::option_position_bid_receipts_expired(arg3, v11)) {
                            let (v12, v13) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_option_collateral_info(v11);
                            let v14 = ExpiredPositionInfo{
                                position_id      : v10,
                                dov_index        : v12,
                                collateral_token : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_type(v11),
                                bid_token        : v13,
                                base_token       : v4,
                            };
                            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::bcs::to_bytes<ExpiredPositionInfo>(&v14));
                        };
                    };
                    if (v9 + 1 < v6 && (v9 + 1) % v7 == 0) {
                        v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v5, (((v9 + 1) / v7) as u16));
                    };
                    v9 = v9 + 1;
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v2);
        v1
    }

    fun get_linked_position(arg0: &mut SymbolMarket, arg1: 0x1::option::Option<u64>, arg2: address) : (0x1::option::Option<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>, u64) {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut arg0.user_positions, 0x1::option::extract<u64>(&mut arg1));
            check_position_user_matched(&v2, arg2);
            (0x1::option::some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v2), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(&v2))
        } else {
            (0x1::option::none<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(), 0)
        }
    }

    public(friend) fun get_liquidation_info<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg10);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg7);
        assert!(v0.lp_token_type == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_lp_token_type(arg2, arg8), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_pool(arg2, arg8);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::safety_check(v2, v3, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4));
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v8 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v0.symbol_markets, v1);
        assert!(v8.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::oracle_mismatched());
        let v9 = &v8.user_positions;
        let v10 = 0x1::vector::empty<vector<u8>>();
        let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v9);
        if (v11 > 0) {
            let v12 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v9) as u64);
            let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v9, 0);
            let v14 = 0;
            while (v14 < v11) {
                let (v15, v16) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v13, v14 % v12);
                let v17 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v16);
                let v18 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_type(v16);
                if (arg9 && v18 == v3) {
                    let v19 = if (v17) {
                        let (v20, v21) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_option_collateral_info(v16);
                        LiquidationInfo{position_id: v15, dov_index: 0x1::option::some<u64>(v20), bid_token: 0x1::option::some<0x1::type_name::TypeName>(v21)}
                    } else {
                        LiquidationInfo{position_id: v15, dov_index: 0x1::option::none<u64>(), bid_token: 0x1::option::none<0x1::type_name::TypeName>()}
                    };
                    let v22 = v19;
                    0x1::vector::push_back<vector<u8>>(&mut v10, 0x2::bcs::to_bytes<LiquidationInfo>(&v22));
                } else {
                    let v23 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v2, v3);
                    if (v18 == v3 && (v17 && 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_option_collateral_position_liquidated<T0>(arg3, arg5, arg4, v16, v4, v5, v6, v7, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v8.market_config.u64_padding, 7), v8.market_info.user_long_position_size, v8.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v23, 1), v8.market_info.size_decimal, v6, v7, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v16), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v16), get_trading_fee_config(&v8.market_config, v17)), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v8.market_config.u64_padding, 3), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v2, 0x1::type_name::with_defining_ids<T0>()), v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index, arg6) || 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_position_liquidated(v16, v4, v5, v6, v7, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v8.market_config.u64_padding, 7), v8.market_info.user_long_position_size, v8.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v23, 1), v8.market_info.size_decimal, v6, v7, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v16), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v16), get_trading_fee_config(&v8.market_config, v17)), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v8.market_config.u64_padding, 2), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v2, 0x1::type_name::with_defining_ids<T0>()), v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index))) {
                        let v24 = if (v17) {
                            let (v25, v26) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_option_collateral_info(v16);
                            LiquidationInfo{position_id: v15, dov_index: 0x1::option::some<u64>(v25), bid_token: 0x1::option::some<0x1::type_name::TypeName>(v26)}
                        } else {
                            LiquidationInfo{position_id: v15, dov_index: 0x1::option::none<u64>(), bid_token: 0x1::option::none<0x1::type_name::TypeName>()}
                        };
                        let v27 = v24;
                        0x1::vector::push_back<vector<u8>>(&mut v10, 0x2::bcs::to_bytes<LiquidationInfo>(&v27));
                    };
                };
                if (v14 + 1 < v11 && (v14 + 1) % v12 == 0) {
                    v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v9, (((v14 + 1) / v12) as u16));
                };
                v14 = v14 + 1;
            };
        };
        v10
    }

    public(friend) fun get_markets_bcs(arg0: &MarketRegistry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = &arg0.markets;
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::front<u64, Markets>(v1);
        while (0x1::option::is_some<u64>(v2)) {
            let v3 = *0x1::option::borrow<u64>(v2);
            let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(v1, v3);
            if (0x1::vector::length<u64>(&arg1) == 0 || 0x1::vector::contains<u64>(&arg1, &v3)) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<Markets>(v4));
                let v5 = v4.symbols;
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v5);
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<SymbolMarket>(0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v4.symbol_markets, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5))));
                    v6 = v6 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
            };
            v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::next<u64, Markets>(v1, v3);
        };
        v0
    }

    public(friend) fun get_max_releasing_collateral_amount<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64) : u64 {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg6).symbol_markets, 0x1::type_name::with_defining_ids<T1>());
        assert!(v0.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::oracle_mismatched());
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v5 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_pool(arg2, arg7);
        let v6 = 0x1::type_name::with_defining_ids<T0>();
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::safety_check(v5, v6, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3));
        get_max_releasing_collateral_amount_(v5, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v0.user_positions, arg8), &v0.market_info, &v0.market_config, v6, v1, v2, v3, v4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v5, v6))
    }

    fun get_max_releasing_collateral_amount_(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::LiquidityPool, arg1: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position, arg2: &MarketInfo, arg3: &MarketConfig, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : u64 {
        let v0 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(arg0, arg4);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::max_releasing_collateral_amount(arg1, arg5, arg6, arg7, arg8, calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg3.u64_padding, 7), arg2.user_long_position_size, arg2.user_short_position_size, *0x1::vector::borrow<u64>(&v0, 1), arg2.size_decimal, arg7, arg8, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(arg1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(arg1), arg3.trading_fee_config), arg9, arg3.max_leverage_mbp)
    }

    public(friend) fun get_mut_market_id(arg0: &mut MarketRegistry, arg1: u64) : &mut 0x2::object::UID {
        &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg0.markets, arg1).id
    }

    fun get_mut_orders(arg0: &mut SymbolMarket, arg1: bool, arg2: u8) : &mut 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>> {
        if (arg1) {
            0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut arg0.token_collateral_orders, get_order_key(arg2))
        } else {
            0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut arg0.option_collateral_orders, get_order_key(arg2))
        }
    }

    fun get_order_key(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"limit_buy_orders")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"limit_sell_orders")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"stop_buy_orders")
        } else {
            assert!(arg0 == 3, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::unsupported_order_type_tag());
            0x1::string::utf8(b"stop_sell_orders")
        }
    }

    fun get_orders(arg0: &SymbolMarket, arg1: bool, arg2: u8) : &0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>> {
        if (arg1) {
            0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&arg0.token_collateral_orders, get_order_key(arg2))
        } else {
            0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&arg0.option_collateral_orders, get_order_key(arg2))
        }
    }

    fun get_trading_fee_config(arg0: &MarketConfig, arg1: bool) : vector<u64> {
        if (arg1) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = &mut v1;
            0x1::vector::push_back<u64>(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg0.u64_padding, 4));
            0x1::vector::push_back<u64>(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg0.u64_padding, 5));
            0x1::vector::push_back<u64>(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg0.u64_padding, 6));
            0x1::vector::push_back<u64>(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg0.u64_padding, 9));
            0x1::vector::push_back<u64>(v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&arg0.u64_padding, 10));
            v1
        } else {
            arg0.trading_fee_config
        }
    }

    public(friend) fun get_user_orders(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: address) : vector<vector<u8>> {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2);
        let v2 = v1.symbols;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v2) > 0) {
            let v3 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v1.symbol_markets, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2));
            let v4 = 0;
            while (v4 <= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_max_order_type_tag()) {
                let v5 = get_orders(v3, true, v4);
                let v6 = 0x2::vec_map::keys<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v5);
                while (0x1::vector::length<u64>(&v6) > 0) {
                    let v7 = 0x1::vector::pop_back<u64>(&mut v6);
                    let v8 = 0x2::vec_map::get<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v5, &v7);
                    let v9 = 0;
                    while (v9 < 0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v8)) {
                        let v10 = 0x1::vector::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v8, v9);
                        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(v10) == arg3) {
                            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v10));
                        };
                        v9 = v9 + 1;
                    };
                };
                v4 = v4 + 1;
            };
        };
        v0
    }

    public(friend) fun get_user_positions(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: address) : vector<vector<u8>> {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2);
        let v2 = v1.symbols;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v2) > 0) {
            let v3 = &0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v1.symbol_markets, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2)).user_positions;
            let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v3);
            if (v4 > 0) {
                let v5 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v3) as u64);
                let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v3, 0);
                let v7 = 0;
                while (v7 < v4) {
                    let (_, v9) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v6, v7 % v5);
                    if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(v9) == arg3) {
                        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v9));
                    };
                    if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                        v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(v3, (((v7 + 1) / v5) as u16));
                    };
                    v7 = v7 + 1;
                };
            };
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry{
            id                : 0x2::object::new(arg0),
            referral_registry : 0x2::object::new(arg0),
            markets           : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::new<u64, Markets>(arg0),
            num_market        : 0,
            u64_padding       : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::share_object<MarketRegistry>(v0);
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg10);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v0.lp_token_type == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_lp_token_type(arg2, arg7), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg7, arg8);
        let v2 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::safety_check(v2, v3, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4));
        let v4 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v2, v3);
        let (v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg8, 0);
        let (v7, v8) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg8, 0);
        let v9 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v9.user_positions, arg9);
        let (_, _, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v10, v5, v6, v7, v8, v4, v9.market_info.cumulative_funding_rate_index_sign, v9.market_info.cumulative_funding_rate_index);
        let v14 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v10);
        let v15 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v2, 0x1::type_name::with_defining_ids<T0>());
        let v16 = calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v9.market_config.u64_padding, 7), v9.market_info.user_long_position_size, v9.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v15, 1), v9.market_info.size_decimal, v7, v8, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v10), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v10), get_trading_fee_config(&v9.market_config, v14));
        let v17 = if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v10)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v9.market_config.u64_padding, 3)
        } else {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v9.market_config.u64_padding, 2)
        };
        let v18 = if (v14) {
            let (_, v20) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_option_collateral_info(v10);
            assert!(v20 == 0x1::type_name::with_defining_ids<T1>(), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::bid_token_mismatched());
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_option_collateral_position_liquidated<T0>(arg3, arg5, arg4, v10, v5, v6, v7, v8, v16, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v9.market_config.u64_padding, 3), v4, v9.market_info.cumulative_funding_rate_index_sign, v9.market_info.cumulative_funding_rate_index, arg8)
        } else {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_position_liquidated(v10, v5, v6, v7, v8, v16, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v9.market_config.u64_padding, 2), v4, v9.market_info.cumulative_funding_rate_index_sign, v9.market_info.cumulative_funding_rate_index)
        };
        if (v18) {
            let v21 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v9.user_positions, arg9);
            let v22 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(&v21);
            let v23 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(&v21);
            let v24 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(&v21);
            let v25 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::usd_to_amount((((0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v22, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size_decimal(&v21), v7, v8) as u128) * (100 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_bp_scale() as u128)) as u64), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_decimal(&v21), v5, v6);
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::order_filled<T0>(v2, false, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(&v21), 0x2::balance::zero<T0>());
            adjust_market_info_user_position_size(v9, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(&v21), true, v22);
            let v26 = v25;
            if (v14) {
                let (v27, _, _, v30, v31, v32, v33, v34, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_position_with_bid_receipts(arg0, v21);
                let (v36, v37) = exercise_bid_receipts<T0, T1>(arg3, v27, arg10);
                let v38 = v37;
                let v39 = v36;
                let v40 = if (v25 > 0) {
                    let v41 = 0x1::u64::min(0x2::balance::value<T0>(&v39), v25);
                    0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v39, v41));
                    v26 = v25 - v41;
                    v41
                } else {
                    0
                };
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_collateral<T0>(v2, v39, v5, v6);
                if (0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&v38) > 0) {
                    let v42 = 0x1::vector::empty<0x1::type_name::TypeName>();
                    let v43 = &mut v42;
                    0x1::vector::push_back<0x1::type_name::TypeName>(v43, 0x1::type_name::with_defining_ids<T0>());
                    0x1::vector::push_back<0x1::type_name::TypeName>(v43, 0x1::type_name::with_defining_ids<T1>());
                    let v44 = 0x1::vector::empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>();
                    0x1::vector::push_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>(&mut v44, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::create_unsettled_bid_receipt(v38, v24, v23, v42, false, v30, v33, v34, v31, v32, v26));
                    0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_receipt_collaterals(v2, v44);
                } else {
                    0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v38);
                };
                let v45 = 0x1::vector::empty<u64>();
                let v46 = &mut v45;
                0x1::vector::push_back<u64>(v46, v22);
                0x1::vector::push_back<u64>(v46, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_estimated_liquidation_price(v10, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), v5, v6, v8, v16, v17));
                let v47 = LiquidateEvent{
                    user                       : v23,
                    collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
                    base_token                 : v1,
                    position_id                : v24,
                    collateral_price           : v5,
                    trading_price              : v7,
                    realized_liquidator_fee    : v40,
                    realized_value_for_lp_pool : 0x2::balance::value<T0>(&v39),
                    u64_padding                : v45,
                };
                0x2::event::emit<LiquidateEvent>(v47);
            } else {
                let (v48, v49, v50, v51) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_position<T0>(arg0, v21);
                let v52 = v48;
                return_to_user<T0>(remove_linked_orders<T0>(arg0, arg6, v9, v50, v51, v23), v23, arg10);
                let v53 = 0x1::u64::min(0x2::balance::value<T0>(&v52), v25);
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v52, v53));
                0x2::balance::join<T0>(&mut v52, v49);
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_collateral<T0>(v2, v52, v5, v6);
                let v54 = 0x1::vector::empty<u64>();
                let v55 = &mut v54;
                0x1::vector::push_back<u64>(v55, v22);
                0x1::vector::push_back<u64>(v55, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_estimated_liquidation_price(v10, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), v5, v6, v8, v16, v17));
                let v56 = LiquidateEvent{
                    user                       : v23,
                    collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
                    base_token                 : v1,
                    position_id                : v24,
                    collateral_price           : v5,
                    trading_price              : v7,
                    realized_liquidator_fee    : v53,
                    realized_value_for_lp_pool : 0x2::balance::value<T0>(&v52),
                    u64_padding                : v54,
                };
                0x2::event::emit<LiquidateEvent>(v56);
            };
        };
    }

    public fun manager_clear_position<T0, T1>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg6);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg3);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v2.user_positions, arg5);
        let v4 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(&v3);
        let v5 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(&v3);
        let (v6, v7, v8, v9) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_position<T0>(arg0, v3);
        let v10 = v6;
        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(&v3)) {
            v2.market_info.user_long_position_size = v2.market_info.user_long_position_size - v5;
        } else {
            v2.market_info.user_short_position_size = v2.market_info.user_short_position_size - v5;
        };
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_reserve_amount<T0>(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg4), false, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_reserve_amount(&v3));
        0x2::balance::join<T0>(&mut v10, v7);
        return_to_user<T0>(v10, v4, arg6);
        let v11 = ManagerClearPositionEvent{
            user                : v4,
            collateral_token    : 0x1::type_name::with_defining_ids<T0>(),
            base_token          : v1,
            position_id         : arg5,
            removed_size        : v5,
            cancelled_order_ids : v8,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerClearPositionEvent>(v11);
        let v12 = v8;
        if (0x1::vector::length<u64>(&v12) > 0) {
            cancel_linked_orders<T0, T1>(arg0, arg1, arg3, v12, v9, v4, arg6);
        };
    }

    public fun manager_close_option_position<T0, T1, T2>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T2>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, 0x1::option::none<u64>(), arg15);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg15);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7).symbol_markets, v0).user_positions, arg14);
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::not_option_collateral_position());
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::option_position_bid_receipts_expired(arg3, v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::bid_receipt_not_expired());
        let (v2, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v4, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        reduce_option_collateral_position_size<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x1::option::none<u64>(), arg15);
        let v6 = ManagerCloseOptionPositionEvent{
            user                : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(v1),
            collateral_token    : 0x1::type_name::with_defining_ids<T0>(),
            base_token          : v0,
            position_id         : arg14,
            order_size          : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v1),
            collateral_price    : v2,
            trading_price       : v4,
            cancelled_order_ids : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_linked_order_ids(v1),
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerCloseOptionPositionEvent>(v6);
    }

    public fun manager_reduce_position<T0, T1>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::profit_vault::ProfitVault, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg16);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        assert!(v0.lp_token_type == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_lp_token_type(arg2, arg8), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::safety_check(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_pool(arg2, arg8), v2, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4));
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        let v3 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v8 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v8.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::oracle_mismatched());
        let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v8.user_positions, arg14);
        let (_, _, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v9, v4, v5, v6, v7, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v3, 0x1::type_name::with_defining_ids<T0>()), v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index);
        let v13 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(v9);
        let v14 = (((0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v9) as u128) * (arg15 as u128) / (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_bp_scale() as u128)) as u64) / v8.market_config.lot_size * v8.market_config.lot_size;
        let v15 = v8.market_info.next_order_id;
        let v16 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::manager_create_reduce_only_order<T0>(arg0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::symbol::create(v1, v0.quote_token_type), !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v9), v14, v8.market_info.size_decimal, v6, 0x2::balance::zero<T0>(), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_token_decimal(arg2, arg8, 0x1::type_name::with_defining_ids<T0>()), arg14, v13, v8.market_info.next_order_id, v6, arg6, arg16);
        v8.market_info.next_order_id = v8.market_info.next_order_id + 1;
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::add_position_linked_order_info(v9, v15, v6);
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_order_filled(&v16, v6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::order_not_filled_immediately());
        let (v17, v18, v19) = execute_order_<T0>(arg0, arg7, v8, v3, arg3, v16, v0.protocol_fee_share_bp, v4, v5, v6, v7, arg9, arg10, arg11, arg12, arg13, arg6, arg16);
        let v20 = v18;
        return_to_user<T0>(v17, v13, arg16);
        if (0x1::vector::length<u64>(&v20) > 0) {
            cancel_linked_orders<T0, T1>(arg0, arg1, arg7, v20, v19, v13, arg16);
        };
        let v21 = ManagerReducePositionEvent{
            user                : v13,
            collateral_token    : v2,
            base_token          : v1,
            position_id         : arg14,
            reduced_size        : v14,
            collateral_price    : v4,
            trading_price       : v6,
            cancelled_order_ids : v20,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerReducePositionEvent>(v21);
    }

    public fun match_trading_order<T0, T1>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::profit_vault::ProfitVault, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg14: u8, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, 0x1::option::none<u64>(), arg17);
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg17);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        let v4 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v2.symbol_markets, v3);
        assert!(v4.market_info.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_inactive());
        let v5 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v8, v9) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v10 = get_mut_orders(v4, true, arg14);
        let (_, v12) = 0x2::vec_map::remove<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v10, &arg15);
        let v13 = v12;
        let v14 = 0x1::vector::empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>();
        while (0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v13) > 0 && v0 < arg16) {
            let v15 = 0x1::vector::pop_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v13);
            let v16 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_side(&v15);
            let v17 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(&v15);
            let v18 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(&v15);
            let v19 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(&v15);
            if (0x1::option::is_some<u64>(&v19)) {
                if (!0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<u64>(&v4.user_positions, 0x1::option::extract<u64>(&mut v19))) {
                    let v20 = remove_linked_order_<T0>(arg0, arg7, v4, v15, v18);
                    return_to_user<T0>(v20, v18, arg17);
                    continue
                };
            };
            let v21 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_reduce_only(&v15) && false || v16 && v4.market_info.user_long_position_size + v17 > 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v4.market_config.u64_padding, 0) || v4.market_info.user_short_position_size + v17 > 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v4.market_config.u64_padding, 1);
            let v22 = if (check_reserve_enough<T0>(v4, v5, &v15, v6, v7, v8, v9)) {
                if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_collateral_token(&v15) == 0x1::type_name::with_defining_ids<T0>()) {
                    if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::check_order_filled(&v15, v8)) {
                        !v21
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v22) {
                let v23 = 0x1::type_name::with_defining_ids<T0>();
                if ((!0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::token_pool_is_active(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool(v5, &v23)) || !v4.market_info.is_active) && !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_reduce_only(&v15)) {
                    0x1::vector::push_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v14, v15);
                    continue
                };
                adjust_market_info_user_order_size(v4, v16, true, v17);
                let (v24, _, _) = execute_order_<T0>(arg0, arg7, v4, v5, arg3, v15, v2.protocol_fee_share_bp, v6, v7, v8, v9, arg9, arg10, arg11, arg12, arg13, arg6, arg17);
                return_to_user<T0>(v24, v18, arg17);
                0x1::vector::push_back<u64>(&mut v1, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_id(&v15));
                v0 = v0 + 1;
                continue
            };
            0x1::vector::push_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v14, v15);
        };
        if (0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v13) > 0) {
            0x1::vector::append<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v14, v13);
        } else {
            0x1::vector::destroy_empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v13);
        };
        if (0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v14) > 0) {
            0x2::vec_map::insert<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(get_mut_orders(v4, true, arg14), arg15, v14);
        } else {
            0x1::vector::destroy_empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v14);
        };
        if (v0 > 0) {
            let v27 = MatchTradingOrderEvent{
                collateral_token  : 0x1::type_name::with_defining_ids<T0>(),
                base_token        : v3,
                matched_order_ids : v1,
                u64_padding       : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<MatchTradingOrderEvent>(v27);
        };
    }

    entry fun new_markets<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg3);
        let v0 = Markets{
            id                    : 0x2::object::new(arg3),
            index                 : arg1.num_market,
            lp_token_type         : 0x1::type_name::with_defining_ids<T0>(),
            quote_token_type      : 0x1::type_name::with_defining_ids<T1>(),
            is_active             : true,
            protocol_fee_share_bp : arg2,
            symbols               : 0x1::vector::empty<0x1::type_name::TypeName>(),
            symbol_markets        : 0x2::object_table::new<0x1::type_name::TypeName, SymbolMarket>(arg3),
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        let v1 = NewMarketsEvent{
            index                 : v0.index,
            lp_token_type         : v0.lp_token_type,
            quote_token_type      : v0.quote_token_type,
            protocol_fee_share_bp : arg2,
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewMarketsEvent>(v1);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::push_back<u64, Markets>(&mut arg1.markets, arg1.num_market, v0);
        arg1.num_market = arg1.num_market + 1;
    }

    fun normal_safety_check<T0, T1>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::version_check(arg0);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5);
        assert!(v0.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::markets_inactive());
        assert!(v0.lp_token_type == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_lp_token_type(arg2, arg6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v2), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v2);
        assert!(v3.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::oracle_mismatched());
        if (0x1::option::is_some<u64>(&arg7)) {
            let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&v3.user_positions, 0x1::option::extract<u64>(&mut arg7));
            check_position_user_matched(v4, 0x2::tx_context::sender(arg8));
            assert!(v1 == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_collateral_token_type(v4), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::collateral_token_type_mismatched());
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::check_token_pool_status<T0>(arg2, arg6, true);
        };
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::safety_check(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg6), v1, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3));
    }

    fun prepare_order_execution<T0>(arg0: &mut SymbolMarket, arg1: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::LiquidityPool, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder) : (address, 0x1::option::Option<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>, u64, u64) {
        let v0 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(arg2);
        let (v1, v2) = get_linked_position(arg0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_linked_position_id(arg2), v0);
        (v0, v1, v2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(arg1, 0x1::type_name::with_defining_ids<T0>()))
    }

    public fun reduce_option_collateral_position_size<T0, T1, T2>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::competition::CompetitionConfig, arg14: u64, arg15: 0x1::option::Option<u64>, arg16: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T2>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, 0x1::option::none<u64>(), arg16);
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v2);
        if (0x1::option::is_some<u64>(&arg15)) {
            assert!(*0x1::option::borrow<u64>(&arg15) % v3.market_config.lot_size == 0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::invalid_order_size());
        };
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_token_decimal(arg2, arg8, 0x1::type_name::with_defining_ids<T0>());
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::Position>(&mut v3.user_positions, arg14);
        if (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(v6) != v0) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg16);
        };
        assert!(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::is_option_collateral_position(v6), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::not_option_collateral_position());
        let (v7, v8) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_option_collateral_info(v6);
        assert!(v8 == 0x1::type_name::with_defining_ids<T1>(), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::bid_token_mismatched());
        let v9 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v6);
        let v10 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size(v6);
        if (0x1::option::is_some<u64>(&arg15)) {
            assert!(*0x1::option::borrow<u64>(&arg15) <= v10, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::invalid_order_size());
        };
        let (v11, v12) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v13, v14) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v15 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        let (_, _, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::update_position_borrow_rate_and_funding_rate(v6, v11, v12, v13, v14, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_cumulative_borrow_rate(v15, 0x1::type_name::with_defining_ids<T0>()), v3.market_info.cumulative_funding_rate_index_sign, v3.market_info.cumulative_funding_rate_index);
        let (v19, v20) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_unrealized_cost(v6);
        let v21 = if (0x1::option::is_none<u64>(&arg15)) {
            v10
        } else {
            0x1::option::extract<u64>(&mut arg15)
        };
        let v22 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_token_pool_state(v15, v4);
        let v23 = calculate_trading_fee_rate_mbp(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_u64_vector_value(&v3.market_config.u64_padding, 7), v3.market_info.user_long_position_size, v3.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v22, 1), v3.market_info.size_decimal, v13, v14, !0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_side(v6), v21, get_trading_fee_config(&v3.market_config, true));
        let (v24, v25, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::calculate_unrealized_pnl(v6, v13, v14, v23);
        let v27 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_option_position_exercise_value<T0>(arg3, arg5, arg4, v6, arg6);
        assert!(v24 && (v19 && v25 + v27 >= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v20, v5, v11, v12) || true) || v19 && 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v27, v5, v11, v12) >= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v20, v5, v11, v12) + v25 || 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v20, v5, v11, v12) + 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v27, v5, v11, v12) >= v25, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::perp_position_losses());
        if (v21 < v10) {
            0x2::transfer::public_transfer<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::split_bid_receipt(arg3, v6, v21, arg16), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(v6));
        };
        let v28 = v3.market_info.next_order_id;
        let v29 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::create_order_with_bid_receipts(arg0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::symbol::create(v2, v1.quote_token_type), v7, v4, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::get_mbp_scale(), true, !v9, false, v21, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_size_decimal(v6), v13, 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(), v5, 0x1::option::some<u64>(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_id(v6)), v28, v13, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_position_user(v6), arg6, arg16);
        let v30 = CreateTradingOrderWithBidReceiptsEvent{
            user                        : v0,
            market_index                : arg7,
            pool_index                  : arg8,
            dov_index                   : v7,
            collateral_token            : 0x1::type_name::with_defining_ids<T0>(),
            base_token                  : v2,
            order_id                    : v28,
            collateral_in_deposit_token : v27,
            is_long                     : !v9,
            size                        : v21,
            trigger_price               : v13,
            filled                      : true,
            filled_price                : 0x1::option::some<u64>(v13),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderWithBidReceiptsEvent>(v30);
        v3.market_info.next_order_id = v3.market_info.next_order_id + 1;
        execute_option_collateral_order_<T0, T1>(arg0, arg3, arg5, arg4, v3, v15, v29, v1.protocol_fee_share_bp, v11, v12, v13, v14, v23, arg9, arg10, arg11, arg12, arg13, arg6, arg16);
    }

    fun remove_linked_order_<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder, arg4: address) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_trading_symbol(&arg3);
        adjust_market_info_user_order_size(arg2, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_side(&arg3), true, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_size(&arg3));
        let v2 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::remove_order<T0>(arg0, arg3);
        let v3 = CancelTradingOrderEvent{
            user                       : arg4,
            market_index               : arg1,
            order_id                   : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_id(&arg3),
            trigger_price              : 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_price(&arg3),
            collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
            base_token                 : v0,
            released_collateral_amount : 0x2::balance::value<T0>(&v2),
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CancelTradingOrderEvent>(v3);
        v2
    }

    fun remove_linked_orders<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: vector<u64>, arg4: vector<u64>, arg5: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (0x1::vector::length<u64>(&arg3) > 0) {
            let v1 = take_order_by_order_id_and_price(arg2, 0x1::vector::pop_back<u64>(&mut arg4), 0x1::vector::pop_back<u64>(&mut arg3), true, arg5);
            if (0x1::option::is_some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v1)) {
                0x2::balance::join<T0>(&mut v0, remove_linked_order_<T0>(arg0, arg1, arg2, 0x1::option::extract<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v1), arg5));
            };
            0x1::option::destroy_none<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v1);
        };
        v0
    }

    entry fun remove_trading_symbol<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg3);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::remove<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(!v2.market_info.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::active_trading_symbol());
        let v3 = if (v2.market_info.user_long_order_size == 0) {
            if (v2.market_info.user_short_order_size == 0) {
                if (v2.market_info.user_long_position_size == 0) {
                    v2.market_info.user_short_position_size == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::order_or_position_size_not_zero());
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"limit_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"limit_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"stop_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"stop_sell_orders")));
        let SymbolMarket {
            id                       : v4,
            user_positions           : v5,
            token_collateral_orders  : v6,
            option_collateral_orders : v7,
            market_info              : _,
            market_config            : _,
        } = v2;
        0x2::object::delete(v4);
        0x2::object::delete(v6);
        0x2::object::delete(v7);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::destroy_empty(v5);
        let (_, v11) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.symbols, &v1);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut v0.symbols, v11);
    }

    entry fun resume_market(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2).is_active = true;
        let v0 = ResumeMarketEvent{
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumeMarketEvent>(v0);
    }

    entry fun resume_trading_symbol<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg3);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        assert!(v0.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::markets_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1).market_info.is_active = true;
        let v2 = ResumeTradingSymbolEvent{
            index              : arg2,
            resumed_base_token : v1,
            u64_padding        : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumeTradingSymbolEvent>(v2);
    }

    fun return_to_user<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun settle_receipt_collateral<T0, T1>(arg0: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg8);
        assert!(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).lp_token_type == 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_lp_token_type(arg2, arg7), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::lp_token_type_mismatched());
        let v0 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::safety_check(v0, v1, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4));
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v5 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_receipt_collateral(v0);
        let v6 = 0x1::vector::empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>();
        while (0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>(&v5) > 0) {
            let (v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::destruct_unsettled_bid_receipt(0x1::vector::pop_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>(&mut v5));
            let v18 = v10;
            let v19 = v7;
            let v20 = true;
            let v21 = &v19;
            let v22 = 0;
            while (v22 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v21)) {
                if (!0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::check_bid_receipt_expired(arg3, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v21, v22))) {
                    v20 = false;
                };
                v22 = v22 + 1;
            };
            let v23 = if (v20) {
                if (v1 == *0x1::vector::borrow<0x1::type_name::TypeName>(&v18, 0)) {
                    v2 == *0x1::vector::borrow<0x1::type_name::TypeName>(&v18, 1)
                } else {
                    false
                }
            } else {
                false
            };
            if (v23) {
                let (v24, v25) = exercise_bid_receipts<T0, T1>(arg3, v19, arg8);
                let v26 = v24;
                0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v25);
                let v27 = 0x1::u64::min(0x2::balance::value<T0>(&v26), v17);
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v26, v27));
                let v28 = false;
                let v29 = v13 + v14;
                let v30 = if (v11) {
                    if (v29 > v12) {
                        v29 - v12
                    } else {
                        v28 = true;
                        v12 - v29
                    }
                } else {
                    v29 + v12
                };
                if (v15) {
                    if (v28) {
                        v30 = v30 + v16;
                    } else if (v30 > v16) {
                        v30 = v30 - v16;
                    } else {
                        v30 = v16 - v30;
                        v28 = true;
                    };
                } else if (v28) {
                    if (v30 > v16) {
                        v30 = v30 - v16;
                    } else {
                        v30 = v16 - v30;
                        v28 = false;
                    };
                    v30 = v30 + v16;
                } else {
                    v30 = v30 + v16;
                };
                0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_collateral<T0>(v0, v26, v3, v4);
                let v31 = SettleReceiptCollateralEvent{
                    user                        : v9,
                    collateral_token            : v1,
                    bid_token                   : v2,
                    position_id                 : v8,
                    realized_liquidator_fee     : v27,
                    remaining_unrealized_sign   : v28,
                    remaining_unrealized_value  : v30,
                    remaining_value_for_lp_pool : 0x2::balance::value<T0>(&v26),
                    u64_padding                 : 0x1::vector::empty<u64>(),
                };
                0x2::event::emit<SettleReceiptCollateralEvent>(v31);
                continue
            };
            0x1::vector::push_back<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>(&mut v6, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::create_unsettled_bid_receipt(v19, v8, v9, v18, v11, v12, v13, v14, v15, v16, v17));
        };
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::put_receipt_collaterals(v0, v6);
        0x1::vector::destroy_empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::escrow::UnsettledBidReceipt>(v5);
    }

    entry fun suspend_market(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2).is_active = false;
        let v0 = SuspendMarketEvent{
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendMarketEvent>(v0);
    }

    entry fun suspend_trading_symbol<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg3);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        assert!(v0.is_active, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::markets_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1).market_info.is_active = false;
        let v2 = SuspendTradingSymbolEvent{
            index                : arg2,
            suspended_base_token : v1,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendTradingSymbolEvent>(v2);
    }

    fun take_order_by_order_id_and_price(arg0: &mut SymbolMarket, arg1: u64, arg2: u64, arg3: bool, arg4: address) : 0x1::option::Option<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder> {
        let v0 = 0x1::option::none<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>();
        let v1 = 0;
        while (v1 <= 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_max_order_type_tag()) {
            let v2 = get_mut_orders(arg0, arg3, v1);
            if (0x2::vec_map::contains<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v2, &arg1)) {
                let (_, v4) = 0x2::vec_map::remove<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v2, &arg1);
                let v5 = v4;
                let v6 = 0;
                while (v6 < 0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v5)) {
                    let v7 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_id(0x1::vector::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v5, v6));
                    let v8 = if (&v7 == &arg2) {
                        let v9 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::get_order_user(0x1::vector::borrow<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v5, v6));
                        &v9 == &arg4
                    } else {
                        false
                    };
                    if (v8) {
                        0x1::option::fill<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v0, 0x1::vector::remove<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&mut v5, v6));
                        break
                    };
                    v6 = v6 + 1;
                };
                if (0x1::vector::length<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v5) == 0) {
                    0x1::vector::destroy_empty<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(v5);
                } else {
                    0x2::vec_map::insert<u64, vector<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>>(v2, arg1, v5);
                };
                if (0x1::option::is_some<0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::position::TradingOrder>(&v0)) {
                    break
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun trading_symbol_exists<T0>(arg0: &Markets) : bool {
        0x2::object_table::contains<0x1::type_name::TypeName, SymbolMarket>(&arg0.symbol_markets, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun update_funding_rate<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg7);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::oracle_mismatched());
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg4, 0);
        let v5 = v2.market_info.last_funding_ts_ms;
        let v6 = 0x2::clock::timestamp_ms(arg4) / v2.market_config.funding_interval_ts_ms * v2.market_config.funding_interval_ts_ms;
        if (v6 > v5) {
            let v7 = (v6 - v5) / v2.market_config.funding_interval_ts_ms;
            let v8 = 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_tvl_usd(0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::lp_pool::get_liquidity_pool(arg2, arg6));
            let v9 = if (v2.market_info.user_long_position_size > v2.market_info.user_short_position_size) {
                v2.market_info.user_long_position_size - v2.market_info.user_short_position_size
            } else {
                v2.market_info.user_short_position_size - v2.market_info.user_long_position_size
            };
            let v10 = if (v8 > 0) {
                (((v2.market_config.basic_funding_rate as u128) * (0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::amount_to_usd(v9, v2.market_info.size_decimal, v3, v4) as u128) / (v8 as u128)) as u64)
            } else {
                0
            };
            let v11 = v10 * v7;
            v2.market_info.previous_last_funding_ts_ms = v2.market_info.last_funding_ts_ms;
            v2.market_info.previous_cumulative_funding_rate_index_sign = v2.market_info.cumulative_funding_rate_index_sign;
            v2.market_info.previous_cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index;
            v2.market_info.last_funding_ts_ms = v6;
            if (v2.market_info.user_long_position_size > v2.market_info.user_short_position_size) {
                if (v2.market_info.cumulative_funding_rate_index_sign) {
                    v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index + v11;
                } else if (v2.market_info.cumulative_funding_rate_index > v11) {
                    v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index - v11;
                } else {
                    v2.market_info.cumulative_funding_rate_index = v11 - v2.market_info.cumulative_funding_rate_index;
                    v2.market_info.cumulative_funding_rate_index_sign = true;
                };
            } else if (v2.market_info.cumulative_funding_rate_index_sign) {
                if (v2.market_info.cumulative_funding_rate_index >= v11) {
                    v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index - v11;
                } else {
                    v2.market_info.cumulative_funding_rate_index = v11 - v2.market_info.cumulative_funding_rate_index;
                    v2.market_info.cumulative_funding_rate_index_sign = false;
                };
            } else {
                v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index + v11;
            };
            let v12 = UpdateFundingRateEvent{
                base_token                                  : v1,
                new_funding_ts_ms                           : v6,
                intervals_count                             : v7,
                previous_cumulative_funding_rate_index_sign : v2.market_info.cumulative_funding_rate_index_sign,
                previous_cumulative_funding_rate_index      : v2.market_info.cumulative_funding_rate_index,
                cumulative_funding_rate_index_sign          : v2.market_info.cumulative_funding_rate_index_sign,
                cumulative_funding_rate_index               : v2.market_info.cumulative_funding_rate_index,
                u64_padding                                 : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<UpdateFundingRateEvent>(v12);
        };
    }

    entry fun update_market_config<T0>(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<vector<u64>>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<vector<u64>>, arg17: 0x1::option::Option<u64>, arg18: 0x1::option::Option<u64>, arg19: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg19);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        if (0x1::option::is_some<address>(&arg3)) {
            v2.market_config.oracle_id = 0x1::option::extract<address>(&mut arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v2.market_config.max_leverage_mbp = 0x1::option::extract<u64>(&mut arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v2.market_config.option_collateral_max_leverage_mbp = 0x1::option::extract<u64>(&mut arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v2.market_config.min_size = 0x1::option::extract<u64>(&mut arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v2.market_config.lot_size = 0x1::option::extract<u64>(&mut arg7);
        };
        if (0x1::option::is_some<vector<u64>>(&arg8)) {
            v2.market_config.trading_fee_config = 0x1::option::extract<vector<u64>>(&mut arg8);
            validate_trading_fee_config(&v2.market_config.trading_fee_config);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            v2.market_config.basic_funding_rate = 0x1::option::extract<u64>(&mut arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            v2.market_config.funding_interval_ts_ms = 0x1::option::extract<u64>(&mut arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            v2.market_config.exp_multiplier = 0x1::option::extract<u64>(&mut arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 0, 0x1::option::extract<u64>(&mut arg12));
        };
        if (0x1::option::is_some<u64>(&arg13)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 1, 0x1::option::extract<u64>(&mut arg13));
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 2, 0x1::option::extract<u64>(&mut arg14));
        };
        if (0x1::option::is_some<u64>(&arg15)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 3, 0x1::option::extract<u64>(&mut arg15));
        };
        if (0x1::option::is_some<vector<u64>>(&arg16)) {
            let v3 = 0x1::option::extract<vector<u64>>(&mut arg16);
            validate_trading_fee_config(&v3);
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 4, *0x1::vector::borrow<u64>(&v3, 0));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 5, *0x1::vector::borrow<u64>(&v3, 1));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 6, *0x1::vector::borrow<u64>(&v3, 2));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 9, *0x1::vector::borrow<u64>(&v3, 3));
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 10, *0x1::vector::borrow<u64>(&v3, 4));
        };
        if (0x1::option::is_some<u64>(&arg17)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 7, 0x1::option::extract<u64>(&mut arg17));
        };
        if (0x1::option::is_some<u64>(&arg18)) {
            0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 8, 0x1::option::extract<u64>(&mut arg18));
        };
        let v4 = UpdateMarketConfigEvent{
            index                  : arg2,
            base_token_type        : v1,
            previous_market_config : v2.market_config,
            new_market_config      : v2.market_config,
            u64_padding            : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateMarketConfigEvent>(v4);
    }

    entry fun update_protocol_fee_share_bp(arg0: &0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::admin::verify(arg0, arg4);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        v0.protocol_fee_share_bp = arg3;
        let v1 = UpdateProtocolFeeShareBpEvent{
            index                          : arg2,
            previous_protocol_fee_share_bp : v0.protocol_fee_share_bp,
            new_protocol_fee_share_bp      : v0.protocol_fee_share_bp,
            u64_padding                    : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateProtocolFeeShareBpEvent>(v1);
    }

    fun validate_trading_fee_config(arg0: &vector<u64>) {
        let v0 = if (*0x1::vector::borrow<u64>(arg0, 1) >= *0x1::vector::borrow<u64>(arg0, 0)) {
            if (0x1::vector::length<u64>(arg0) == 5) {
                *0x1::vector::borrow<u64>(arg0, 4) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0xec30955b1e100617a02fecec432d2c845f17b2f3d68827f390563faba112513b::error::invalid_trading_fee_config());
    }

    // decompiled from Move bytecode v6
}

