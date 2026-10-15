module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::trading {
    struct MarketRegistry has key {
        id: 0x2::object::UID,
        referral_registry: 0x2::object::UID,
        markets: 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::LinkedObjectTable<u64, Markets>,
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
        user_positions: 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::KeyedBigVector,
        token_collateral_orders: 0x2::object::UID,
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
        min_size: u64,
        lot_size: u64,
        trading_fee_config: vector<u64>,
        basic_funding_rate: u64,
        funding_interval_ts_ms: u64,
        exp_multiplier: u64,
        cool_down_threshold_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct USD has drop {
        dummy_field: bool,
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

    struct SocializationForgivenEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        position_id: u64,
        forgiven_charge: u64,
        socialization_index: u64,
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

    public fun increase_collateral<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, 0x1::option::some<u64>(arg7), false, arg9);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5).symbol_markets, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg6, arg4);
        let v3 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg6);
        let v4 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(v3, 0x1::type_name::with_defining_ids<T0>());
        let v5 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v2.user_positions, arg7);
        let (v6, v7) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg4);
        let (v8, v9) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg4);
        let v10 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v5);
        let v11 = 0x2::coin::value<T0>(&arg8);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::settle_socialization(v5, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(v3, 0x1::type_name::with_defining_ids<T0>()), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        let (_, _, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::update_position_borrow_rate_and_funding_rate(v5, v6, v7, v8, v9, v4, v2.market_info.cumulative_funding_rate_index_sign, v2.market_info.cumulative_funding_rate_index);
        let v15 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v5);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::increase_collateral<T0>(v5, 0x2::coin::into_balance<T0>(arg8), v6, v7, v8, v9);
        let v16 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v5);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_reserve_amount<T0>(v3, v16 > v15, 0x1::u64::diff(v16, v15));
        let v17 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v3, v0);
        assert!(!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_liquidated(v5, v6, v7, v8, v9, calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v2.market_config.u64_padding, 7), v2.market_info.user_long_position_size, v2.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v17, 1), v2.market_info.size_decimal, v8, v9, !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v5), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v5), v2.market_config.trading_fee_config), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v2.market_config.u64_padding, 2), v4, v2.market_info.cumulative_funding_rate_index_sign, v2.market_info.cumulative_funding_rate_index), 19);
        let v18 = IncreaseCollateralEvent{
            user                        : 0x2::tx_context::sender(arg9),
            market_index                : arg5,
            pool_index                  : arg6,
            position_id                 : arg7,
            collateral_token            : v0,
            base_token                  : v1,
            increased_collateral_amount : v11,
            remaining_collateral_amount : v10 + v11,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<IncreaseCollateralEvent>(v18);
    }

    public fun release_collateral<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, 0x1::option::some<u64>(arg7), true, arg9);
        let (v0, v1) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg4);
        let (v2, v3) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg4);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = 0x1::type_name::with_defining_ids<T1>();
        let v6 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5).symbol_markets, v5);
        let v7 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v6.user_positions, arg7);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg6, arg4);
        let v8 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg6);
        let v9 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(v8, v4);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::settle_socialization(v7, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(v8, 0x1::type_name::with_defining_ids<T0>()), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        let (_, _, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::update_position_borrow_rate_and_funding_rate(v7, v0, v1, v2, v3, v9, v6.market_info.cumulative_funding_rate_index_sign, v6.market_info.cumulative_funding_rate_index);
        assert!(get_max_releasing_collateral_amount_(v8, v7, &v6.market_info, &v6.market_config, v4, v0, v1, v2, v3, v9) >= arg8, 7);
        let v13 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v7);
        assert!(v13 >= arg8, 19);
        let v14 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v7);
        let v15 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v7);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_reserve_amount<T0>(v8, v15 > v14, 0x1::u64::diff(v15, v14));
        let v16 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v8, v4);
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_idle_amount(v8, v4) >= *0x1::vector::borrow<u64>(&v16, 2), 23);
        let v17 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v8, v4);
        assert!(!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_liquidated(v7, v0, v1, v2, v3, calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v6.market_config.u64_padding, 7), v6.market_info.user_long_position_size, v6.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v17, 1), v6.market_info.size_decimal, v2, v3, !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v7), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v7), v6.market_config.trading_fee_config), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v6.market_config.u64_padding, 2), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(v8, v4), v6.market_info.cumulative_funding_rate_index_sign, v6.market_info.cumulative_funding_rate_index), 19);
        let v18 = ReleaseCollateralEvent{
            user                        : 0x2::tx_context::sender(arg9),
            market_index                : arg5,
            pool_index                  : arg6,
            position_id                 : arg7,
            collateral_token            : v4,
            base_token                  : v5,
            released_collateral_amount  : arg8,
            remaining_collateral_amount : v13 - arg8,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ReleaseCollateralEvent>(v18);
        0x2::coin::from_balance<T0>(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::release_collateral<T0>(v7, arg8, v0, v1, v2, v3), arg9)
    }

    entry fun add_trading_symbol<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg19);
        assert_market_parameters_sane(arg5, arg7, arg10, arg15, arg12);
        assert!(arg3 <= 9, 19);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 0);
        validate_trading_fee_config(&arg8);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.symbols, v1);
        let v2 = 0x2::clock::timestamp_ms(arg18) / arg10 * arg10;
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
            previous_last_funding_ts_ms                 : v2 - arg10,
            previous_cumulative_funding_rate_index_sign : true,
            previous_cumulative_funding_rate_index      : 0,
            u64_padding                                 : 0x1::vector::empty<u64>(),
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg13);
        0x1::vector::push_back<u64>(v5, arg14);
        0x1::vector::push_back<u64>(v5, arg15);
        0x1::vector::push_back<u64>(v5, 0);
        0x1::vector::push_back<u64>(v5, 0);
        0x1::vector::push_back<u64>(v5, 0);
        0x1::vector::push_back<u64>(v5, 0);
        0x1::vector::push_back<u64>(v5, arg16);
        0x1::vector::push_back<u64>(v5, arg17);
        let v6 = MarketConfig{
            oracle_id                 : 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg4),
            max_leverage_mbp          : arg5,
            min_size                  : arg6,
            lot_size                  : arg7,
            trading_fee_config        : arg8,
            basic_funding_rate        : arg9,
            funding_interval_ts_ms    : arg10,
            exp_multiplier            : arg11,
            cool_down_threshold_ts_ms : arg12,
            u64_padding               : v4,
        };
        let v7 = SymbolMarket{
            id                      : 0x2::object::new(arg19),
            user_positions          : 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::new<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(200, arg19),
            token_collateral_orders : 0x2::object::new(arg19),
            market_info             : v3,
            market_config           : v6,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders"), 0x2::vec_map::empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders"), 0x2::vec_map::empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders"), 0x2::vec_map::empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v7.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders"), 0x2::vec_map::empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>());
        0x2::dynamic_field::add<0x1::string::String, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::TwapBuffer>(&mut v7.id, 0x1::string::utf8(b"twap_buffer"), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::new(3600000, 128));
        let v8 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v8, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 1, arg2, v8, 0x1::vector::empty<0x2::object::ID>(), vector[], arg19);
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

    fun assert_market_parameters_sane(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1 > 0, 19);
        assert!(arg4 <= 604800000, 19);
        assert!(arg2 > 0, 19);
        assert!(arg0 > 0, 19);
        assert!(arg3 < 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale(), 19);
        assert!((arg0 as u128) * (arg3 as u128) < (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128), 19);
    }

    fun assert_price_guard_allows<T0>(arg0: &SymbolMarket, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_price_guard_bound<T0>(arg0, arg1);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::assert_trading_allowed(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun assert_price_guard_bound<T0>(arg0: &SymbolMarket, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard) {
        assert!(is_price_guard_bound(arg0), 1506);
        assert_price_guard_matches<T0>(arg0, arg1);
    }

    fun assert_price_guard_matches<T0>(arg0: &SymbolMarket, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard) {
        assert!(*0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"price_guard_id")) == 0x2::object::id<0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard>(arg1), 1506);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::assert_base_type<T0>(arg1);
    }

    fun assert_profit_vault_allowed(arg0: &0x2::object::UID, arg1: &SymbolMarket, arg2: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault) {
        let v0 = 0x1::string::utf8(b"profit_vault_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(arg0, v0)) {
            assert!(*0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(arg0, v0) == 0x2::object::id<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault>(arg2), 2700);
        } else {
            assert!(!(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg1.market_config.u64_padding, 8) == 1), 2700);
        };
    }

    entry fun bind_insurance_fund(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::InsuranceFund, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::string::utf8(b"insurance_fund_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v0.id, v1)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x2::object::ID>(&mut v0.id, v1);
        };
        let v2 = 0x2::object::id<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::InsuranceFund>(arg3);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v0.id, v1, v2);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, v2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 9, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), v3, vector[], arg4);
    }

    entry fun bind_price_guard<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::assert_base_type<T0>(arg3);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = 0x1::string::utf8(b"price_guard_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v2.id, v3)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x2::object::ID>(&mut v2.id, v3);
        };
        let v4 = 0x2::object::id<0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard>(arg3);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v2.id, v3, v4);
        let v5 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5, v1);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v6, v4);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 11, arg2, v5, v6, vector[], arg4);
    }

    entry fun bind_profit_vault(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::string::utf8(b"profit_vault_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v0.id, v1)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x2::object::ID>(&mut v0.id, v1);
        };
        let v2 = 0x2::object::id<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault>(arg3);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v0.id, v1, v2);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, v2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 8, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), v3, vector[], arg4);
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
                let v9 = (((arg3 as u128) * (*0x1::vector::borrow<u64>(&arg9, 2) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128)) as u64);
                if (v9 > 0) {
                    0x1::u64::min(v8, v7 + ((((v8 - v7) as u128) * ((((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v2 - v1, arg4, arg5, arg6) as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) / (v9 as u128)) as u64) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128)) as u64))
                } else {
                    v7
                }
            }
        } else if (v2 <= v1) {
            *0x1::vector::borrow<u64>(&arg9, 0)
        } else {
            let v10 = *0x1::vector::borrow<u64>(&arg9, 0);
            let v11 = *0x1::vector::borrow<u64>(&arg9, 1);
            let v12 = (((arg3 as u128) * (*0x1::vector::borrow<u64>(&arg9, 2) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128)) as u64);
            let v13 = if (v12 > 0) {
                (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v2 - v1, arg4, arg5, arg6) as u128) / (v12 as u128)) as u64)
            } else {
                0
            };
            let v14 = 0x1::u64::min(v13 / *0x1::vector::borrow<u64>(&arg9, 4), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale());
            let v15 = v14;
            let v16 = 1;
            while (v16 < *0x1::vector::borrow<u64>(&arg9, 3)) {
                let v17 = (v15 as u128) * (v14 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128);
                v15 = (v17 as u64);
                v16 = v16 + 1;
            };
            0x1::u64::min(v11, v10 + ((((v11 - v10) as u128) * (v15 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128)) as u64))
        }
    }

    public fun cancel_expired_order<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = take_order_by_order_id_and_price(v2, arg4, arg3, arg5);
        assert!(0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v3), 5);
        let v4 = 0x1::option::destroy_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v3);
        let v5 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_expires_ts_ms(&v4);
        assert!(v5 > 0 && 0x2::clock::timestamp_ms(arg6) >= v5, 1800);
        remove_expired_order_<T0>(arg0, arg2, v2, v4, v1, v5, arg7);
    }

    public fun cancel_linked_orders<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg6);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v3, remove_linked_orders<T0>(arg0, arg2, v2, arg3, arg4, arg5));
        if (0x2::balance::value<T0>(&v3) > 0) {
            return_to_user<T0>(v3, arg5, arg6);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public fun cancel_trading_order<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (0x1::option::is_some<address>(&arg5)) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg6);
            0x1::option::extract<address>(&mut arg5)
        } else {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
            0x2::tx_context::sender(arg6)
        };
        let v1 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1.symbols, &v2), 1);
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v1.symbol_markets, v2);
        let v4 = take_order_by_order_id_and_price(v3, arg4, arg3, v0);
        assert!(0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v4), 5);
        let v5 = 0x1::option::destroy_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v4);
        let v6 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(&v5);
        adjust_market_info_user_order_size(v3, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_side(&v5), true, v6);
        let v7 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(&v5);
        if (0x1::option::is_some<u64>(&v7)) {
            let v8 = 0x1::option::extract<u64>(&mut v7);
            if (0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::contains<u64>(&v3.user_positions, v8)) {
                let v9 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v3.user_positions, v8);
                check_position_user_matched(v9, v0);
                0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_position_linked_order_info(v9, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_id(&v5));
            };
        };
        let v10 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_order<T0>(arg0, v5);
        let v11 = CancelTradingOrderEvent{
            user                       : v0,
            market_index               : arg2,
            order_id                   : arg3,
            trigger_price              : arg4,
            collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
            base_token                 : v2,
            released_collateral_amount : 0x2::balance::value<T0>(&v10),
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CancelTradingOrderEvent>(v11);
        if (v0 != 0x2::tx_context::sender(arg6)) {
            let v12 = ManagerCancelOrdersEvent{
                reason           : 0x1::string::utf8(b"manager"),
                collateral_token : 0x1::type_name::with_defining_ids<T0>(),
                base_token       : v2,
                order_type_tag   : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_type_tag(&v5),
                order_id         : arg3,
                order_size       : v6,
                order_price      : arg4,
                u64_padding      : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<ManagerCancelOrdersEvent>(v12);
        };
        if (v0 != 0x2::tx_context::sender(arg6)) {
            return_to_user<T0>(v10, v0, arg6);
            return 0x2::coin::zero<T0>(arg6)
        };
        0x2::coin::from_balance<T0>(v10, arg6)
    }

    fun check_collateral_enough_when_adding_position<T0>(arg0: &SymbolMarket, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : bool {
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
            check_position_user_matched(v2, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_user(arg1));
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v2)
        } else {
            0
        };
        let (v3, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_trading_fee(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(arg1), arg0.market_info.size_decimal, arg2, arg3, arg4, arg5, arg6, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token_decimal(arg1));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_amount<T0>(arg1) + v1 > v3 + arg7
    }

    fun check_collateral_enough_when_reducing_position<T0>(arg0: &SymbolMarket, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : bool {
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(arg1);
        let v1 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
        check_position_user_matched(v1, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_user(arg1));
        let (v2, v3, v4) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_unrealized_pnl(v1, arg4, arg5, arg6);
        let v5 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v1);
        let v6 = 0x1::u64::min(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(arg1), v5);
        let (v7, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_trading_fee(v6, arg0.market_info.size_decimal, arg2, arg3, arg4, arg5, arg6, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token_decimal(arg1));
        v2 && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_amount<T0>(arg1) + 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v1) + 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(scale_to_fill(v3 + v4, v6, v5), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_decimal(v1), arg2, arg3) > v7 + arg7 || v3 >= v4 && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_amount<T0>(arg1) + 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v1) > 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(scale_to_fill(v3 - v4, v6, v5), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_decimal(v1), arg2, arg3) + v7 + arg7 || 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_amount<T0>(arg1) + 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v1) + 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(scale_to_fill(v4 - v3, v6, v5), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_decimal(v1), arg2, arg3) > v7 + arg7
    }

    fun check_position_user_matched(arg0: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position, arg1: address) {
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(arg0) == arg1, 16);
    }

    fun check_reserve_enough<T0>(arg0: &SymbolMarket, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg2: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(arg2)) {
            true
        } else {
            let v1 = 0x1::type_name::with_defining_ids<T0>();
            let v2 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(arg1, v1);
            let v3 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(arg2);
            let v4 = 0;
            let v5 = if (0x1::option::is_some<u64>(&v3)) {
                let v6 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v3));
                v4 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v6);
                0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v6) + 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(arg2), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size_decimal(v6), arg5, arg6)
            } else {
                0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(arg2), arg0.market_info.size_decimal, arg5, arg6)
            };
            let v7 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v5, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token_decimal(arg2), arg3, arg4);
            v7 > v4 && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_idle_amount(arg1, v1) >= *0x1::vector::borrow<u64>(&v2, 2) + v7 - v4 || true
        }
    }

    public fun collect_position_funding_fee<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, 0x1::option::some<u64>(arg7), true, arg8);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5).symbol_markets, 0x1::type_name::with_defining_ids<T1>());
        assert!(v1.market_info.is_active, 3);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg6, arg4);
        let v2 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg6);
        let v3 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(v2, 0x1::type_name::with_defining_ids<T0>());
        let v4 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v1.user_positions, arg7);
        let (v5, v6) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg4);
        let (v7, v8) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg4);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::settle_socialization(v4, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(v2, 0x1::type_name::with_defining_ids<T0>()), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        let (_, _, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::update_position_borrow_rate_and_funding_rate(v4, v5, v6, v7, v8, v3, v1.market_info.cumulative_funding_rate_index_sign, v1.market_info.cumulative_funding_rate_index);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::realize_funding_fee<T0>(v2, v4, v5, v6, arg8);
        let v12 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v4);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::increase_collateral<T0>(v4, 0x2::balance::zero<T0>(), v5, v6, v7, v8);
        let v13 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v4);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_reserve_amount<T0>(v2, v13 > v12, 0x1::u64::diff(v13, v12));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::assert_idle_covers_reserve_of(v2, v0);
        let v14 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v2, v0);
        assert!(!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_liquidated(v4, v5, v6, v7, v8, calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v1.market_config.u64_padding, 7), v1.market_info.user_long_position_size, v1.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v14, 1), v1.market_info.size_decimal, v7, v8, !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v4), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v4), v1.market_config.trading_fee_config), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v1.market_config.u64_padding, 2), v3, v1.market_info.cumulative_funding_rate_index_sign, v1.market_info.cumulative_funding_rate_index), 19);
    }

    public fun create_trading_order<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x2::coin::Coin<T0>, arg10: bool, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = if (arg10) {
            0x1::option::none<u64>()
        } else {
            arg8
        };
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, v1, !arg10, arg15);
        if (!arg10) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::check_token_pool_status<T0>(arg2, arg7, true);
        };
        if (arg10) {
            assert!(0x1::option::is_some<u64>(&arg8), 28);
        };
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        let v5 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v4.symbol_markets, v2);
        assert!(v5.market_info.is_active || !v5.market_info.is_active && arg10, 3);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let (v6, v7) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg5);
        let (v8, v9) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg5);
        if (!arg10) {
            assert_price_guard_allows<T1>(v5, arg4, v8, arg5);
        };
        let v10 = 0x2::coin::into_balance<T0>(arg9);
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::with_defining_ids<T0>());
        let v13 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v11, v12, v6, v7);
        let v14 = if (arg11) {
            if (arg12) {
                0x1::u64::max(arg14, v8)
            } else {
                0x1::u64::min(arg14, v8)
            }
        } else if (arg12) {
            0x1::u64::min(arg14, v8)
        } else {
            0x1::u64::max(arg14, v8)
        };
        let v15 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg13, v5.market_info.size_decimal, v14, v9);
        let v16 = if (v13 > 0) {
            let v17 = (((v15 as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) / (v13 as u128)) as u64);
            assert!(v5.market_config.max_leverage_mbp >= v17, 7);
            v17
        } else {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale()
        };
        assert!(arg10 && 0x1::option::is_some<u64>(&arg8) && arg13 > 0 && arg13 % v5.market_config.lot_size == 0 || arg13 >= v5.market_config.min_size && arg13 % v5.market_config.lot_size == 0, 13);
        let v18 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let v19 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v15, v12, v6, v7);
        let v20 = if (0x1::option::is_some<u64>(&arg8)) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v5.user_positions, *0x1::option::borrow<u64>(&arg8)))
        } else {
            0
        };
        let v21 = if (v11 + v20 >= v19) {
            0
        } else {
            v19 - v11 - v20
        };
        assert!(!arg10 && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::check_trading_order_size_valid(v18, v3, v21) || true, 20);
        let v22 = v5.market_info.next_order_id;
        if (0x1::option::is_some<u64>(&arg8)) {
            let v23 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v5.user_positions, *0x1::option::borrow<u64>(&arg8));
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_update_timestamp(v23, arg5, v5.market_config.cool_down_threshold_ts_ms);
            check_position_user_matched(v23, v0);
            assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_type(v23) == v3, 8);
            let v24 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v23);
            if (arg10) {
                assert!(arg11 != v24, 12);
            } else {
                let v25 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v23);
                assert!(arg11 == v24 || arg13 <= v25, 13);
                let v26 = if (arg11 == v24) {
                    v25 + arg13
                } else if (arg13 > v25) {
                    arg13 - v25
                } else {
                    0
                };
                if (v26 > 0) {
                    let v27 = v13 + 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v23), v12, v6, v7);
                    assert!(v27 > 0, 7);
                    assert!((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v26, v5.market_info.size_decimal, v14, v9) as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) <= (v5.market_config.max_leverage_mbp as u128) * (v27 as u128), 7);
                };
            };
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::add_position_linked_order_info(v23, v22, arg14);
        } else if (arg11) {
            assert!(v5.market_info.user_long_position_size + arg13 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v5.market_config.u64_padding, 0), 31);
        } else {
            assert!(v5.market_info.user_short_position_size + arg13 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v5.market_config.u64_padding, 1), 31);
        };
        let v28 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::create_order<T0>(arg0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::create(v2, v4.quote_token_type), v16, arg10, arg11, arg12, arg13, v5.market_info.size_decimal, arg14, v10, v12, arg8, v22, v8, arg5, arg15);
        let v29 = if (arg10) {
            0
        } else {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v5.market_config.u64_padding, 11)
        };
        if (v29 > 0) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::set_order_expires_ts_ms(&mut v28, 0x2::clock::timestamp_ms(arg5) + v29);
        };
        let v30 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v18, v3);
        let v31 = calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v5.market_config.u64_padding, 7), v5.market_info.user_long_position_size, v5.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v30, 1), v5.market_info.size_decimal, v8, v9, arg11, arg13, v5.market_config.trading_fee_config);
        if (0x1::option::is_none<u64>(&arg8) && !arg10) {
            let (_, v33) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_trading_fee(arg13, v5.market_info.size_decimal, v6, v7, v8, v9, v31, v12);
            assert!(v13 > v33, 7);
            assert!((v15 as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) <= (v5.market_config.max_leverage_mbp as u128) * ((v13 - v33) as u128), 7);
        };
        if (arg10 || 0x1::option::is_some<u64>(&arg8) && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v5.user_positions, *0x1::option::borrow<u64>(&arg8))) != arg11) {
            assert!(check_collateral_enough_when_reducing_position<T0>(v5, &v28, v6, v7, v8, v9, v31, linked_position_debts<T0>(v5, v18, &v28, v6, v7, v8, v9)), 17);
        } else {
            assert!(check_collateral_enough_when_adding_position<T0>(v5, &v28, v6, v7, v8, v9, v31, linked_position_debts<T0>(v5, v18, &v28, v6, v7, v8, v9)), 17);
        };
        assert!(check_reserve_enough<T0>(v5, v18, &v28, v6, v7, v8, v9), 23);
        v5.market_info.next_order_id = v5.market_info.next_order_id + 1;
        let v34 = CreateTradingOrderEvent{
            user                      : v0,
            market_index              : arg6,
            pool_index                : arg7,
            collateral_token          : 0x1::type_name::with_defining_ids<T0>(),
            base_token                : v2,
            order_id                  : v22,
            linked_position_id        : arg8,
            collateral_amount         : v11,
            leverage_mbp              : v16,
            reduce_only               : arg10,
            is_long                   : arg11,
            is_stop_order             : arg12,
            size                      : arg13,
            trigger_price             : arg14,
            trading_pair_oracle_price : v8,
            filled                    : false,
            filled_price              : 0x1::option::none<u64>(),
            u64_padding               : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CreateTradingOrderEvent>(v34);
        adjust_market_info_user_order_size(v5, arg11, false, arg13);
        let v35 = get_mut_orders(v5, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_type_tag(&v28));
        if (!0x2::vec_map::contains<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v35, &arg14)) {
            0x2::vec_map::insert<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v35, arg14, 0x1::vector::singleton<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v28));
        } else {
            0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(0x2::vec_map::get_mut<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v35, &arg14), v28);
        };
    }

    fun execute_order_<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg4: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault, arg5: 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg13: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::user::TypusUserRegistry, arg14: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg15: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::competition::CompetitionConfig, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<u64>, vector<u64>) {
        let (v0, v1, v2, v3) = prepare_order_execution<T0>(arg2, arg3, &arg5);
        let v4 = v1;
        let v5 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(arg3, 0x1::type_name::with_defining_ids<T0>());
        if (0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4)) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::settle_socialization(0x1::option::borrow_mut<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v4), v5, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        };
        let v6 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_side(&arg5);
        let (v7, v8) = if (0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4)) {
            (0x1::option::some<u64>(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(0x1::option::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4))), 0x1::option::some<bool>(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(0x1::option::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4))))
        } else {
            (0x1::option::none<u64>(), 0x1::option::none<bool>())
        };
        let v9 = v8;
        let v10 = v7;
        let v11 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(&arg5);
        let v12 = if (0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4)) {
            let v13 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(0x1::option::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4));
            if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(0x1::option::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4)) != v6) {
                if (v13 > v11) {
                    v11
                } else {
                    v13
                }
            } else {
                v11
            }
        } else {
            v11
        };
        let v14 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(arg3, 0x1::type_name::with_defining_ids<T0>());
        let (v15, v16, v17, v18) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::order_filled<T0>(arg0, arg12, arg14, arg15, arg5, v4, arg2.market_info.next_position_id, arg8, arg9, arg10, arg11, v3, arg2.market_info.cumulative_funding_rate_index_sign, arg2.market_info.cumulative_funding_rate_index, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::discount_fee_rate(calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg2.market_config.u64_padding, 7), arg2.market_info.user_long_position_size, arg2.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v14, 1), arg2.market_info.size_decimal, arg10, arg11, v6, v12, arg2.market_config.trading_fee_config), arg7), arg16, arg17);
        let v19 = v15;
        let v20 = 0x1::option::is_none<u64>(&v10) || 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(&v19) > *0x1::option::borrow<u64>(&v10);
        let v21 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::realize_position_pnl_and_fee<T0>(arg0, arg3, &mut v19, v17, v16, v2, v20, arg6, arg8, arg9);
        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(&v19) > 0) {
            let v22 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(&v19);
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::increase_collateral<T0>(&mut v19, 0x2::balance::zero<T0>(), arg8, arg9, arg10, arg11);
            let v23 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(&v19);
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_reserve_amount<T0>(arg3, v23 > v22, 0x1::u64::diff(v23, v22));
        };
        let v24 = if (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg2.market_config.u64_padding, 8) == 1) {
            if (!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::is_whitelist(arg4, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(&v19))) {
                0x2::balance::value<T0>(&v21) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v24) {
            let v25 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_symbol(&v19);
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::put_user_profit<T0>(arg4, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(&v19), 0x2::balance::split<T0>(&mut v21, 0x2::balance::value<T0>(&v21)), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::base_token(&v25), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_id(&v19), 0x2::object::id<SymbolMarket>(arg2), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_id(&arg5), arg16);
        };
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::add_tails_exp_and_leaderboard(arg0, arg12, arg13, arg14, v0, v18, arg2.market_config.exp_multiplier, arg16, arg17);
        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_id(&v19) == arg2.market_info.next_position_id) {
            arg2.market_info.next_position_id = arg2.market_info.next_position_id + 1;
        };
        if (0x1::option::is_none<u64>(&v10)) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::set_socialization_entry_index(&mut v19, v5);
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::note_position_opened<T0>(arg3);
        };
        if (0x1::option::is_some<u64>(&v10)) {
            adjust_market_info_user_position_size(arg2, !*0x1::option::borrow<bool>(&v9), true, *0x1::option::borrow<u64>(&v10));
            let v26 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(&v19);
            if (v26 > 0) {
                adjust_market_info_user_position_size(arg2, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(&v19), false, v26);
            };
        } else {
            adjust_market_info_user_position_size(arg2, v6, false, v11);
        };
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::put_collateral<T0>(arg3, 0x2::balance::zero<T0>(), arg8, arg9);
        let (v27, v28) = if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(&v19) == 0) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::note_position_closed<T0>(arg3);
            let (v29, v30, v31, v32) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_position<T0>(arg0, v19);
            0x2::balance::join<T0>(&mut v21, v29);
            0x2::balance::join<T0>(&mut v21, remove_linked_orders<T0>(arg0, arg1, arg2, v31, v32, v0));
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::put_collateral<T0>(arg3, v30, arg8, arg9);
            (v31, v32)
        } else {
            0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::push_back<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut arg2.user_positions, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_id(&v19), v19);
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        (v21, v27, v28)
    }

    fun get_linked_position(arg0: &mut SymbolMarket, arg1: 0x1::option::Option<u64>, arg2: address) : (0x1::option::Option<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>, u64) {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v2 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::swap_remove_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut arg0.user_positions, 0x1::option::extract<u64>(&mut arg1));
            check_position_user_matched(&v2, arg2);
            (0x1::option::some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(v2), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(&v2))
        } else {
            (0x1::option::none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(), 0)
        }
    }

    public(friend) fun get_markets_bcs(arg0: &MarketRegistry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = &arg0.markets;
        let v2 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::front<u64, Markets>(v1);
        while (0x1::option::is_some<u64>(v2)) {
            let v3 = *0x1::option::borrow<u64>(v2);
            let v4 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow<u64, Markets>(v1, v3);
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
            v2 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::next<u64, Markets>(v1, v3);
        };
        v0
    }

    fun get_max_releasing_collateral_amount_(arg0: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position, arg2: &MarketInfo, arg3: &MarketConfig, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : u64 {
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(arg0, arg4);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::max_releasing_collateral_amount(arg1, arg5, arg6, arg7, arg8, calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg3.u64_padding, 7), arg2.user_long_position_size, arg2.user_short_position_size, *0x1::vector::borrow<u64>(&v0, 1), arg2.size_decimal, arg7, arg8, !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(arg1), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(arg1), arg3.trading_fee_config), arg9, arg2.cumulative_funding_rate_index_sign, arg2.cumulative_funding_rate_index, arg3.max_leverage_mbp)
    }

    public(friend) fun get_mut_market_id(arg0: &mut MarketRegistry, arg1: u64) : &mut 0x2::object::UID {
        &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg0.markets, arg1).id
    }

    fun get_mut_orders(arg0: &mut SymbolMarket, arg1: u8) : &mut 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>> {
        0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut arg0.token_collateral_orders, get_order_key(arg1))
    }

    fun get_order_key(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"limit_buy_orders")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"limit_sell_orders")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"stop_buy_orders")
        } else {
            assert!(arg0 == 3, 6);
            0x1::string::utf8(b"stop_sell_orders")
        }
    }

    fun get_trading_fee_config(arg0: &MarketConfig) : vector<u64> {
        arg0.trading_fee_config
    }

    public(friend) fun get_user_positions(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &MarketRegistry, arg2: u64, arg3: address) : vector<vector<u8>> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow<u64, Markets>(&arg1.markets, arg2);
        let v2 = v1.symbols;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v2) > 0) {
            let v3 = &0x2::object_table::borrow<0x1::type_name::TypeName, SymbolMarket>(&v1.symbol_markets, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2)).user_positions;
            let v4 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::length(v3);
            if (v4 > 0) {
                let v5 = (0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::slice_size(v3) as u64);
                let v6 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_slice<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(v3, 0);
                let v7 = 0;
                while (v7 < v4) {
                    let (_, v9) = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_from_slice<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(v6, v7 % v5);
                    if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(v9) == arg3) {
                        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(v9));
                    };
                    if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                        v6 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_slice<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(v3, (((v7 + 1) / v5) as u16));
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
            markets           : 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::new<u64, Markets>(arg0),
            num_market        : 0,
            u64_padding       : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::share_object<MarketRegistry>(v0);
    }

    entry fun init_twap_buffer<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v3 = 0x1::string::utf8(b"twap_buffer");
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&v2.id, v3), 1600);
        0x2::dynamic_field::add<0x1::string::String, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::TwapBuffer>(&mut v2.id, v3, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::new(3600000, 128));
    }

    fun insurance_fund_bound(arg0: &Markets, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::InsuranceFund) : bool {
        let v0 = 0x1::string::utf8(b"insurance_fund_id");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return false
        };
        assert!(*0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, v0) == 0x2::object::id<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::InsuranceFund>(arg1), 1900);
        true
    }

    fun is_price_guard_bound(arg0: &SymbolMarket) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"price_guard_id"))
    }

    fun linked_position_debts<T0>(arg0: &SymbolMarket, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg2: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        let v1 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&arg0.user_positions, 0x1::option::extract<u64>(&mut v0));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::pending_debts_in_collateral(v1, arg3, arg4, arg5, arg6, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(arg1, 0x1::type_name::with_defining_ids<T0>()), arg0.market_info.cumulative_funding_rate_index_sign, arg0.market_info.cumulative_funding_rate_index) + 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::pending_socialization_charge(v1, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(arg1, 0x1::type_name::with_defining_ids<T0>()), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale())
    }

    public fun liquidate<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::InsuranceFund, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg9);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5);
        assert!(v0.lp_token_type == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_lp_token_type(arg2, arg6), 4);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = insurance_fund_bound(v0, arg3);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg6, arg7);
        let v3 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg6);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::oracle_matched(v3, v4, 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg4)), 7);
        let v5 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(v3, v4);
        let (v6, v7) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg4, arg7);
        let (v8, v9) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg4, arg7);
        let v10 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        let v11 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v10.user_positions, arg8);
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_type(v11) == 0x1::type_name::with_defining_ids<T0>(), 8);
        let v12 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v3, 0x1::type_name::with_defining_ids<T0>());
        let v13 = calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v10.market_config.u64_padding, 7), v10.market_info.user_long_position_size, v10.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v12, 1), v10.market_info.size_decimal, v8, v9, !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v11), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v11), get_trading_fee_config(&v10.market_config));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::settle_socialization(v11, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(v3, 0x1::type_name::with_defining_ids<T0>()), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        let v14 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_liquidated(v11, v6, v7, v8, v9, v13, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v10.market_config.u64_padding, 2), v5, v10.market_info.cumulative_funding_rate_index_sign, v10.market_info.cumulative_funding_rate_index) && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_liquidated(v11, v6, v7, twap_gate_price(v10, v8, arg7), v9, v13, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v10.market_config.u64_padding, 2), v5, v10.market_info.cumulative_funding_rate_index_sign, v10.market_info.cumulative_funding_rate_index) || 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_liquidated(v11, v6, v7, v8, v9, v13, 0, v5, v10.market_info.cumulative_funding_rate_index_sign, v10.market_info.cumulative_funding_rate_index);
        let (v15, v16) = if (v14) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_position_equity_usd(v11, v6, v7, v8, v9, v13, v5, v10.market_info.cumulative_funding_rate_index_sign, v10.market_info.cumulative_funding_rate_index)
        } else {
            (0, false)
        };
        let (_, _, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::update_position_borrow_rate_and_funding_rate(v11, v6, v7, v8, v9, v5, v10.market_info.cumulative_funding_rate_index_sign, v10.market_info.cumulative_funding_rate_index);
        if (v14) {
            let v20 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::swap_remove_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v10.user_positions, arg8);
            let v21 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(&v20);
            let v22 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(&v20);
            let v23 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_decimal(&v20);
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::order_filled<T0>(v3, false, false, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(&v20), 0x2::balance::zero<T0>());
            adjust_market_info_user_position_size(v10, !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(&v20), true, v21);
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::note_position_closed<T0>(v3);
            let (v24, v25, v26, v27) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_position<T0>(arg0, v20);
            let v28 = v24;
            return_to_user<T0>(remove_linked_orders<T0>(arg0, arg5, v10, v26, v27, v22), v22, arg9);
            let v29 = 0x1::u64::min(0x2::balance::value<T0>(&v28), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount((((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v21, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size_decimal(&v20), v8, v9) as u128) * (100 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64), v23, v6, v7));
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::charge_liquidator_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v28, v29));
            0x2::balance::join<T0>(&mut v28, v25);
            let v30 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v15, v23, v6, v7);
            let v31 = if (v16) {
                v30 + v29
            } else if (v29 > v30) {
                v29 - v30
            } else {
                0
            };
            if (v31 > 0) {
                let v32 = if (v2) {
                    let v33 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::absorb<T0>(arg3, v31);
                    0x2::balance::join<T0>(&mut v28, v33);
                    0x2::balance::value<T0>(&v33)
                } else {
                    0
                };
                let v34 = v31 - v32;
                if (v2) {
                    0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund::record_uncovered<T0>(arg3, v34 - 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialize_loss<T0>(v3, v34));
                };
            };
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::put_collateral<T0>(v3, v28, v6, v7);
            let v35 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v35, v21);
            let v36 = LiquidateEvent{
                user                       : v22,
                collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
                base_token                 : v1,
                position_id                : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_id(&v20),
                collateral_price           : v6,
                trading_price              : v8,
                realized_liquidator_fee    : v29,
                realized_value_for_lp_pool : 0x2::balance::value<T0>(&v28),
                u64_padding                : v35,
            };
            0x2::event::emit<LiquidateEvent>(v36);
        };
    }

    public fun manager_clear_position<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg6);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg3);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v2), 1);
        assert!(v0.lp_token_type == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_lp_token_type(arg2, arg4), 4);
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v2);
        let v4 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg4);
        let v5 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::swap_remove_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v3.user_positions, arg5);
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_type(&v5) == v1, 8);
        let v6 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(&v5);
        let v7 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(&v5);
        let v8 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(v4, v1);
        let v9 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_socialization_pending_charge(&v5);
        let v10 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::pending_socialization_charge(&v5, v8, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        let v11 = if (v9 > 18446744073709551615 - v10) {
            18446744073709551615
        } else {
            v9 + v10
        };
        if (v11 > 0) {
            let v12 = SocializationForgivenEvent{
                user                : v6,
                collateral_token    : v1,
                position_id         : arg5,
                forgiven_charge     : v11,
                socialization_index : v8,
            };
            0x2::event::emit<SocializationForgivenEvent>(v12);
        };
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::note_position_closed<T0>(v4);
        let (v13, v14, v15, v16) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_position<T0>(arg0, v5);
        let v17 = v13;
        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(&v5)) {
            v3.market_info.user_long_position_size = v3.market_info.user_long_position_size - v7;
        } else {
            v3.market_info.user_short_position_size = v3.market_info.user_short_position_size - v7;
        };
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_reserve_amount<T0>(v4, false, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(&v5));
        0x2::balance::join<T0>(&mut v17, v14);
        return_to_user<T0>(v17, v6, arg6);
        let v18 = ManagerClearPositionEvent{
            user                : v6,
            collateral_token    : v1,
            base_token          : v2,
            position_id         : arg5,
            removed_size        : v7,
            cancelled_order_ids : v15,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerClearPositionEvent>(v18);
        let v19 = v15;
        if (0x1::vector::length<u64>(&v19) > 0) {
            cancel_linked_orders<T0, T1>(arg0, arg1, arg3, v19, v16, v6, arg6);
        };
    }

    public fun manager_reduce_position<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg9: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::user::TypusUserRegistry, arg10: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg11: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::competition::CompetitionConfig, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg14);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg6);
        assert!(v0.lp_token_type == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_lp_token_type(arg2, arg7), 4);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::safety_check(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_liquidity_pool(arg2, arg7), v2, 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg4));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg7, arg5);
        let v3 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg7);
        let (v4, v5) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg4, arg5);
        let (v6, v7) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg4, arg5);
        let v8 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert_profit_vault_allowed(&v0.id, v8, arg3);
        assert!(v8.market_config.oracle_id == 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg4), 7);
        let v9 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v8.user_positions, arg12);
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_type(v9) == 0x1::type_name::with_defining_ids<T0>(), 8);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_update_timestamp(v9, arg5, v8.market_config.cool_down_threshold_ts_ms);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::settle_socialization(v9, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::socialization_index(v3, 0x1::type_name::with_defining_ids<T0>()), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_socialization_index_scale());
        let (_, _, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::update_position_borrow_rate_and_funding_rate(v9, v4, v5, v6, v7, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(v3, 0x1::type_name::with_defining_ids<T0>()), v8.market_info.cumulative_funding_rate_index_sign, v8.market_info.cumulative_funding_rate_index);
        let v13 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_user(v9);
        let v14 = (((0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v9) as u128) * (arg13 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64) / v8.market_config.lot_size * v8.market_config.lot_size;
        let v15 = v8.market_info.next_order_id;
        let v16 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::manager_create_reduce_only_order<T0>(arg0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::create(v1, v0.quote_token_type), !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v9), v14, v8.market_info.size_decimal, v6, 0x2::balance::zero<T0>(), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_liquidity_token_decimal(arg2, arg7, 0x1::type_name::with_defining_ids<T0>()), arg12, v13, v8.market_info.next_order_id, v6, arg5, arg14);
        v8.market_info.next_order_id = v8.market_info.next_order_id + 1;
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::add_position_linked_order_info(v9, v15, v6);
        assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_order_filled(&v16, v6), 22);
        let (v17, v18, v19) = execute_order_<T0>(arg0, arg6, v8, v3, arg3, v16, v0.protocol_fee_share_bp, 0, v4, v5, v6, v7, arg8, arg9, arg10, arg11, arg5, arg14);
        let v20 = v18;
        return_to_user<T0>(v17, v13, arg14);
        if (0x1::vector::length<u64>(&v20) > 0) {
            cancel_linked_orders<T0, T1>(arg0, arg1, arg6, v20, v19, v13, arg14);
        };
        let v21 = ManagerReducePositionEvent{
            user                : v13,
            collateral_token    : v2,
            base_token          : v1,
            position_id         : arg12,
            reduced_size        : v14,
            collateral_price    : v4,
            trading_price       : v6,
            cancelled_order_ids : v20,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerReducePositionEvent>(v21);
    }

    public fun match_trading_order<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault::ProfitVault, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg10: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::user::TypusUserRegistry, arg11: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg12: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::competition::CompetitionConfig, arg13: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg14: u8, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        normal_safety_check<T0, T1>(arg0, arg1, arg2, arg4, arg7, arg8, 0x1::option::none<u64>(), false, arg17);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg17);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg7);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::update_borrow_info(arg0, arg2, arg8, arg6);
        let v4 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v2.symbol_markets, v3);
        assert_profit_vault_allowed(&v2.id, v4, arg3);
        let v5 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg8);
        let (v6, v7) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg4, arg6);
        let (v8, v9) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg4, arg6);
        let v10 = get_mut_orders(v4, arg14);
        let (_, v12) = 0x2::vec_map::remove<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v10, &arg15);
        let v13 = v12;
        let v14 = 0x1::vector::empty<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>();
        let v15 = 0;
        loop {
            let v16 = if (0x1::vector::length<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v13) > 0) {
                if (v0 < arg16) {
                    v15 < arg16
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                let v17 = 0x1::vector::pop_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v13);
                if (!price_guard_allows<T1>(v4, arg5, v8, arg6) && !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17)) {
                    v15 = v15 + 1;
                    0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
                    continue
                };
                let v18 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_expires_ts_ms(&v17);
                if (v18 > 0 && 0x2::clock::timestamp_ms(arg6) >= v18) {
                    v15 = v15 + 1;
                    if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token(&v17) == 0x1::type_name::with_defining_ids<T0>()) {
                        remove_expired_order_<T0>(arg0, arg7, v4, v17, v3, v18, arg17);
                        continue
                    };
                    0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
                    continue
                };
                let v19 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_side(&v17);
                let v20 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(&v17);
                let v21 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_id(&v17);
                let v22 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_user(&v17);
                let v23 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(&v17);
                let v24 = false;
                if (0x1::option::is_some<u64>(&v23)) {
                    let v25 = 0x1::option::extract<u64>(&mut v23);
                    if (!0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::contains<u64>(&v4.user_positions, v25)) {
                        v15 = v15 + 1;
                        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token(&v17) == 0x1::type_name::with_defining_ids<T0>()) {
                            let v26 = remove_linked_order_<T0>(arg0, arg7, v4, v17, v22);
                            return_to_user<T0>(v26, v22, arg17);
                            continue
                        };
                        0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
                        continue
                    };
                    let v27 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4.user_positions, v25);
                    v24 = v19 != 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v27);
                    if (!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_position_update_timestamp_(v27, arg6, v4.market_config.cool_down_threshold_ts_ms)) {
                        v15 = v15 + 1;
                        0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
                        continue
                    };
                    if (v19 == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v27) && 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17) || !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17) && v20 > 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v27)) {
                        v15 = v15 + 1;
                        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token(&v17) == 0x1::type_name::with_defining_ids<T0>()) {
                            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_position_linked_order_info(0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut v4.user_positions, v25), v21);
                            let v28 = remove_linked_order_<T0>(arg0, arg7, v4, v17, v22);
                            return_to_user<T0>(v28, v22, arg17);
                            continue
                        };
                        0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
                        continue
                    };
                };
                let v29 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::check_order_filled(&v17, v8);
                let v30 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token(&v17) == 0x1::type_name::with_defining_ids<T0>();
                let v31 = (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17) || v24) && false || v19 && v4.market_info.user_long_position_size + v20 > 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v4.market_config.u64_padding, 0) || v4.market_info.user_short_position_size + v20 > 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v4.market_config.u64_padding, 1);
                let v32 = if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::is_fee_discount_table_destination(arg0, 0x2::object::id<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable>(arg13))) {
                    0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::discount_bp_of(arg13, v22)
                } else {
                    0
                };
                let v33 = if (!v30 || !v29) {
                    true
                } else {
                    let v34 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(&v17);
                    let (v35, v36, v37, v38, v39) = if (0x1::option::is_some<u64>(&v34)) {
                        let v40 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4.user_positions, 0x1::option::extract<u64>(&mut v34));
                        let v41 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_side(v40) == v19;
                        let (v42, v43, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_unrealized_pnl(v40, v8, v9, 0);
                        let v45 = if (v42) {
                            0
                        } else {
                            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v43, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_decimal(v40), v6, v7)
                        };
                        let v46 = if (v41) {
                            v20
                        } else {
                            0x1::u64::min(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v40), v20)
                        };
                        (v46, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_size(v40), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_amount<T0>(v40), v41, v45)
                    } else {
                        (v20, 0, 0, true, 0)
                    };
                    let v47 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v5, 0x1::type_name::with_defining_ids<T0>());
                    let v48 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::discount_fee_rate(calculate_trading_fee_rate_mbp(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v4.market_config.u64_padding, 7), v4.market_info.user_long_position_size, v4.market_info.user_short_position_size, *0x1::vector::borrow<u64>(&v47, 1), v4.market_info.size_decimal, v8, v9, v19, v35, v4.market_config.trading_fee_config), v32);
                    let v49 = linked_position_debts<T0>(v4, v5, &v17, v6, v7, v8, v9);
                    let v50 = !0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17) && v38;
                    let (v51, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_trading_fee(v35, v4.market_info.size_decimal, v6, v7, v8, v9, v48, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token_decimal(&v17));
                    let v53 = if (!v50) {
                        true
                    } else {
                        let v54 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v5, 0x1::type_name::with_defining_ids<T0>());
                        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_idle_amount(v5, 0x1::type_name::with_defining_ids<T0>()) >= *0x1::vector::borrow<u64>(&v54, 2) + v51
                    };
                    let v55 = if (!v50) {
                        true
                    } else {
                        let v56 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v20, v4.market_info.size_decimal, v8, v9), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token_decimal(&v17), v6, v7);
                        let v57 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_amount<T0>(&v17) + v37;
                        let v58 = if (v56 > v57) {
                            v56 - v57
                        } else {
                            0
                        };
                        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::check_trading_order_size_valid(v5, 0x1::type_name::with_defining_ids<T0>(), v58)
                    };
                    let v59 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17) || v36 > 0 && !v38;
                    let v60 = if (!v59) {
                        true
                    } else {
                        let v61 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(&v17);
                        if (0x1::option::is_none<u64>(&v61)) {
                            true
                        } else {
                            let v62 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v4.user_positions, 0x1::option::extract<u64>(&mut v61));
                            let (v63, v64, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::calculate_unrealized_pnl(v62, v8, v9, 0);
                            let v66 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(scale_to_fill(v64, v35, v36), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_decimal(v62), v6, v7);
                            let v67 = if (v63) {
                                v66
                            } else {
                                0
                            };
                            let v68 = if (v63) {
                                0
                            } else {
                                v66
                            };
                            let v69 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_state(v5, 0x1::type_name::with_defining_ids<T0>());
                            (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool_idle_amount(v5, 0x1::type_name::with_defining_ids<T0>()) as u128) + (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_reserve_amount(v62) as u128) >= ((v67 + 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::funding_receivable_in_collateral(v62, v6, v7, v8, v9, v4.market_info.cumulative_funding_rate_index_sign, v4.market_info.cumulative_funding_rate_index)) as u128) + (*0x1::vector::borrow<u64>(&v69, 2) as u128) + (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::reserve_after_reduce(v62, v35, v68 + v51 + v49, v6, v7, v8, v9) as u128)
                        }
                    };
                    let v70 = if (!v50) {
                        true
                    } else {
                        let v71 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_amount<T0>(&v17) + v37;
                        let v72 = v51 + v49 + v39;
                        let v73 = if (v71 > v72) {
                            v71 - v72
                        } else {
                            0
                        };
                        let v74 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v73, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_collateral_token_decimal(&v17), v6, v7);
                        v74 > 0 && (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v36 + v20, v4.market_info.size_decimal, v8, v9) as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) <= (v4.market_config.max_leverage_mbp as u128) * (v74 as u128)
                    };
                    if (v53) {
                        if (v55) {
                            if (v60) {
                                if (v70) {
                                    v59 && check_collateral_enough_when_reducing_position<T0>(v4, &v17, v6, v7, v8, v9, v48, v49) || check_collateral_enough_when_adding_position<T0>(v4, &v17, v6, v7, v8, v9, v48, v49)
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
                    }
                };
                let v75 = if (v33) {
                    if (check_reserve_enough<T0>(v4, v5, &v17, v6, v7, v8, v9)) {
                        if (v30) {
                            if (v29) {
                                !v31
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
                if (v75) {
                    let v76 = if (!v2.is_active) {
                        true
                    } else if (!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::check_active(v5)) {
                        true
                    } else {
                        let v77 = 0x1::type_name::with_defining_ids<T0>();
                        if (!0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::token_pool_is_active(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_token_pool(v5, &v77))) {
                            true
                        } else {
                            !v4.market_info.is_active
                        }
                    };
                    let v78 = if (v76) {
                        let v79 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_reduce_only(&v17) || v24;
                        !v79
                    } else {
                        false
                    };
                    if (v78) {
                        v15 = v15 + 1;
                        0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
                        continue
                    };
                    adjust_market_info_user_order_size(v4, v19, true, v20);
                    let (v80, _, _) = execute_order_<T0>(arg0, arg7, v4, v5, arg3, v17, v2.protocol_fee_share_bp, v32, v6, v7, v8, v9, arg9, arg10, arg11, arg12, arg6, arg17);
                    return_to_user<T0>(v80, v22, arg17);
                    0x1::vector::push_back<u64>(&mut v1, v21);
                    v0 = v0 + 1;
                    continue
                };
                v15 = v15 + 1;
                0x1::vector::push_back<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v17);
            } else {
                break
            };
        };
        if (0x1::vector::length<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v13) > 0) {
            0x1::vector::append<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v14, v13);
        } else {
            0x1::vector::destroy_empty<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v13);
        };
        if (0x1::vector::length<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v14) > 0) {
            0x2::vec_map::insert<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(get_mut_orders(v4, arg14), arg15, v14);
        } else {
            0x1::vector::destroy_empty<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v14);
        };
        if (v0 > 0) {
            let v83 = MatchTradingOrderEvent{
                collateral_token  : 0x1::type_name::with_defining_ids<T0>(),
                base_token        : v3,
                matched_order_ids : v1,
                u64_padding       : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<MatchTradingOrderEvent>(v83);
        };
    }

    entry fun new_markets<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(arg2 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale(), 19);
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
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, v0.lp_token_type);
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, v0.quote_token_type);
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 0, v0.index, v1, 0x1::vector::empty<0x2::object::ID>(), v3, arg3);
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::push_back<u64, Markets>(&mut arg1.markets, arg1.num_market, v0);
        arg1.num_market = arg1.num_market + 1;
    }

    fun normal_safety_check<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: bool, arg8: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg4);
        if (arg7) {
            assert!(v0.is_active, 2);
        };
        assert!(v0.lp_token_type == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_lp_token_type(arg2, arg5), 4);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v2), 1);
        let v3 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v2);
        assert!(v3.market_config.oracle_id == 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3), 7);
        if (0x1::option::is_some<u64>(&arg6)) {
            let v4 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&v3.user_positions, 0x1::option::extract<u64>(&mut arg6));
            check_position_user_matched(v4, 0x2::tx_context::sender(arg8));
            assert!(v1 == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_position_collateral_token_type(v4), 8);
            if (arg7) {
                0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::check_token_pool_status<T0>(arg2, arg5, true);
            };
        };
        if (arg7) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::safety_check(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg5), v1, 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3));
        } else {
            assert!(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::oracle_matched(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_mut_liquidity_pool(arg2, arg5), v1, 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3)), 7);
        };
    }

    fun prepare_order_execution<T0>(arg0: &mut SymbolMarket, arg1: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg2: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder) : (address, 0x1::option::Option<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>, u64, u64) {
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_user(arg2);
        let (v1, v2) = get_linked_position(arg0, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(arg2), v0);
        (v0, v1, v2, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_cumulative_borrow_rate(arg1, 0x1::type_name::with_defining_ids<T0>()))
    }

    fun price_guard_allows<T0>(arg0: &SymbolMarket, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        if (!is_price_guard_bound(arg0)) {
            return false
        };
        assert_price_guard_matches<T0>(arg0, arg1);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::is_trading_allowed(arg1, arg2, 0x2::clock::timestamp_ms(arg3))
    }

    fun record_twap_observation(arg0: &mut SymbolMarket, arg1: u64, arg2: u64) {
        let v0 = 0x1::string::utf8(b"twap_buffer");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::TwapBuffer>(&mut arg0.id, v0);
        let v2 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::length(v1);
        if (v2 > 0) {
            let (_, v4) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::observation_at(v1, v2 - 1);
            if (arg2 < v4 + 30000) {
                return
            };
        };
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::record(v1, arg1, arg2);
    }

    entry fun refresh_market_price<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::PriceGuard, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_config.oracle_id == 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg4), 7);
        assert_price_guard_bound<T0>(v2, arg3);
        let (v3, _) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg4, arg5);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard::update<T0>(arg0, arg3, arg4, arg5);
        record_twap_observation(v2, v3, 0x2::clock::timestamp_ms(arg5));
    }

    fun remove_expired_order_<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_user(&arg3);
        let v1 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_id(&arg3);
        adjust_market_info_user_order_size(arg2, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_side(&arg3), true, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(&arg3));
        let v2 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_linked_position_id(&arg3);
        if (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::option::extract<u64>(&mut v2);
            if (0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::contains<u64>(&arg2.user_positions, v3)) {
                0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_position_linked_order_info(0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::borrow_by_key_mut<u64, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::Position>(&mut arg2.user_positions, v3), v1);
            };
        };
        let v4 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_order<T0>(arg0, arg3);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, arg5);
        let v6 = CancelTradingOrderEvent{
            user                       : v0,
            market_index               : arg1,
            order_id                   : v1,
            trigger_price              : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_price(&arg3),
            collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
            base_token                 : arg4,
            released_collateral_amount : 0x2::balance::value<T0>(&v4),
            u64_padding                : v5,
        };
        0x2::event::emit<CancelTradingOrderEvent>(v6);
        return_to_user<T0>(v4, v0, arg6);
    }

    fun remove_linked_order_<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder, arg4: address) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_trading_symbol(&arg3);
        adjust_market_info_user_order_size(arg2, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_side(&arg3), true, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_size(&arg3));
        let v2 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::remove_order<T0>(arg0, arg3);
        let v3 = CancelTradingOrderEvent{
            user                       : arg4,
            market_index               : arg1,
            order_id                   : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_id(&arg3),
            trigger_price              : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_price(&arg3),
            collateral_token           : 0x1::type_name::with_defining_ids<T0>(),
            base_token                 : v0,
            released_collateral_amount : 0x2::balance::value<T0>(&v2),
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CancelTradingOrderEvent>(v3);
        v2
    }

    fun remove_linked_orders<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u64, arg2: &mut SymbolMarket, arg3: vector<u64>, arg4: vector<u64>, arg5: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (0x1::vector::length<u64>(&arg3) > 0) {
            let v1 = take_order_by_order_id_and_price(arg2, 0x1::vector::pop_back<u64>(&mut arg4), 0x1::vector::pop_back<u64>(&mut arg3), arg5);
            if (0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v1)) {
                0x2::balance::join<T0>(&mut v0, remove_linked_order_<T0>(arg0, arg1, arg2, 0x1::option::extract<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v1), arg5));
            };
            0x1::option::destroy_none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v1);
        };
        v0
    }

    entry fun remove_trading_symbol<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::remove<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(!v2.market_info.is_active, 4);
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
        assert!(v3, 26);
        let v4 = 0x1::string::utf8(b"twap_buffer");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v2.id, v4)) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::consume(0x2::dynamic_field::remove<0x1::string::String, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::TwapBuffer>(&mut v2.id, v4));
        };
        let v5 = 0x1::string::utf8(b"price_guard_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v2.id, v5)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x2::object::ID>(&mut v2.id, v5);
        };
        0x2::vec_map::destroy_empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"limit_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"limit_sell_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"stop_buy_orders")));
        0x2::vec_map::destroy_empty<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_map::VecMap<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>>(&mut v2.token_collateral_orders, 0x1::string::utf8(b"stop_sell_orders")));
        let SymbolMarket {
            id                      : v6,
            user_positions          : v7,
            token_collateral_orders : v8,
            market_info             : _,
            market_config           : _,
        } = v2;
        0x2::object::delete(v6);
        0x2::object::delete(v8);
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::keyed_big_vector::destroy_empty(v7);
        let (_, v12) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.symbols, &v1);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut v0.symbols, v12);
    }

    entry fun resume_market(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2).is_active = true;
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 5, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    entry fun resume_trading_symbol<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        assert!(v0.is_active, 2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1).market_info.is_active = true;
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 7, arg2, v2, 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    fun return_to_user<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    fun scale_to_fill(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    entry fun set_default_order_ttl_ms<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        assert!(arg3 == 0 || arg3 >= 60000 && arg3 <= 31536000000, 1801);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 11, arg3);
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v1);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v2.market_config.u64_padding, 11));
        0x1::vector::push_back<u64>(v5, arg3);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 10, arg2, v3, 0x1::vector::empty<0x2::object::ID>(), v4, arg4);
    }

    entry fun suspend_market(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2).is_active = false;
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 4, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    entry fun suspend_trading_symbol<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        assert!(v0.is_active, 2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1).market_info.is_active = false;
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 6, arg2, v2, 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    fun take_order_by_order_id_and_price(arg0: &mut SymbolMarket, arg1: u64, arg2: u64, arg3: address) : 0x1::option::Option<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder> {
        let v0 = 0x1::option::none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>();
        let v1 = 0;
        while (v1 <= 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_max_order_type_tag()) {
            let v2 = get_mut_orders(arg0, v1);
            if (0x2::vec_map::contains<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v2, &arg1)) {
                let (_, v4) = 0x2::vec_map::remove<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v2, &arg1);
                let v5 = v4;
                let v6 = 0;
                while (v6 < 0x1::vector::length<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v5)) {
                    let v7 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_id(0x1::vector::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v5, v6));
                    let v8 = if (&v7 == &arg2) {
                        let v9 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::get_order_user(0x1::vector::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v5, v6));
                        &v9 == &arg3
                    } else {
                        false
                    };
                    if (v8) {
                        0x1::option::fill<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v0, 0x1::vector::remove<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&mut v5, v6));
                        break
                    };
                    v6 = v6 + 1;
                };
                if (0x1::vector::length<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v5) == 0) {
                    0x1::vector::destroy_empty<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(v5);
                } else {
                    0x2::vec_map::insert<u64, vector<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>>(v2, arg1, v5);
                };
                if (0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position::TradingOrder>(&v0)) {
                    break
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun twap_gate_price(arg0: &SymbolMarket, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::string::utf8(b"twap_buffer");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return arg1
        };
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::TwapBuffer>(&arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (!0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::is_usable(v1, v2, 1800000)) {
            return arg1
        };
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap::calculate_mark_price(v1, arg1, v2)
    }

    public fun update_funding_rate<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::Registry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg7);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg5);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        assert!(v0.lp_token_type == 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_lp_token_type(arg2, arg6), 4);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        assert!(v2.market_config.oracle_id == 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3), 7);
        let (v3, v4) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg4);
        let v5 = v2.market_info.last_funding_ts_ms;
        let v6 = 0x2::clock::timestamp_ms(arg4) / v2.market_config.funding_interval_ts_ms * v2.market_config.funding_interval_ts_ms;
        if (v6 > v5) {
            let v7 = (v6 - v5) / v2.market_config.funding_interval_ts_ms;
            let v8 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_tvl_usd(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_liquidity_pool(arg2, arg6));
            let v9 = if (v2.market_info.user_long_position_size > v2.market_info.user_short_position_size) {
                v2.market_info.user_long_position_size - v2.market_info.user_short_position_size
            } else {
                v2.market_info.user_short_position_size - v2.market_info.user_long_position_size
            };
            let v10 = if (v8 > 0) {
                (((v2.market_config.basic_funding_rate as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v9, v2.market_info.size_decimal, v3, v4) as u128) / (v8 as u128)) as u64)
            } else {
                0
            };
            let v11 = 14400000 / v2.market_config.funding_interval_ts_ms;
            let v12 = if (v11 == 0) {
                1
            } else {
                v11
            };
            let v13 = if (v7 > v12) {
                v12
            } else {
                v7
            };
            let v14 = v10 * v13;
            v2.market_info.previous_last_funding_ts_ms = v2.market_info.last_funding_ts_ms;
            v2.market_info.previous_cumulative_funding_rate_index_sign = v2.market_info.cumulative_funding_rate_index_sign;
            v2.market_info.previous_cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index;
            v2.market_info.last_funding_ts_ms = v6;
            if (v2.market_info.user_long_position_size > v2.market_info.user_short_position_size) {
                if (v2.market_info.cumulative_funding_rate_index_sign) {
                    v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index + v14;
                } else if (v2.market_info.cumulative_funding_rate_index > v14) {
                    v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index - v14;
                } else {
                    v2.market_info.cumulative_funding_rate_index = v14 - v2.market_info.cumulative_funding_rate_index;
                    v2.market_info.cumulative_funding_rate_index_sign = true;
                };
            } else if (v2.market_info.cumulative_funding_rate_index_sign) {
                if (v2.market_info.cumulative_funding_rate_index >= v14) {
                    v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index - v14;
                } else {
                    v2.market_info.cumulative_funding_rate_index = v14 - v2.market_info.cumulative_funding_rate_index;
                    v2.market_info.cumulative_funding_rate_index_sign = false;
                };
            } else {
                v2.market_info.cumulative_funding_rate_index = v2.market_info.cumulative_funding_rate_index + v14;
            };
            let v15 = UpdateFundingRateEvent{
                base_token                                  : v1,
                new_funding_ts_ms                           : v6,
                intervals_count                             : v7,
                previous_cumulative_funding_rate_index_sign : v2.market_info.cumulative_funding_rate_index_sign,
                previous_cumulative_funding_rate_index      : v2.market_info.cumulative_funding_rate_index,
                cumulative_funding_rate_index_sign          : v2.market_info.cumulative_funding_rate_index_sign,
                cumulative_funding_rate_index               : v2.market_info.cumulative_funding_rate_index,
                u64_padding                                 : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<UpdateFundingRateEvent>(v15);
        };
    }

    entry fun update_market_config<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg17);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.symbols, &v1), 1);
        let v2 = 0x2::object_table::borrow_mut<0x1::type_name::TypeName, SymbolMarket>(&mut v0.symbol_markets, v1);
        if (0x1::option::is_some<address>(&arg3)) {
            v2.market_config.oracle_id = 0x1::option::extract<address>(&mut arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v2.market_config.max_leverage_mbp = 0x1::option::extract<u64>(&mut arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v2.market_config.min_size = 0x1::option::extract<u64>(&mut arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v2.market_config.lot_size = 0x1::option::extract<u64>(&mut arg6);
        };
        if (0x1::option::is_some<vector<u64>>(&arg7)) {
            v2.market_config.trading_fee_config = 0x1::option::extract<vector<u64>>(&mut arg7);
            validate_trading_fee_config(&v2.market_config.trading_fee_config);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            v2.market_config.basic_funding_rate = 0x1::option::extract<u64>(&mut arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            v2.market_config.funding_interval_ts_ms = 0x1::option::extract<u64>(&mut arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            v2.market_config.exp_multiplier = 0x1::option::extract<u64>(&mut arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            v2.market_config.cool_down_threshold_ts_ms = 0x1::option::extract<u64>(&mut arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 0, 0x1::option::extract<u64>(&mut arg12));
        };
        if (0x1::option::is_some<u64>(&arg13)) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 1, 0x1::option::extract<u64>(&mut arg13));
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 2, 0x1::option::extract<u64>(&mut arg14));
        };
        if (0x1::option::is_some<u64>(&arg15)) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 7, 0x1::option::extract<u64>(&mut arg15));
        };
        if (0x1::option::is_some<u64>(&arg16)) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.market_config.u64_padding, 8, 0x1::option::extract<u64>(&mut arg16));
        };
        assert_market_parameters_sane(v2.market_config.max_leverage_mbp, v2.market_config.lot_size, v2.market_config.funding_interval_ts_ms, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v2.market_config.u64_padding, 2), v2.market_config.cool_down_threshold_ts_ms);
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 3, arg2, v3, 0x1::vector::empty<0x2::object::ID>(), vector[], arg17);
    }

    entry fun update_protocol_fee_share_bp(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut MarketRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        assert!(arg3 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale(), 19);
        let v0 = 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::linked_object_table::borrow_mut<u64, Markets>(&mut arg1.markets, arg2);
        v0.protocol_fee_share_bp = arg3;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.protocol_fee_share_bp);
        0x1::vector::push_back<u64>(v2, v0.protocol_fee_share_bp);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(1, 2, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), v1, arg4);
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
        assert!(v0, 25);
    }

    // decompiled from Move bytecode v7
}

