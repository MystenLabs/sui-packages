module 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::trading {
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
        filled: bool,
        filled_price: 0x1::option::Option<u64>,
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

    struct ManagerCancelOrdersEvent has copy, drop {
        reason: 0x1::string::String,
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        order_type_tag: u8,
        order_ids: vector<u64>,
        order_sizes: vector<u64>,
        order_prices: vector<u64>,
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

    struct ManagerUpdateProcessStatusAfterPositionEvent has copy, drop {
        market_index: u64,
        pool_index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        trading_base_token: 0x1::type_name::TypeName,
    }

    struct ManagerUpdateProcessStatusAfterOrderEvent has copy, drop {
        market_index: u64,
        pool_index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        trading_base_token: 0x1::type_name::TypeName,
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

    public fun increase_collateral<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v1.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v3), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v4 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v3);
        assert!(v4.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        assert!(v4.market_info.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_inactive());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg7, true);
        let v5 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v5);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v5, v2, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v6 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v5, 0x1::type_name::get<T0>());
        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v4.user_positions, arg8);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v7) == v0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
        assert!(v2 == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_type(v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::collateral_token_type_mismatched());
        let (v8, v9) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v10, v11) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v12 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(v7);
        let v13 = 0x2::coin::value<T0>(&arg9);
        let v14 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(v7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::increase_collateral<T0>(v7, 0x2::coin::into_balance<T0>(arg9), v8, v9, v10, v11);
        let v15 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(v7);
        let v16 = if (v15 > v14) {
            v15 - v14
        } else {
            v14 - v15
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_reserve_amount<T0>(v5, v15 > v14, v16);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_position_borrow_rate_and_funding_rate(v7, v8, v9, v10, v11, v6, v4.market_info.cumulative_funding_rate_index_sign, v4.market_info.cumulative_funding_rate_index);
        let v17 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v5, v2);
        let v18 = calculate_trading_fee_rate_mbp(v4.market_info.user_long_position_size, v4.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v17, 1), v4.market_info.size_decimal, v10, v11, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v7), v4.market_config.trading_fee_config);
        assert!(!0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_position_liquidated(v7, v8, v9, v10, v11, *0x1::vector::borrow<u64>(&v18, 0) + *0x1::vector::borrow<u64>(&v18, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v4.market_config.u64_padding, 2), v6, v4.market_info.cumulative_funding_rate_index_sign, v4.market_info.cumulative_funding_rate_index), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::remaining_collateral_not_enough());
        let v19 = IncreaseCollateralEvent{
            user                        : v0,
            market_index                : arg6,
            pool_index                  : arg7,
            position_id                 : arg8,
            collateral_token            : v2,
            base_token                  : v3,
            increased_collateral_amount : v13,
            remaining_collateral_amount : v12 + v13,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<IncreaseCollateralEvent>(v19);
    }

    public fun release_collateral<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg10);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v1.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v3), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v4 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v3);
        assert!(v4.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v5 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v5);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v5, v2, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v6 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v5, 0x1::type_name::get<T0>());
        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v4.user_positions, arg8);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v7) == v0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
        assert!(v2 == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_type(v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::collateral_token_type_mismatched());
        let v8 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(v7);
        assert!(v8 >= arg9, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::remaining_collateral_not_enough());
        let (v9, v10) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v11, v12) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v13 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(v7);
        let v14 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::release_collateral<T0>(v7, arg9, v9, v10, v11, v12);
        let v15 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(v7);
        let v16 = if (v15 > v13) {
            v15 - v13
        } else {
            v13 - v15
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_reserve_amount<T0>(v5, v15 > v13, v16);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_position_borrow_rate_and_funding_rate(v7, v9, v10, v11, v12, v6, v4.market_info.cumulative_funding_rate_index_sign, v4.market_info.cumulative_funding_rate_index);
        let v17 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v5, v2);
        let v18 = calculate_trading_fee_rate_mbp(v4.market_info.user_long_position_size, v4.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v17, 1), v4.market_info.size_decimal, v11, v12, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v7), v4.market_config.trading_fee_config);
        assert!(!0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_position_liquidated(v7, v9, v10, v11, v12, *0x1::vector::borrow<u64>(&v18, 0) + *0x1::vector::borrow<u64>(&v18, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v4.market_config.u64_padding, 2), v6, v4.market_info.cumulative_funding_rate_index_sign, v4.market_info.cumulative_funding_rate_index), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::remaining_collateral_not_enough());
        let v19 = ReleaseCollateralEvent{
            user                        : v0,
            market_index                : arg6,
            pool_index                  : arg7,
            position_id                 : arg8,
            collateral_token            : v2,
            base_token                  : v3,
            released_collateral_amount  : arg9,
            remaining_collateral_amount : v8 - arg9,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ReleaseCollateralEvent>(v19);
        0x2::coin::from_balance<T0>(v14, arg10)
    }

    entry fun add_trading_symbol<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg19);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_existed());
        assert!(*0x1::vector::borrow<u64>(&arg9, 1) >= *0x1::vector::borrow<u64>(&arg9, 0), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_trading_fee_config());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.symbols, v1);
        let v2 = MarketInfo{
            is_active                                   : true,
            size_decimal                                : arg3,
            user_long_position_size                     : 0,
            user_short_position_size                    : 0,
            next_position_id                            : 0,
            user_long_order_size                        : 0,
            user_short_order_size                       : 0,
            next_order_id                               : 0,
            last_funding_ts_ms                          : 0x2::clock::timestamp_ms(arg18),
            cumulative_funding_rate_index_sign          : true,
            cumulative_funding_rate_index               : 0,
            previous_last_funding_ts_ms                 : 0x2::clock::timestamp_ms(arg18),
            previous_cumulative_funding_rate_index_sign : true,
            previous_cumulative_funding_rate_index      : 0,
            u64_padding                                 : 0x1::vector::empty<u64>(),
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg13);
        0x1::vector::push_back<u64>(v4, arg14);
        0x1::vector::push_back<u64>(v4, arg15);
        0x1::vector::push_back<u64>(v4, arg16);
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&arg17, 0));
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&arg17, 1));
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&arg17, 2));
        let v5 = MarketConfig{
            oracle_id                          : 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4),
            max_leverage_mbp                   : arg5,
            option_collateral_max_leverage_mbp : arg6,
            min_size                           : arg7,
            lot_size                           : arg8,
            trading_fee_config                 : arg9,
            basic_funding_rate                 : arg10,
            funding_interval_ts_ms             : arg11,
            exp_multiplier                     : arg12,
            u64_padding                        : v3,
        };
        let v6 = SymbolMarket{
            id                       : 0x2::object::new(arg19),
            user_positions           : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(1000, arg19),
            token_collateral_orders  : 0x2::object::new(arg19),
            option_collateral_orders : 0x2::object::new(arg19),
            market_info              : v2,
            market_config            : v5,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.option_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.option_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.option_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v6.option_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"), 0x2::vec_map::empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>());
        let v7 = AddTradingSymbolEvent{
            index           : arg2,
            base_token_type : v1,
            market_info     : v6.market_info,
            market_config   : v6.market_config,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<AddTradingSymbolEvent>(v7);
        0x2::object_table::add<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1, v6);
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

    public(friend) fun calculate_trading_fee_rate_mbp(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: vector<u64>) : vector<u64> {
        let (v0, v1) = if (arg0 > arg1) {
            (false, arg0 - arg1)
        } else {
            (true, arg1 - arg0)
        };
        let v2 = if (v0 == arg6) {
            let (v3, v4) = if (v1 > arg7) {
                (v0, v1 - arg7)
            } else {
                (!v0, arg7 - v1)
            };
            let _ = v3;
            v4
        } else {
            let _ = v0;
            v1 + arg7
        };
        if (v2 <= v1) {
            let v7 = 0x1::vector::empty<u64>();
            let v8 = &mut v7;
            0x1::vector::push_back<u64>(v8, *0x1::vector::borrow<u64>(&arg8, 0));
            0x1::vector::push_back<u64>(v8, 0);
            v7
        } else {
            let v9 = *0x1::vector::borrow<u64>(&arg8, 0);
            let v10 = *0x1::vector::borrow<u64>(&arg8, 1);
            let v11 = 0x1::vector::empty<u64>();
            let v12 = &mut v11;
            0x1::vector::push_back<u64>(v12, v9);
            0x1::vector::push_back<u64>(v12, 0x1::u64::min(v10, v9 + ((((v10 - v9) as u128) * ((((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v2 - v1, arg3, arg4, arg5) as u128) * 10000000 / ((((arg2 as u128) * (*0x1::vector::borrow<u64>(&arg8, 2) as u128) / 10000000) as u64) as u128)) as u64) as u128) / 10000000) as u64)) - v9);
            v11
        }
    }

    public fun cancel_linked_orders<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg6);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v3, remove_linked_orders<T0>(arg0, arg2, v2, arg3, arg4, arg5));
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg6), arg5);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public fun cancel_trading_order<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::option::is_some<address>(&arg5)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg6);
        } else {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        };
        let v0 = if (0x1::option::is_some<address>(&arg5)) {
            0x1::option::extract<address>(&mut arg5)
        } else {
            0x2::tx_context::sender(arg6)
        };
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v2 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v2);
        let v4 = take_order_by_order_id_and_price(v3, arg4, arg3, true, v0);
        assert!(0x1::option::is_some<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::order_not_found());
        let v5 = 0x1::option::destroy_some<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4);
        adjust_market_info_user_order_size(v3, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_side(&v5), true, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(&v5));
        let v6 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(&v5);
        if (0x1::option::is_some<u64>(&v6)) {
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v3.user_positions, 0x1::option::extract<u64>(&mut v6));
            assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v7) == v0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_position_linked_order_info(v7, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_id(&v5));
        };
        let v8 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_order<T0>(arg0, v5);
        let v9 = CancelTradingOrderEvent{
            user                       : v0,
            market_index               : arg2,
            order_id                   : arg3,
            trigger_price              : arg4,
            collateral_token           : 0x1::type_name::get<T0>(),
            base_token                 : v2,
            released_collateral_amount : 0x2::balance::value<T0>(&v8),
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CancelTradingOrderEvent>(v9);
        0x2::coin::from_balance<T0>(v8, arg6)
    }

    fun check_collateral_enough_when_adding_position<T0>(arg0: &SymbolMarket, arg1: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
            assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v2) == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(arg1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(v2)
        } else {
            0
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_amount<T0>(arg1) + v1 > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_filled_fee(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun check_collateral_enough_when_reducing_position<T0>(arg0: &SymbolMarket, arg1: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(arg1);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v1) == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(arg1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
        let (v2, v3, v4) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::calculate_unrealized_pnl(v1, arg4, arg5, arg6);
        v2 && 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_amount<T0>(arg1) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(v1) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(v3 + v4, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_decimal(v1), arg2, arg3) > (((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(arg1) as u128) * (arg6 as u128) / 10000000) as u64) || v3 >= v4 && 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_amount<T0>(arg1) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(v1) > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(v3 - v4, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_decimal(v1), arg2, arg3) + (((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(arg1) as u128) * (arg6 as u128) / 10000000) as u64) || 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_amount<T0>(arg1) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(v1) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(v4 - v3, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_decimal(v1), arg2, arg3) > (((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(arg1) as u128) * (arg6 as u128) / 10000000) as u64)
    }

    fun check_option_collateral_enough<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &SymbolMarket, arg4: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock) : bool {
        let v0 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(arg4);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&arg3.user_positions, 0x1::option::extract<u64>(&mut v0));
            assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v2) == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_option_position_collateral_amount<T0>(arg0, arg1, arg2, v2, arg10)
        } else {
            0
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_option_collateral_order_collateral_amount<T0>(arg0, arg1, arg2, arg4, arg10) + v1 > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_filled_fee(arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun check_reserve_enough<T0>(arg0: &SymbolMarket, arg1: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::LiquidityPool, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_reduce_only(arg2)) {
            true
        } else {
            let v1 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(arg1, 0x1::type_name::get<T0>());
            let v2 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(arg2);
            let (v3, v4) = if (0x1::option::is_some<u64>(&v2)) {
                let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v2));
                (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(v5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v5) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(arg2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size_decimal(v5), arg5, arg6), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_token_decimal(arg2), arg3, arg4))
            } else {
                (0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(arg2), arg0.market_info.size_decimal, arg5, arg6), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_token_decimal(arg2), arg3, arg4))
            };
            v4 > v3 && *0x1::vector::borrow<u64>(&v1, 0) >= *0x1::vector::borrow<u64>(&v1, 2) + v4 - v3 || true
        }
    }

    public fun create_trading_order<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg9: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg11: 0x1::option::Option<u64>, arg12: 0x2::coin::Coin<T0>, arg13: bool, arg14: bool, arg15: bool, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        deprecated();
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg12, 0x2::tx_context::sender(arg18));
    }

    public fun create_trading_order_v2<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg9: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg11: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg12: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg13: 0x1::option::Option<u64>, arg14: 0x2::coin::Coin<T0>, arg15: bool, arg16: bool, arg17: bool, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg20);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v1.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        assert!(v1.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        if (!arg15) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg7, true);
        };
        if (arg15) {
            assert!(0x1::option::is_some<u64>(&arg13), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::position_id_needed_with_reduce_only_order());
        };
        let v2 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v2);
        assert!(v3.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        assert!(v3.market_info.is_active || !v3.market_info.is_active && arg15, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_inactive());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v8 = 0x2::coin::into_balance<T0>(arg14);
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::get<T0>());
        let v11 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v9, v10, v4, v5);
        let v12 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(arg18, v3.market_info.size_decimal, arg19, v7);
        let v13 = if (v11 > 0) {
            let v14 = (((v12 as u128) * 10000000 / (v11 as u128)) as u64);
            assert!(v3.market_config.max_leverage_mbp >= v14, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::exceed_max_leverage());
            v14
        } else {
            100
        };
        assert!(arg15 && 0x1::option::is_some<u64>(&arg13) && arg18 % v3.market_config.lot_size == 0 || arg18 >= v3.market_config.min_size && arg18 % v3.market_config.lot_size == 0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_order_size());
        let v15 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v15);
        let v16 = 0x1::type_name::get<T0>();
        let v17 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(v12, v10, v4, v5);
        let v18 = if (0x1::option::is_some<u64>(&arg13)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_amount<T0>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&v3.user_positions, *0x1::option::borrow<u64>(&arg13)))
        } else {
            0
        };
        let v19 = if (v9 + v18 >= v17) {
            0
        } else {
            v17 - v9 - v18
        };
        assert!(!arg15 && 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_trading_order_size_valid(v15, v16, v19) || true, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::reach_max_single_order_reserve_usage());
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v15, v16, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v20 = v3.market_info.next_order_id;
        if (0x1::option::is_some<u64>(&arg13)) {
            let v21 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v3.user_positions, *0x1::option::borrow<u64>(&arg13));
            assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v21) != arg16, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::add_size_not_allowed());
            assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v21) == v0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::add_position_linked_order_info(v21, v20, arg19);
        } else if (arg16) {
            assert!(v3.market_info.user_long_position_size + arg18 <= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 0), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::exceed_max_open_interest());
        } else {
            assert!(v3.market_info.user_short_position_size + arg18 <= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::exceed_max_open_interest());
        };
        let v22 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::create_order<T0>(arg0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::symbol::create(v2, v1.quote_token_type), v13, arg15, arg16, arg17, arg18, v3.market_info.size_decimal, arg19, v8, v10, arg13, v20, v6, arg5, arg20);
        let v23 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v15, v16);
        let v24 = calculate_trading_fee_rate_mbp(v3.market_info.user_long_position_size, v3.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v23, 1), v3.market_info.size_decimal, v6, v7, arg16, arg18, v3.market_config.trading_fee_config);
        if (arg15) {
            check_collateral_enough_when_reducing_position<T0>(v3, &v22, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v24, 0) + *0x1::vector::borrow<u64>(&v24, 1));
        } else {
            assert!(check_collateral_enough_when_adding_position<T0>(v3, &v22, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v24, 0) + *0x1::vector::borrow<u64>(&v24, 1)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::token_collateral_not_enough());
        };
        assert!(check_reserve_enough<T0>(v3, v15, &v22, v4, v5, v6, v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_pool_reserve_not_enough());
        v3.market_info.next_order_id = v3.market_info.next_order_id + 1;
        let v25 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_order_filled(&v22, v6);
        let v26 = if (v25) {
            0x1::option::some<u64>(v6)
        } else {
            0x1::option::none<u64>()
        };
        let v27 = CreateTradingOrderEvent{
            user               : v0,
            market_index       : arg6,
            pool_index         : arg7,
            collateral_token   : 0x1::type_name::get<T0>(),
            base_token         : v2,
            order_id           : v20,
            linked_position_id : arg13,
            collateral_amount  : v9,
            leverage_mbp       : v13,
            reduce_only        : arg15,
            is_long            : arg16,
            is_stop_order      : arg17,
            size               : arg18,
            trigger_price      : arg19,
            filled             : v25,
            filled_price       : v26,
            u64_padding        : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderEvent>(v27);
        if (v25) {
            let (_, _) = execute_order_<T0>(arg0, arg6, v3, v15, v22, v1.protocol_fee_share_bp, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v24, 0) + *0x1::vector::borrow<u64>(&v24, 1), arg8, arg9, arg10, arg11, arg12, arg5, arg20);
        } else {
            adjust_market_info_user_order_size(v3, arg16, false, arg18);
            let v30 = get_mut_orders(v3, true, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_type_tag(&v22));
            if (!0x2::vec_map::contains<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v30, &arg19)) {
                0x2::vec_map::insert<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v30, arg19, 0x1::vector::singleton<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v22));
            } else {
                0x1::vector::push_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(0x2::vec_map::get_mut<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v30, &arg19), v22);
            };
        };
    }

    public fun create_trading_order_with_bid_receipt<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt, arg13: bool, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        deprecated();
        0x2::transfer::public_transfer<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(arg12, 0x2::tx_context::sender(arg15));
    }

    public fun create_trading_order_with_bid_receipt_v2<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg14: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt, arg15: bool, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        assert!(v0.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg8), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        assert!(v2.market_info.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_inactive());
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_token_decimal(arg2, arg8, v3);
        let v5 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg8);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v5);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v5, v3, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg8, true);
        let (_, v7, v8) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_bid_receipt_info(&arg14);
        let v9 = v8;
        let v10 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::verify_bid_receipt_collateral_trading_order_v2<T0, T2>(arg3, arg5, arg4, &arg14, arg15, arg6);
        if (v10 == b"E_BID_RECEIPT_HAS_BEEN_EXPIRED") {
            abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::bid_receipt_has_been_expired()
        };
        if (v10 == b"E_AUCTION_NOT_YET_ENDED") {
            abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::auction_not_yet_ended()
        };
        if (v10 == b"E_BID_RECEIPT_NOT_ITM") {
            abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::bid_receipt_not_itm()
        };
        if (v10 == b"E_BASE_TOKEN_MISMATCHED") {
            abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::base_token_mismatched()
        };
        if (v10 == b"E_INVALID_ORDER_SIDE") {
            abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_order_side()
        };
        if (v10 == b"E_COLLATERAL_TOKEN_TYPE_MISMATCHED") {
            abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::collateral_token_type_mismatched()
        };
        let v11 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_receipt_intrinsic_value_v2<T0>(arg3, arg5, arg4, &arg14, arg6);
        let v12 = *0x1::vector::borrow<u64>(&v9, 0);
        assert!(v12 >= v2.market_config.min_size && v12 % v2.market_config.lot_size == 0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_order_size());
        if (arg15) {
            assert!(v2.market_info.user_long_position_size + v12 <= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v2.market_config.u64_padding, 0), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::exceed_max_open_interest());
        } else {
            assert!(v2.market_info.user_short_position_size + v12 <= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v2.market_config.u64_padding, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::exceed_max_open_interest());
        };
        let (v13, v14) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v15, v16) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v17 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v12, v2.market_info.size_decimal, v15, v16), v4, v13, v14);
        let v18 = if (v11 >= v17) {
            0
        } else {
            v17 - v11
        };
        let v19 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_trading_order_size_valid(v19, v3, v18), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::reach_max_single_order_reserve_usage());
        let v20 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v19, v3);
        let v21 = 0x1::vector::empty<u64>();
        let v22 = &mut v21;
        0x1::vector::push_back<u64>(v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v2.market_config.u64_padding, 4));
        0x1::vector::push_back<u64>(v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v2.market_config.u64_padding, 5));
        0x1::vector::push_back<u64>(v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v2.market_config.u64_padding, 6));
        let v23 = calculate_trading_fee_rate_mbp(v2.market_info.user_long_position_size, v2.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v20, 1), v2.market_info.size_decimal, v15, v16, arg15, v12, v21);
        assert!(v17 < ((((v11 - (((v17 as u128) * ((*0x1::vector::borrow<u64>(&v23, 0) + *0x1::vector::borrow<u64>(&v23, 1)) as u128) / 10000000) as u64)) as u128) * (v2.market_config.option_collateral_max_leverage_mbp as u128) / 10000000) as u64), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::exceed_max_leverage());
        assert!(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_token(arg3, v7) == 0x1::type_name::get<T1>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::bid_token_mismatched());
        let v24 = v2.market_info.next_order_id;
        let v25 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>();
        0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v25, arg14);
        let v26 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::create_order_with_bid_receipts(arg0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::symbol::create(v1, v0.quote_token_type), v7, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_deposit_token(arg3, v7), 100, false, arg15, false, v12, v2.market_info.size_decimal, v15, v25, v4, 0x1::option::none<u64>(), v24, v15, arg16, arg6, arg17);
        assert!(check_option_collateral_enough<T0>(arg3, arg5, arg4, v2, &v26, v13, v14, v15, v16, *0x1::vector::borrow<u64>(&v23, 0) + *0x1::vector::borrow<u64>(&v23, 1), arg6), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::option_collateral_not_enough());
        assert!(check_reserve_enough<T0>(v2, v19, &v26, v13, v14, v15, v16), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_pool_reserve_not_enough());
        v2.market_info.next_order_id = v2.market_info.next_order_id + 1;
        let v27 = CreateTradingOrderWithBidReceiptsEvent{
            user                        : arg16,
            market_index                : arg7,
            pool_index                  : arg8,
            dov_index                   : v7,
            collateral_token            : 0x1::type_name::get<T0>(),
            base_token                  : v1,
            order_id                    : v24,
            collateral_in_deposit_token : v11,
            is_long                     : arg15,
            size                        : v12,
            trigger_price               : v15,
            filled                      : true,
            filled_price                : 0x1::option::some<u64>(v15),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderWithBidReceiptsEvent>(v27);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_order_filled(&v26, v15), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::option_collateral_order_not_filled());
        execute_option_collateral_order_<T0, T1>(arg0, arg3, arg5, arg4, v2, v19, v26, v0.protocol_fee_share_bp, v13, v14, v15, v16, *0x1::vector::borrow<u64>(&v23, 0) + *0x1::vector::borrow<u64>(&v23, 1), arg9, arg10, arg11, arg12, arg13, arg6, arg17);
    }

    fun deprecated() {
        abort 0
    }

    fun execute_option_collateral_order_<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &mut SymbolMarket, arg5: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::LiquidityPool, arg6: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg14: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg15: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg16: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg17: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(&arg6);
        let (v1, v2) = get_linked_position(arg4, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(&arg6), v0);
        let (v3, v4, v5, v6, v7, v8) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::order_filled_with_bid_receipts_collateral<T0, T1>(arg0, arg13, arg15, arg16, arg17, arg5, arg1, arg2, arg3, arg6, v1, arg4.market_info.next_position_id, arg8, arg9, arg10, arg11, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(arg5, 0x1::type_name::get<T0>()), arg4.market_info.cumulative_funding_rate_index_sign, arg4.market_info.cumulative_funding_rate_index, arg12, 0, arg18, arg19);
        let v9 = v5;
        let v10 = v4;
        let v11 = v3;
        0x2::balance::destroy_zero<T0>(v6);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v9, (((0x2::balance::value<T0>(&v9) as u128) * (arg7 as u128) / 10000) as u64)));
        0x2::balance::join<T0>(&mut v10, v9);
        let v12 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(&v11);
        let v13 = if (v12 > v2) {
            v12 - v2
        } else {
            v2 - v12
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::order_filled<T0>(arg5, v12 > v2, v13, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg19), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(&v11));
        let v14 = (((v8 as u128) * (arg4.market_config.exp_multiplier as u128) / (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::multiplier(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_usd_decimal()) as u128)) as u64);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::add_tails_exp_amount(arg0, arg13, arg14, v0, v14);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::add_exp_leaderboard(arg0, arg13, arg15, v0, v14, arg18, arg19);
        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(&v11) == arg4.market_info.next_position_id) {
            arg4.market_info.next_position_id = arg4.market_info.next_position_id + 1;
        };
        adjust_market_info_user_position_size(arg4, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_side(&arg6), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_reduce_only(&arg6), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(&arg6));
        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(&v11) > 0) {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut arg4.user_positions, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(&v11), v11);
        } else {
            let v15 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_type(&v11);
            let v16 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_symbol(&v11);
            let v17 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(&v11);
            let v18 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_decimal(&v11);
            let (v19, _, _, v22, v23, v24, v25, v26, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_position_with_bid_receipts(arg0, v11);
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
                        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_collateral<T0>(arg5, v35, arg8, arg9);
                        0x2::balance::value<T0>(&v35)
                    } else {
                        let v36 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::request_collateral<T0>(arg5, v24, arg8, arg9);
                        0x2::balance::join<T0>(&mut v31, v36);
                        0x2::balance::value<T0>(&v36)
                    };
                    0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::emit_realized_funding_event(v0, v15, v16, v17, v23, v33, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v33, v18, arg8, arg9), 0x1::vector::empty<u64>());
                };
                assert!(0x2::balance::value<T0>(&v31) >= v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::balance_not_enough_for_paying_fee());
                let v37 = 0x2::balance::value<T0>(&v31) - v22;
                let v38 = if (v37 >= v25 + v26) {
                    v25 + v26
                } else {
                    v37
                };
                let v39 = v37 - v38;
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v31, (((v38 as u128) * (arg7 as u128) / 10000) as u64)));
                let v40 = 0x2::balance::split<T0>(&mut v31, v39);
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_collateral<T0>(arg5, v31, arg8, arg9);
                let v41 = RealizeOptionPositionEvent{
                    position_user              : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(&v11),
                    position_id                : v17,
                    trading_symbol             : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::symbol::base_token(&v16),
                    realize_balance_token_type : v15,
                    exercise_balance_value     : v32,
                    user_remaining_value       : v39,
                    user_remaining_in_usd      : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v39, v18, arg8, arg9),
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

    fun execute_order_<T0>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::LiquidityPool, arg4: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg12: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg13: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg14: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg15: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (vector<u64>, vector<u64>) {
        let v0 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(&arg4);
        let (v1, v2) = get_linked_position(arg2, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(&arg4), v0);
        let v3 = v1;
        let (v4, v5) = if (0x1::option::is_some<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&v3)) {
            (0x1::option::some<u64>(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(0x1::option::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&v3))), 0x1::option::some<bool>(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(0x1::option::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&v3))))
        } else {
            (0x1::option::none<u64>(), 0x1::option::none<bool>())
        };
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10, v11) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::order_filled<T0>(arg0, arg11, arg13, arg14, arg15, arg4, v3, arg2.market_info.next_position_id, arg6, arg7, arg8, arg9, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(arg3, 0x1::type_name::get<T0>()), arg2.market_info.cumulative_funding_rate_index_sign, arg2.market_info.cumulative_funding_rate_index, arg10, arg16, arg17);
        let v12 = v8;
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::realize_position_pnl_and_fee<T0>(arg0, arg3, &mut v12, v10, v9, v2, arg5, arg6, arg7, arg17);
        let v13 = (((v11 as u128) * (arg2.market_config.exp_multiplier as u128) / (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::multiplier(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_usd_decimal()) as u128)) as u64);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::add_tails_exp_amount(arg0, arg11, arg12, v0, v13);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::add_exp_leaderboard(arg0, arg11, arg13, v0, v13, arg16, arg17);
        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(&v12) == arg2.market_info.next_position_id) {
            arg2.market_info.next_position_id = arg2.market_info.next_position_id + 1;
        };
        if (0x1::option::is_some<u64>(&v7)) {
            adjust_market_info_user_position_size(arg2, !*0x1::option::borrow<bool>(&v6), true, *0x1::option::borrow<u64>(&v7));
            let v14 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(&v12);
            if (v14 > 0) {
                adjust_market_info_user_position_size(arg2, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(&v12), false, v14);
            };
        } else {
            adjust_market_info_user_position_size(arg2, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_side(&arg4), false, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(&arg4));
        };
        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(&v12) == 0) {
            let (v17, v18, v19, v20) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_position<T0>(arg0, v12);
            let v21 = v17;
            0x2::balance::join<T0>(&mut v21, remove_linked_orders<T0>(arg0, arg1, arg2, v19, v20, v0));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg17), v0);
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_collateral<T0>(arg3, v18, arg6, arg7);
            (v19, v20)
        } else {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut arg2.user_positions, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(&v12), v12);
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        }
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

    public(friend) fun get_active_orders_by_order_tag<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: u8) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = get_orders(0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2).symbol_markets, 0x1::type_name::get<T0>()), true, arg3);
        let v2 = 0x2::vec_map::keys<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v1);
        while (0x1::vector::length<u64>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v2);
            let v4 = 0x2::vec_map::get<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v1, &v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4)) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4, v5)));
                v5 = v5 + 1;
            };
        };
        v0
    }

    public(friend) fun get_active_orders_by_order_tag_and_ctoken<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: u8) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = get_orders(0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2).symbol_markets, 0x1::type_name::get<T1>()), true, arg3);
        let v2 = 0x2::vec_map::keys<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v1);
        while (0x1::vector::length<u64>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v2);
            let v4 = 0x2::vec_map::get<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v1, &v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4)) {
                let v6 = 0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4, v5);
                if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_token(v6) == 0x1::type_name::get<T0>()) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v6));
                };
                v5 = v5 + 1;
            };
        };
        v0
    }

    public(friend) fun get_all_positions<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: u64, arg4: u64) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2).symbol_markets, 0x1::type_name::get<T0>()).user_positions;
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
                let (_, v8) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v1, v6);
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v8));
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

    public(friend) fun get_estimated_liquidation_price_and_pnl<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : (u64, bool, u64, bool, u64) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).symbol_markets, 0x1::type_name::get<T1>());
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v0.user_positions, arg9);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg8, 0);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg8, 0);
        let v6 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg7);
        let v7 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v1);
        let v8 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v6, 0x1::type_name::get<T0>());
        let v9 = if (v7) {
            let v10 = 0x1::vector::empty<u64>();
            let v11 = &mut v10;
            0x1::vector::push_back<u64>(v11, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v0.market_config.u64_padding, 4));
            0x1::vector::push_back<u64>(v11, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v0.market_config.u64_padding, 5));
            0x1::vector::push_back<u64>(v11, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v0.market_config.u64_padding, 6));
            v10
        } else {
            v0.market_config.trading_fee_config
        };
        let v12 = calculate_trading_fee_rate_mbp(v0.market_info.user_long_position_size, v0.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v8, 1), v0.market_info.size_decimal, v4, v5, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v1), v9);
        if (v7) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_option_position_collateral_amount<T0>(arg3, arg5, arg4, v1, arg8);
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_position_borrow_rate_and_funding_rate(v1, v2, v3, v4, v5, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v6, 0x1::type_name::get<T0>()), v0.market_info.cumulative_funding_rate_index_sign, v0.market_info.cumulative_funding_rate_index);
        let v13 = if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v1)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v0.market_config.u64_padding, 3)
        } else {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v0.market_config.u64_padding, 2)
        };
        let (v14, v15) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::calculate_unrealized_cost(v1);
        let (v16, v17, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::calculate_unrealized_pnl(v1, v4, v5, *0x1::vector::borrow<u64>(&v12, 0) + *0x1::vector::borrow<u64>(&v12, 1));
        (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_estimated_liquidation_price(v1, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), v2, v3, v5, *0x1::vector::borrow<u64>(&v12, 0) + *0x1::vector::borrow<u64>(&v12, 1), v13), v16, v17, v14, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v15, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::get<T0>()), v2, v3))
    }

    public(friend) fun get_expired_position_info(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg6);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg4);
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
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
                let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v5, 0);
                let v9 = 0;
                while (v9 < v6) {
                    let (v10, v11) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v8, v9 % v7);
                    if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v11)) {
                        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::option_position_bid_receipts_expired(arg3, v11)) {
                            let (v12, v13) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_option_collateral_info(v11);
                            let v14 = ExpiredPositionInfo{
                                position_id      : v10,
                                dov_index        : v12,
                                collateral_token : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_type(v11),
                                bid_token        : v13,
                                base_token       : v4,
                            };
                            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::bcs::to_bytes<ExpiredPositionInfo>(&v14));
                        };
                    };
                    if (v9 + 1 < v6 && (v9 + 1) % v7 == 0) {
                        v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v5, (((v9 + 1) / v7) as u16));
                    };
                    v9 = v9 + 1;
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v2);
        v1
    }

    fun get_linked_position(arg0: &mut SymbolMarket, arg1: 0x1::option::Option<u64>, arg2: address) : (0x1::option::Option<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>, u64) {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut arg0.user_positions, 0x1::option::extract<u64>(&mut arg1));
            assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(&v2) == arg2, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::user_mismatched());
            (0x1::option::some<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(&v2))
        } else {
            (0x1::option::none<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(), 0)
        }
    }

    public(friend) fun get_liquidation_info<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg10);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg7);
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg8), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg8);
        let v3 = 0x1::type_name::get<T0>();
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v2, v3, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v2);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v8 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v0.symbol_markets, v1);
        assert!(v8.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v9 = &v8.user_positions;
        let v10 = 0x1::vector::empty<vector<u8>>();
        let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v9);
        if (v11 > 0) {
            let v12 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v9) as u64);
            let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v9, 0);
            let v14 = 0;
            while (v14 < v11) {
                let (v15, v16) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v13, v14 % v12);
                let v17 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v16);
                let v18 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_type(v16);
                if (arg9 && v18 == v3) {
                    let v19 = if (v17) {
                        let (v20, v21) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_option_collateral_info(v16);
                        LiquidationInfo{position_id: v15, dov_index: 0x1::option::some<u64>(v20), bid_token: 0x1::option::some<0x1::type_name::TypeName>(v21)}
                    } else {
                        LiquidationInfo{position_id: v15, dov_index: 0x1::option::none<u64>(), bid_token: 0x1::option::none<0x1::type_name::TypeName>()}
                    };
                    let v22 = v19;
                    0x1::vector::push_back<vector<u8>>(&mut v10, 0x2::bcs::to_bytes<LiquidationInfo>(&v22));
                } else {
                    let v23 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v2, v3);
                    let v24 = if (v17) {
                        let v25 = 0x1::vector::empty<u64>();
                        let v26 = &mut v25;
                        0x1::vector::push_back<u64>(v26, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 4));
                        0x1::vector::push_back<u64>(v26, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 5));
                        0x1::vector::push_back<u64>(v26, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 6));
                        v25
                    } else {
                        v8.market_config.trading_fee_config
                    };
                    let v27 = calculate_trading_fee_rate_mbp(v8.market_info.user_long_position_size, v8.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v23, 1), v8.market_info.size_decimal, v6, v7, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v16), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v16), v24);
                    if (v18 == v3 && (v17 && 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_option_collateral_position_liquidated<T0>(arg3, arg5, arg4, v16, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v27, 0) + *0x1::vector::borrow<u64>(&v27, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 3), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v2, 0x1::type_name::get<T0>()), arg6) || 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_position_liquidated(v16, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v27, 0) + *0x1::vector::borrow<u64>(&v27, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v2, 0x1::type_name::get<T0>()), v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index))) {
                        let v28 = if (v17) {
                            let (v29, v30) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_option_collateral_info(v16);
                            LiquidationInfo{position_id: v15, dov_index: 0x1::option::some<u64>(v29), bid_token: 0x1::option::some<0x1::type_name::TypeName>(v30)}
                        } else {
                            LiquidationInfo{position_id: v15, dov_index: 0x1::option::none<u64>(), bid_token: 0x1::option::none<0x1::type_name::TypeName>()}
                        };
                        let v31 = v28;
                        0x1::vector::push_back<vector<u8>>(&mut v10, 0x2::bcs::to_bytes<LiquidationInfo>(&v31));
                    };
                };
                if (v14 + 1 < v11 && (v14 + 1) % v12 == 0) {
                    v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v9, (((v14 + 1) / v12) as u16));
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

    public(friend) fun get_max_releasing_collateral_amount<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64) : u64 {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg6).symbol_markets, 0x1::type_name::get<T1>());
        assert!(v0.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&v0.user_positions, arg8);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v6 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v6);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v6, 0x1::type_name::get<T0>(), 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v7 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v6, 0x1::type_name::get<T0>());
        let v8 = calculate_trading_fee_rate_mbp(v0.market_info.user_long_position_size, v0.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v7, 1), v0.market_info.size_decimal, v4, v5, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v1), v0.market_config.trading_fee_config);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::max_releasing_collateral_amount(v1, v2, v3, v4, v5, *0x1::vector::borrow<u64>(&v8, 0) + *0x1::vector::borrow<u64>(&v8, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v6, 0x1::type_name::get<T0>()), v0.market_config.max_leverage_mbp)
    }

    fun get_mut_orders(arg0: &mut SymbolMarket, arg1: bool, arg2: u8) : &mut 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>> {
        if (arg1) {
            if (arg2 == 0) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"))
            };
            if (arg2 == 1) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"))
            };
            if (arg2 == 2) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"))
            };
            if (arg2 == 3) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"))
            };
        } else {
            if (arg2 == 0) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.option_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"))
            };
            if (arg2 == 1) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.option_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"))
            };
            if (arg2 == 2) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.option_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"))
            };
            if (arg2 == 3) {
                return 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut arg0.option_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"))
            };
        };
        abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::unsupported_order_type_tag()
    }

    fun get_orders(arg0: &SymbolMarket, arg1: bool, arg2: u8) : &0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>> {
        if (arg1) {
            if (arg2 == 0) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"))
            };
            if (arg2 == 1) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"))
            };
            if (arg2 == 2) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"))
            };
            if (arg2 == 3) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"))
            };
        } else {
            if (arg2 == 0) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.option_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"))
            };
            if (arg2 == 1) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.option_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"))
            };
            if (arg2 == 2) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.option_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"))
            };
            if (arg2 == 3) {
                return 0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&arg0.option_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"))
            };
        };
        abort 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::unsupported_order_type_tag()
    }

    public(friend) fun get_user_orders(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: address) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2);
        let v2 = v1.symbols;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v2) > 0) {
            let v3 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v1.symbol_markets, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2));
            let v4 = 0;
            while (v4 <= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_max_order_type_tag()) {
                let v5 = get_orders(v3, true, v4);
                let v6 = 0x2::vec_map::keys<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v5);
                while (0x1::vector::length<u64>(&v6) > 0) {
                    let v7 = 0x1::vector::pop_back<u64>(&mut v6);
                    let v8 = 0x2::vec_map::get<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v5, &v7);
                    let v9 = 0;
                    while (v9 < 0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v8)) {
                        let v10 = 0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v8, v9);
                        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(v10) == arg3) {
                            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v10));
                        };
                        v9 = v9 + 1;
                    };
                };
                let v11 = get_orders(v3, false, v4);
                let v12 = 0x2::vec_map::keys<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v11);
                while (0x1::vector::length<u64>(&v12) > 0) {
                    let v13 = 0x1::vector::pop_back<u64>(&mut v12);
                    let v14 = 0x2::vec_map::get<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v11, &v13);
                    let v15 = 0;
                    while (v15 < 0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v14)) {
                        let v16 = 0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v14, v15);
                        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(v16) == arg3) {
                            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v16));
                        };
                        v15 = v15 + 1;
                    };
                };
                v4 = v4 + 1;
            };
        };
        v0
    }

    public(friend) fun get_user_positions(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: address) : vector<vector<u8>> {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2);
        let v2 = v1.symbols;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v2) > 0) {
            let v3 = &0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v1.symbol_markets, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2)).user_positions;
            let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v3);
            if (v4 > 0) {
                let v5 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v3) as u64);
                let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v3, 0);
                let v7 = 0;
                while (v7 < v4) {
                    let (_, v9) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v6, v7 % v5);
                    if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v9) == arg3) {
                        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v9));
                    };
                    if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                        v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(v3, (((v7 + 1) / v5) as u16));
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

    public fun liquidate<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg10);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg7, arg8);
        let v2 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v2);
        let v3 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v2, 0x1::type_name::get<T0>());
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg8, 0);
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg8, 0);
        let v8 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v8.user_positions, arg9);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_position_borrow_rate_and_funding_rate(v9, v4, v5, v6, v7, v3, v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index);
        let v10 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v9);
        let v11 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v2, 0x1::type_name::get<T0>());
        let v12 = if (v10) {
            let v13 = 0x1::vector::empty<u64>();
            let v14 = &mut v13;
            0x1::vector::push_back<u64>(v14, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 4));
            0x1::vector::push_back<u64>(v14, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 5));
            0x1::vector::push_back<u64>(v14, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 6));
            v13
        } else {
            v8.market_config.trading_fee_config
        };
        let v15 = calculate_trading_fee_rate_mbp(v8.market_info.user_long_position_size, v8.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v11, 1), v8.market_info.size_decimal, v6, v7, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v9), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v9), v12);
        let v16 = if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v9)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 3)
        } else {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 2)
        };
        let v17 = if (v10) {
            let (_, v19) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_option_collateral_info(v9);
            assert!(v19 == 0x1::type_name::get<T1>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::bid_token_mismatched());
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_option_collateral_position_liquidated<T0>(arg3, arg5, arg4, v9, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v15, 0) + *0x1::vector::borrow<u64>(&v15, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 3), v3, arg8)
        } else {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_position_liquidated(v9, v4, v5, v6, v7, *0x1::vector::borrow<u64>(&v15, 0) + *0x1::vector::borrow<u64>(&v15, 1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v8.market_config.u64_padding, 2), v3, v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index)
        };
        if (v17) {
            let v20 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v8.user_positions, arg9);
            let v21 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(&v20);
            let v22 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(&v20);
            let v23 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(&v20);
            let v24 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::usd_to_amount((((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v21, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size_decimal(&v20), v6, v7) as u128) * (100 as u128) / 10000) as u64), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_collateral_token_decimal(&v20), v4, v5);
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::order_filled<T0>(v2, false, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_reserve_amount(&v20), 0x2::balance::zero<T0>());
            adjust_market_info_user_position_size(v8, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(&v20), true, v21);
            let v25 = v24;
            if (v10) {
                let (v26, _, _, v29, v30, v31, v32, v33, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_position_with_bid_receipts(arg0, v20);
                let (v35, v36) = exercise_bid_receipts<T0, T1>(arg3, v26, arg10);
                let v37 = v36;
                let v38 = v35;
                let v39 = if (v24 > 0) {
                    let v40 = if (0x2::balance::value<T0>(&v38) > v24) {
                        v24
                    } else {
                        0x2::balance::value<T0>(&v38)
                    };
                    0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v38, v40));
                    v25 = v24 - v40;
                    v40
                } else {
                    0
                };
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_collateral<T0>(v2, v38, v4, v5);
                if (0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&v37) > 0) {
                    let v41 = 0x1::vector::empty<0x1::type_name::TypeName>();
                    let v42 = &mut v41;
                    0x1::vector::push_back<0x1::type_name::TypeName>(v42, 0x1::type_name::get<T0>());
                    0x1::vector::push_back<0x1::type_name::TypeName>(v42, 0x1::type_name::get<T1>());
                    let v43 = 0x1::vector::empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>();
                    0x1::vector::push_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>(&mut v43, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::create_unsettled_bid_receipt(v37, v23, v22, v41, false, v29, v32, v33, v30, v31, v25));
                    0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_receipt_collaterals(v2, v43);
                } else {
                    0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v37);
                };
                let v44 = 0x1::vector::empty<u64>();
                let v45 = &mut v44;
                0x1::vector::push_back<u64>(v45, v21);
                0x1::vector::push_back<u64>(v45, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_estimated_liquidation_price(v9, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), v4, v5, v7, *0x1::vector::borrow<u64>(&v15, 0) + *0x1::vector::borrow<u64>(&v15, 1), v16));
                let v46 = LiquidateEvent{
                    user                       : v22,
                    collateral_token           : 0x1::type_name::get<T0>(),
                    base_token                 : v1,
                    position_id                : v23,
                    collateral_price           : v4,
                    trading_price              : v6,
                    realized_liquidator_fee    : v39,
                    realized_value_for_lp_pool : 0x2::balance::value<T0>(&v38),
                    u64_padding                : v44,
                };
                0x2::event::emit<LiquidateEvent>(v46);
            } else {
                let (v47, v48, v49, v50) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_position<T0>(arg0, v20);
                let v51 = v47;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(remove_linked_orders<T0>(arg0, arg6, v8, v49, v50, v22), arg10), v22);
                let v52 = if (0x2::balance::value<T0>(&v51) > v24) {
                    v24
                } else {
                    0x2::balance::value<T0>(&v51)
                };
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v51, v52));
                0x2::balance::join<T0>(&mut v51, v48);
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_collateral<T0>(v2, v51, v4, v5);
                let v53 = 0x1::vector::empty<u64>();
                let v54 = &mut v53;
                0x1::vector::push_back<u64>(v54, v21);
                0x1::vector::push_back<u64>(v54, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_estimated_liquidation_price(v9, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), v4, v5, v7, *0x1::vector::borrow<u64>(&v15, 0) + *0x1::vector::borrow<u64>(&v15, 1), v16));
                let v55 = LiquidateEvent{
                    user                       : v22,
                    collateral_token           : 0x1::type_name::get<T0>(),
                    base_token                 : v1,
                    position_id                : v23,
                    collateral_price           : v4,
                    trading_price              : v6,
                    realized_liquidator_fee    : v52,
                    realized_value_for_lp_pool : 0x2::balance::value<T0>(&v51),
                    u64_padding                : v53,
                };
                0x2::event::emit<LiquidateEvent>(v55);
            };
        };
    }

    public fun manager_cancel_order_by_open_interest_limit<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg9);
        let v0 = 0;
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg4);
        assert!(v1.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v2 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg5, arg3);
        let v3 = 0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v1.symbol_markets, v2);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg5));
        let v4 = 0x2::vec_map::get<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(get_orders(v3, true, arg6), &arg7);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<address>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4) && v0 < arg8) {
            let v10 = 0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v4, v9);
            let v11 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(v10);
            if ((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_side(v10) && v3.market_info.user_long_position_size + v11 > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 0) || v3.market_info.user_short_position_size + v11 > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 1)) && 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_token(v10) == 0x1::type_name::get<T0>()) {
                0x1::vector::push_back<u64>(&mut v5, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_id(v10));
                0x1::vector::push_back<u64>(&mut v6, v11);
                0x1::vector::push_back<u64>(&mut v7, arg7);
                0x1::vector::push_back<address>(&mut v8, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(v10));
                v0 = v0 + 1;
            };
            v9 = v9 + 1;
        };
        let v12 = 0;
        while (v9 < 0x1::vector::length<u64>(&v5)) {
            let v13 = *0x1::vector::borrow<address>(&v8, v12);
            let v14 = cancel_trading_order<T0, T1>(arg0, arg1, arg4, *0x1::vector::borrow<u64>(&v5, v12), *0x1::vector::borrow<u64>(&v7, v12), 0x1::option::some<address>(v13), arg9);
            if (0x2::coin::value<T0>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v13);
            } else {
                0x2::coin::destroy_zero<T0>(v14);
            };
            v12 = v12 + 1;
        };
        if (v0 > 0) {
            let v15 = ManagerCancelOrdersEvent{
                reason           : 0x1::string::utf8(b"exceed_max_open_interest"),
                collateral_token : 0x1::type_name::get<T0>(),
                base_token       : v2,
                order_type_tag   : arg6,
                order_ids        : v5,
                order_sizes      : v6,
                order_prices     : v7,
                u64_padding      : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<ManagerCancelOrdersEvent>(v15);
        };
    }

    public fun manager_close_option_position<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        deprecated();
    }

    public fun manager_close_option_position_v2<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg15);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        assert!(v0.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg8), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg8);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v4);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v4, v3, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v2.user_positions, arg14);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::not_option_collateral_position());
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::option_position_bid_receipts_expired(arg3, v5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::bid_receipt_not_expired());
        let (v6, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v8, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        reduce_option_collateral_position_size_v2<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x1::option::none<u64>(), arg15);
        let v10 = ManagerCloseOptionPositionEvent{
            user                : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v5),
            collateral_token    : v3,
            base_token          : v1,
            position_id         : arg14,
            order_size          : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v5),
            collateral_price    : v6,
            trading_price       : v8,
            cancelled_order_ids : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_linked_order_ids(v5),
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerCloseOptionPositionEvent>(v10);
    }

    public fun manager_reduce_position<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg9: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        deprecated();
    }

    public fun manager_reduce_position_v2<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg9: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg11: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg12: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg15);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg7);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v3, v2, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v3);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v4 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let (v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v7, v8) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v9 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v9.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v9.user_positions, arg13);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_position_borrow_rate_and_funding_rate(v10, v5, v6, v7, v8, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v4, 0x1::type_name::get<T0>()), v9.market_info.cumulative_funding_rate_index_sign, v9.market_info.cumulative_funding_rate_index);
        let v11 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v10);
        let v12 = (((0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v10) as u128) * (arg14 as u128) / 10000) as u64) / v9.market_config.lot_size * v9.market_config.lot_size;
        let v13 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::manager_create_reduce_only_order<T0>(arg0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::symbol::create(v1, v0.quote_token_type), !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v10), v12, v9.market_info.size_decimal, v7, 0x2::balance::zero<T0>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::get<T0>()), arg13, v11, v9.market_info.next_order_id, v7, arg5, arg15);
        v9.market_info.next_order_id = v9.market_info.next_order_id + 1;
        let v14 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v4, v2);
        let v15 = calculate_trading_fee_rate_mbp(v9.market_info.user_long_position_size, v9.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v14, 1), v9.market_info.size_decimal, v7, v8, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v10), v12, v9.market_config.trading_fee_config);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_order_filled(&v13, v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::order_not_filled_immediately());
        let (v16, v17) = execute_order_<T0>(arg0, arg6, v9, v4, v13, v0.protocol_fee_share_bp, v5, v6, v7, v8, *0x1::vector::borrow<u64>(&v15, 0) + *0x1::vector::borrow<u64>(&v15, 1), arg8, arg9, arg10, arg11, arg12, arg5, arg15);
        let v18 = v16;
        if (0x1::vector::length<u64>(&v18) > 0) {
            cancel_linked_orders<T0, T1>(arg0, arg1, arg6, v18, v17, v11, arg15);
        };
        let v19 = ManagerReducePositionEvent{
            user                : v11,
            collateral_token    : v2,
            base_token          : v1,
            position_id         : arg13,
            reduced_size        : v12,
            collateral_price    : v5,
            trading_price       : v7,
            cancelled_order_ids : v18,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerReducePositionEvent>(v19);
    }

    public fun manager_remove_order<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess, arg9: &mut 0x2::tx_context::TxContext) : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg9);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg4, false);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_remove_liquidity_token_process_status(&arg8, 1);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg3);
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(cancel_trading_order<T0, T1>(arg0, arg1, arg3, arg6, arg7, 0x1::option::some<address>(arg5), arg9), arg5);
        arg8
    }

    public fun manager_remove_position<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: u64, arg13: bool, arg14: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess, arg15: &mut 0x2::tx_context::TxContext) : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess {
        deprecated();
        arg14
    }

    public fun manager_remove_position_v2<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg14: u64, arg15: bool, arg16: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess, arg17: &mut 0x2::tx_context::TxContext) : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg17);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg8, false);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_remove_liquidity_token_process_status(&arg16, 0);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg7);
        assert!(v0.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg8), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v2, 0x1::type_name::get<T0>(), 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v2);
        assert!(0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v0.symbol_markets, v1).market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        if (arg15) {
            reduce_option_collateral_position_size_v2<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x1::option::none<u64>(), arg17);
        } else {
            manager_reduce_position_v2<T0, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 10000, arg17);
        };
        arg16
    }

    public(friend) fun manager_update_process_status_after_order<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: u64, arg4: u64, arg5: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess, arg6: &0x2::tx_context::TxContext) : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg6);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg4, false);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_remove_liquidity_token_process_status(&arg5, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = get_active_orders_by_order_tag_and_ctoken<T0, T1>(arg0, arg1, arg3, v1);
            v0 = v0 + 0x1::vector::length<vector<u8>>(&v2);
            v1 = v1 + 1;
        };
        let v3 = ManagerUpdateProcessStatusAfterOrderEvent{
            market_index       : arg3,
            pool_index         : arg4,
            liquidity_token    : 0x1::type_name::get<T0>(),
            trading_base_token : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ManagerUpdateProcessStatusAfterOrderEvent>(v3);
        if (v0 == 0) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_remove_liquidity_token_process_token<T1>(&mut arg5, false);
            let v4 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_remove_liquidity_token_process_token(&arg5, true);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) == 0x1::vector::length<0x1::type_name::TypeName>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg3).symbols)) {
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_remove_liquidity_token_process_status(&mut arg5, 2);
            };
            return arg5
        };
        arg5
    }

    public(friend) fun manager_update_process_status_after_position<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess, arg10: &0x2::tx_context::TxContext) : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::RemoveLiquidityTokenProcess {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg10);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_token_pool_status<T0>(arg2, arg8, false);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::check_remove_liquidity_token_process_status(&arg9, 0);
        let v0 = get_liquidation_info<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, true, arg10);
        let v1 = ManagerUpdateProcessStatusAfterPositionEvent{
            market_index       : arg7,
            pool_index         : arg8,
            liquidity_token    : 0x1::type_name::get<T0>(),
            trading_base_token : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ManagerUpdateProcessStatusAfterPositionEvent>(v1);
        if (0x1::vector::length<vector<u8>>(&v0) == 0) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_remove_liquidity_token_process_token<T1>(&mut arg9, true);
            let v2 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_remove_liquidity_token_process_token(&arg9, true);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v2) == 0x1::vector::length<0x1::type_name::TypeName>(&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg7).symbols)) {
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_remove_liquidity_token_process_status(&mut arg9, 1);
            };
            return arg9
        };
        arg9
    }

    public fun match_trading_order<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg9: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg11: u8, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        deprecated();
    }

    public fun match_trading_order_v2<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg9: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg11: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg12: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg13: u8, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg16);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v2.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v3 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v2.symbols, &v3), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg7);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v5, v4, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v5);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v6 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v2.symbol_markets, v3);
        assert!(v6.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let v7 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let (v8, v9) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        let (v10, v11) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v12 = get_mut_orders(v6, true, arg13);
        let (_, v14) = 0x2::vec_map::remove<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v12, &arg14);
        let v15 = v14;
        let v16 = 0x1::vector::empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>();
        while (0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v15) > 0 && v0 < arg15) {
            let v17 = 0x1::vector::pop_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v15);
            let v18 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_side(&v17);
            let v19 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(&v17);
            let v20 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(&v17);
            let v21 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_linked_position_id(&v17);
            if (0x1::option::is_some<u64>(&v21)) {
                if (!0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<u64>(&v6.user_positions, 0x1::option::extract<u64>(&mut v21))) {
                    let v22 = remove_linked_order_<T0>(arg0, arg6, v6, v17, v20);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg16), v20);
                    continue
                };
            };
            let v23 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_reduce_only(&v17) && false || v18 && v6.market_info.user_long_position_size + v19 > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v6.market_config.u64_padding, 0) || v6.market_info.user_short_position_size + v19 > 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v6.market_config.u64_padding, 1);
            let v24 = if (check_reserve_enough<T0>(v6, v7, &v17, v8, v9, v10, v11)) {
                if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_collateral_token(&v17) == 0x1::type_name::get<T0>()) {
                    if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::check_order_filled(&v17, v10)) {
                        !v23
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v24) {
                let v25 = 0x1::type_name::get<T0>();
                if ((!0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::token_pool_is_active(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool(v7, &v25)) || !v6.market_info.is_active) && !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_reduce_only(&v17)) {
                    0x1::vector::push_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v16, v17);
                    continue
                };
                adjust_market_info_user_order_size(v6, v18, true, v19);
                let v26 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v7, v4);
                let v27 = calculate_trading_fee_rate_mbp(v6.market_info.user_long_position_size, v6.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v26, 1), v6.market_info.size_decimal, v10, v11, v18, v19, v6.market_config.trading_fee_config);
                let (_, _) = execute_order_<T0>(arg0, arg6, v6, v7, v17, v2.protocol_fee_share_bp, v8, v9, v10, v11, *0x1::vector::borrow<u64>(&v27, 0) + *0x1::vector::borrow<u64>(&v27, 1), arg8, arg9, arg10, arg11, arg12, arg5, arg16);
                0x1::vector::push_back<u64>(&mut v1, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_id(&v17));
                v0 = v0 + 1;
                continue
            };
            0x1::vector::push_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v16, v17);
        };
        if (0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v15) > 0) {
            0x1::vector::append<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v16, v15);
        } else {
            0x1::vector::destroy_empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v15);
        };
        if (0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v16) > 0) {
            0x2::vec_map::insert<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(get_mut_orders(v6, true, arg13), arg14, v16);
        } else {
            0x1::vector::destroy_empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v16);
        };
        if (v0 > 0) {
            let v30 = MatchTradingOrderEvent{
                collateral_token  : 0x1::type_name::get<T0>(),
                base_token        : v3,
                matched_order_ids : v1,
                u64_padding       : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<MatchTradingOrderEvent>(v30);
        };
    }

    entry fun new_markets<T0, T1>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        let v0 = Markets{
            id                    : 0x2::object::new(arg3),
            index                 : arg1.num_market,
            lp_token_type         : 0x1::type_name::get<T0>(),
            quote_token_type      : 0x1::type_name::get<T1>(),
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

    public fun reduce_option_collateral_position_size<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: u64, arg13: 0x1::option::Option<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        deprecated();
    }

    public fun reduce_option_collateral_position_size_v2<T0, T1, T2>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg10: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg11: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg12: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg13: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::competition::CompetitionConfig, arg14: u64, arg15: 0x1::option::Option<u64>, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        assert!(v1.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        assert!(v1.lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg8), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v2 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v2), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v2);
        assert!(v3.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg5), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        if (0x1::option::is_some<u64>(&arg15)) {
            assert!(*0x1::option::borrow<u64>(&arg15) % v3.market_config.lot_size == 0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_order_size());
        };
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_token_decimal(arg2, arg8, 0x1::type_name::get<T0>());
        let v6 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg8);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v6);
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::oracle_matched(v6, v4, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4)), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<u64, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::Position>(&mut v3.user_positions, arg14);
        if (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v7) != v0) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg16);
        };
        assert!(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::is_option_collateral_position(v7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::not_option_collateral_position());
        let (v8, v9) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_option_collateral_info(v7);
        assert!(v9 == 0x1::type_name::get<T1>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::bid_token_mismatched());
        let v10 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v7);
        let v11 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size(v7);
        if (0x1::option::is_some<u64>(&arg15)) {
            assert!(*0x1::option::borrow<u64>(&arg15) <= v11, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_order_size());
        };
        let (v12, v13) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let (v14, v15) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg5, arg6, 0);
        let v16 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::update_position_borrow_rate_and_funding_rate(v7, v12, v13, v14, v15, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_cumulative_borrow_rate(v16, 0x1::type_name::get<T0>()), v3.market_info.cumulative_funding_rate_index_sign, v3.market_info.cumulative_funding_rate_index);
        let (v17, v18) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::calculate_unrealized_cost(v7);
        let v19 = if (0x1::option::is_none<u64>(&arg15)) {
            v11
        } else {
            0x1::option::extract<u64>(&mut arg15)
        };
        let v20 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_token_pool_state(v16, v4);
        let v21 = 0x1::vector::empty<u64>();
        let v22 = &mut v21;
        0x1::vector::push_back<u64>(v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 4));
        0x1::vector::push_back<u64>(v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 5));
        0x1::vector::push_back<u64>(v22, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::get_u64_vector_value(&v3.market_config.u64_padding, 6));
        let v23 = calculate_trading_fee_rate_mbp(v3.market_info.user_long_position_size, v3.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v20, 1), v3.market_info.size_decimal, v14, v15, !0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_side(v7), v19, v21);
        let (v24, v25, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::calculate_unrealized_pnl(v7, v14, v15, *0x1::vector::borrow<u64>(&v23, 0) + *0x1::vector::borrow<u64>(&v23, 1));
        let v27 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_option_position_exercise_value<T0>(arg3, arg5, arg4, v7, arg6);
        assert!(v24 && (v17 && v25 + v27 >= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v18, v5, v12, v13) || true) || v17 && 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v27, v5, v12, v13) >= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v18, v5, v12, v13) + v25 || 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v18, v5, v12, v13) + 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v27, v5, v12, v13) >= v25, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::perp_position_losses());
        if (v19 < v11) {
            0x2::transfer::public_transfer<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::split_bid_receipt(arg3, v7, v19, arg16), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v7));
        };
        let v28 = v3.market_info.next_order_id;
        let v29 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::create_order_with_bid_receipts(arg0, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::symbol::create(v2, v1.quote_token_type), v8, v4, 100, true, !v10, false, v19, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_size_decimal(v7), v14, 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(), v5, 0x1::option::some<u64>(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_id(v7)), v28, v14, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_position_user(v7), arg6, arg16);
        let v30 = CreateTradingOrderWithBidReceiptsEvent{
            user                        : v0,
            market_index                : arg7,
            pool_index                  : arg8,
            dov_index                   : v8,
            collateral_token            : 0x1::type_name::get<T0>(),
            base_token                  : v2,
            order_id                    : v28,
            collateral_in_deposit_token : v27,
            is_long                     : !v10,
            size                        : v19,
            trigger_price               : v14,
            filled                      : true,
            filled_price                : 0x1::option::some<u64>(v14),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderWithBidReceiptsEvent>(v30);
        v3.market_info.next_order_id = v3.market_info.next_order_id + 1;
        execute_option_collateral_order_<T0, T1>(arg0, arg3, arg5, arg4, v3, v16, v29, v1.protocol_fee_share_bp, v12, v13, v14, v15, *0x1::vector::borrow<u64>(&v23, 0) + *0x1::vector::borrow<u64>(&v23, 1), arg9, arg10, arg11, arg12, arg13, arg6, arg16);
    }

    fun remove_linked_order_<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder, arg4: address) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_trading_symbol(&arg3);
        adjust_market_info_user_order_size(arg2, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_side(&arg3), true, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_size(&arg3));
        let v2 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::remove_order<T0>(arg0, arg3);
        let v3 = CancelTradingOrderEvent{
            user                       : arg4,
            market_index               : arg1,
            order_id                   : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_id(&arg3),
            trigger_price              : 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_price(&arg3),
            collateral_token           : 0x1::type_name::get<T0>(),
            base_token                 : v0,
            released_collateral_amount : 0x2::balance::value<T0>(&v2),
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CancelTradingOrderEvent>(v3);
        v2
    }

    fun remove_linked_orders<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: vector<u64>, arg4: vector<u64>, arg5: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (0x1::vector::length<u64>(&arg3) > 0) {
            let v1 = take_order_by_order_id_and_price(arg2, 0x1::vector::pop_back<u64>(&mut arg4), 0x1::vector::pop_back<u64>(&mut arg3), true, arg5);
            if (0x1::option::is_some<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v1)) {
                0x2::balance::join<T0>(&mut v0, remove_linked_order_<T0>(arg0, arg1, arg2, 0x1::option::extract<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v1), arg5));
            };
            0x1::option::destroy_none<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v1);
        };
        v0
    }

    entry fun remove_trading_symbol<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::remove<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(!v2.market_info.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::active_trading_symbol());
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
        assert!(v3, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::order_or_position_size_not_zero());
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"limit_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"limit_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"stop_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>>(&mut v2.option_collateral_orders, 0x1::string::utf8(b"stop_sell_orders")));
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

    entry fun resume_market(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2).is_active = true;
        let v0 = ResumeMarketEvent{
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumeMarketEvent>(v0);
    }

    entry fun resume_trading_symbol<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        assert!(v0.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1).market_info.is_active = true;
        let v2 = ResumeTradingSymbolEvent{
            index              : arg2,
            resumed_base_token : v1,
            u64_padding        : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumeTradingSymbolEvent>(v2);
    }

    public fun settle_receipt_collateral<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg8);
        assert!(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6).lp_token_type == 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_lp_token_type(arg2, arg7), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::lp_token_type_mismatched());
        let v0 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::safety_check(v0);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get<T1>();
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg5, 0);
        let v5 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_receipt_collateral(v0);
        let v6 = 0x1::vector::empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>();
        while (0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>(&v5) > 0) {
            let (v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::destruct_unsettled_bid_receipt(0x1::vector::pop_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>(&mut v5));
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
                let v27 = if (0x2::balance::value<T0>(&v26) > v17) {
                    v17
                } else {
                    0x2::balance::value<T0>(&v26)
                };
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v26, v27));
                let v28 = false;
                let v29 = v28;
                let v30 = v13 + v14;
                let v31 = if (v11) {
                    if (v28) {
                        v30 + v12
                    } else if (v30 > v12) {
                        v30 - v12
                    } else {
                        v29 = true;
                        v12 - v30
                    }
                } else if (v28) {
                    let v31 = if (v30 > v12) {
                        v30 - v12
                    } else {
                        v29 = false;
                        v12 - v30
                    };
                    v31 = v31 + v12;
                    v31
                } else {
                    v30 + v12
                };
                if (v15) {
                    if (v29) {
                        v31 = v31 + v16;
                    } else if (v31 > v16) {
                        v31 = v31 - v16;
                    } else {
                        v31 = v16 - v31;
                        v29 = true;
                    };
                } else if (v29) {
                    if (v31 > v16) {
                        v31 = v31 - v16;
                    } else {
                        v31 = v16 - v31;
                        v29 = false;
                    };
                    v31 = v31 + v16;
                } else {
                    v31 = v31 + v16;
                };
                0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_collateral<T0>(v0, v26, v3, v4);
                let v32 = SettleReceiptCollateralEvent{
                    user                        : v9,
                    collateral_token            : v1,
                    bid_token                   : v2,
                    position_id                 : v8,
                    realized_liquidator_fee     : v27,
                    remaining_unrealized_sign   : v29,
                    remaining_unrealized_value  : v31,
                    remaining_value_for_lp_pool : 0x2::balance::value<T0>(&v26),
                    u64_padding                 : 0x1::vector::empty<u64>(),
                };
                0x2::event::emit<SettleReceiptCollateralEvent>(v32);
                continue
            };
            0x1::vector::push_back<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>(&mut v6, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::create_unsettled_bid_receipt(v19, v8, v9, v18, v11, v12, v13, v14, v15, v16, v17));
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::put_receipt_collaterals(v0, v6);
        0x1::vector::destroy_empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow::UnsettledBidReceipt>(v5);
    }

    entry fun suspend_market(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2).is_active = false;
        let v0 = SuspendMarketEvent{
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendMarketEvent>(v0);
    }

    entry fun suspend_trading_symbol<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg3);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        assert!(v0.is_active, 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::markets_inactive());
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1).market_info.is_active = false;
        let v2 = SuspendTradingSymbolEvent{
            index                : arg2,
            suspended_base_token : v1,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendTradingSymbolEvent>(v2);
    }

    fun take_order_by_order_id_and_price(arg0: &mut SymbolMarket, arg1: u64, arg2: u64, arg3: bool, arg4: address) : 0x1::option::Option<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder> {
        let v0 = 0x1::option::none<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>();
        let v1 = 0;
        while (v1 <= 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_max_order_type_tag()) {
            let v2 = get_mut_orders(arg0, arg3, v1);
            if (0x2::vec_map::contains<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v2, &arg1)) {
                let (_, v4) = 0x2::vec_map::remove<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v2, &arg1);
                let v5 = v4;
                let v6 = 0;
                while (v6 < 0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v5)) {
                    let v7 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_id(0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v5, v6));
                    let v8 = if (&v7 == &arg2) {
                        let v9 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::get_order_user(0x1::vector::borrow<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v5, v6));
                        &v9 == &arg4
                    } else {
                        false
                    };
                    if (v8) {
                        0x1::option::fill<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v0, 0x1::vector::remove<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&mut v5, v6));
                        break
                    };
                    v6 = v6 + 1;
                };
                if (0x1::vector::length<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v5) == 0) {
                    0x1::vector::destroy_empty<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(v5);
                } else {
                    0x2::vec_map::insert<u64, vector<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>>(v2, arg1, v5);
                };
                if (0x1::option::is_some<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::position::TradingOrder>(&v0)) {
                    break
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun trading_symbol_exists<T0>(arg0: &Markets) : bool {
        0x2::object_table::contains<0x1::type_name::TypeName, SymbolMarket>(&arg0.symbol_markets, 0x1::type_name::get<T0>())
    }

    public fun update_funding_rate<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg7);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::oracle_mismatched());
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg4, 0);
        let v5 = v2.market_info.last_funding_ts_ms;
        let v6 = 0x2::clock::timestamp_ms(arg4) / v2.market_config.funding_interval_ts_ms * v2.market_config.funding_interval_ts_ms;
        if (v6 > v5) {
            let v7 = (v6 - v5) / v2.market_config.funding_interval_ts_ms;
            let v8 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_tvl_usd(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_liquidity_pool(arg2, arg6));
            let v9 = if (v2.market_info.user_long_position_size > v2.market_info.user_short_position_size) {
                v2.market_info.user_long_position_size - v2.market_info.user_short_position_size
            } else {
                v2.market_info.user_short_position_size - v2.market_info.user_long_position_size
            };
            let v10 = if (v8 > 0) {
                (((v2.market_config.basic_funding_rate as u128) * (0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::amount_to_usd(v9, v2.market_info.size_decimal, v3, v4) as u128) / (v8 as u128)) as u64)
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

    entry fun update_market_config<T0>(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<vector<u64>>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<vector<u64>>, arg17: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg17);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::trading_symbol_not_existed());
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
            assert!(*0x1::vector::borrow<u64>(&v2.market_config.trading_fee_config, 1) >= *0x1::vector::borrow<u64>(&v2.market_config.trading_fee_config, 0), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_trading_fee_config());
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
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 0, 0x1::option::extract<u64>(&mut arg12));
        };
        if (0x1::option::is_some<u64>(&arg13)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 1, 0x1::option::extract<u64>(&mut arg13));
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 2, 0x1::option::extract<u64>(&mut arg14));
        };
        if (0x1::option::is_some<u64>(&arg15)) {
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 3, 0x1::option::extract<u64>(&mut arg15));
        };
        if (0x1::option::is_some<vector<u64>>(&arg16)) {
            let v3 = 0x1::option::extract<vector<u64>>(&mut arg16);
            assert!(*0x1::vector::borrow<u64>(&v3, 1) >= *0x1::vector::borrow<u64>(&v3, 0), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::invalid_trading_fee_config());
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 4, *0x1::vector::borrow<u64>(&v3, 0));
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 5, *0x1::vector::borrow<u64>(&v3, 1));
            0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 6, *0x1::vector::borrow<u64>(&v3, 2));
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

    entry fun update_protocol_fee_share_bp(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::verify(arg0, arg4);
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

    // decompiled from Move bytecode v6
}

