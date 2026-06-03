module 0xace3c08864acdbc7163de6f72347213ac2fe03044a8c2c4cc3bbeb80e2cf5cdb::view {
    struct AccountData has copy, drop {
        account_id: 0x2::object::ID,
        account_object_address: address,
    }

    struct MarketData has copy, drop {
        market_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        lp_token: 0x1::type_name::TypeName,
        is_paused: bool,
        long_oi: u128,
        short_oi: u128,
        long_avg_entry_price: u128,
        short_avg_entry_price: u128,
        max_long_oi: u128,
        max_short_oi: u128,
        max_leverage_bps: u64,
        trading_fee: u128,
        max_impact_fee: u128,
        allocated_lp_exposure_bps: u64,
        impact_fee_curvature: u64,
        impact_fee_scale: u64,
        maintenance_margin: u128,
        min_coll_value: u64,
        cooldown_ms: u64,
        basic_funding_rate: u128,
        funding_interval_ms: u64,
        order_price_tick: u128,
        cumulative_funding_sign: bool,
        cumulative_funding_index: u256,
        last_funding_timestamp: u64,
        next_position_id: u64,
        next_order_id: u64,
    }

    struct PoolData has copy, drop {
        lp_token: 0x1::type_name::TypeName,
        is_active: bool,
        lp_decimal: u8,
        total_lp_supply: u64,
        tvl_usd: u128,
        token_count: u64,
    }

    struct TokenPoolData has copy, drop {
        token_type: 0x1::type_name::TypeName,
        token_decimal: u8,
        liquidity_amount: u64,
        reserved_amount: u64,
        value_usd: u128,
        target_weight_bps: u64,
        mint_fee_bps: u64,
        burn_fee_bps: u64,
        cumulative_borrow_rate: u128,
        last_price_refresh_timestamp: u64,
    }

    struct RedeemRequestData has copy, drop {
        request_id: u64,
        recipient_account_id: 0x2::object::ID,
        lp_amount: u64,
        token_type: 0x1::type_name::TypeName,
        request_timestamp: u64,
    }

    struct GlobalConfigData has copy, drop {
        allowed_versions: vector<u16>,
        keeper_addresses: vector<address>,
        redeem_operator_addresses: vector<address>,
        protocol_fee_share_bps: u64,
        liquidator_fee_bps: u64,
        insurance_fee_bps: u64,
        max_skipped_orders_per_match: u64,
        oi_cap_bps: u64,
        price_refresh_threshold_ms: u64,
    }

    struct PositionData has copy, drop {
        position_id: u64,
        account_object_address: address,
        market_id: 0x2::object::ID,
        is_long: bool,
        size: u128,
        collateral_type: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_decimal: u8,
        average_price: u128,
        oracle_price: u128,
        collateral_price: u128,
        est_liq_price: u128,
        leverage_bps: u64,
        entry_borrow_index: u128,
        entry_funding_sign: bool,
        entry_funding_index: u256,
        unrealized_trading_fee: u64,
        unrealized_borrow_fee: u64,
        unrealized_funding_fee: u64,
        unrealized_funding_sign: bool,
        pnl_positive: bool,
        pnl: u64,
        funding_fee_positive: bool,
        funding_fee: u64,
        borrow_fee: u64,
        close_fee: u64,
        linked_order_ids: vector<u64>,
        linked_order_price_keys: vector<u128>,
        create_timestamp: u64,
        update_timestamp: u64,
    }

    struct OrderData has copy, drop {
        order_id: u64,
        account_object_address: address,
        market_id: 0x2::object::ID,
        is_long: bool,
        reduce_only: bool,
        is_stop_order: bool,
        size: u128,
        collateral_type: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_decimal: u8,
        trigger_price: u128,
        oracle_price: u128,
        order_type_tag: u8,
        has_linked_position: bool,
        linked_position_id: u64,
        leverage_bps: u64,
        create_timestamp: u64,
    }

    public fun account_data(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<AccountData> {
        if (!0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<AccountData>()
        };
        let v0 = AccountData{
            account_id             : arg1,
            account_object_address : 0x2::object::id_to_address(&arg1),
        };
        0x1::option::some<AccountData>(v0)
    }

    fun build_order_data(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::Order, arg1: u128) : OrderData {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_linked_position_id(arg0);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            *0x1::option::borrow<u64>(&v0)
        } else {
            0
        };
        OrderData{
            order_id               : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::get_order_id(arg0),
            account_object_address : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_account_object_address(arg0),
            market_id              : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_market_id(arg0),
            is_long                : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_is_long(arg0),
            reduce_only            : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_reduce_only(arg0),
            is_stop_order          : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_is_stop_order(arg0),
            size                   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_size(arg0)),
            collateral_type        : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_collateral_token(arg0),
            collateral_amount      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_collateral_amount(arg0),
            collateral_decimal     : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_collateral_decimal(arg0),
            trigger_price          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_trigger_price(arg0)),
            oracle_price           : arg1,
            order_type_tag         : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_type_tag(arg0),
            has_linked_position    : 0x1::option::is_some<u64>(&v0),
            linked_position_id     : v1,
            leverage_bps           : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_leverage_bps(arg0),
            create_timestamp       : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_create_timestamp(arg0),
        }
    }

    fun calculate_est_liq_price(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: u64, arg5: bool, arg6: u64, arg7: u64) : u128 {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_size(arg0), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_average_price(arg0));
        let v1 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_amount(arg0), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), arg2);
        let v2 = if (arg5) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg4 + arg7, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), arg2), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg6, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), arg2))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg4 + arg7, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), arg2), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg6, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), arg2))
        };
        let v3 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg3, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_size(arg0), arg1)));
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lte(v1, v3) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return 0
        };
        let v4 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v1, v3), v0);
        if (0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_is_long(arg0)) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one())) {
                return 0
            };
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_average_price(arg0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one(), v4)))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_average_price(arg0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one(), v4)))
        }
    }

    public fun get_account_orders<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: u64, arg3: address) : vector<OrderData> {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<OrderData>();
        let v2 = 0;
        while (v2 < 4) {
            let v3 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_order_book<T0>(v0, v2);
            let v4 = 0;
            while (v4 < 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::level_count(v3)) {
                let (_, v6) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::borrow_level_by_index(v3, v4);
                let v7 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::level_front_order_id(v6);
                while (0x1::option::is_some<u64>(&v7)) {
                    let v8 = 0x1::option::destroy_some<u64>(v7);
                    let v9 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::borrow_level_order(v6, v8);
                    if (0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::order_account_object_address(v9) == arg3) {
                        0x1::vector::push_back<OrderData>(&mut v1, build_order_data(v9, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg2))));
                    };
                    v7 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::level_next_order_id(v6, v8);
                };
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_account_positions<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>, arg3: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg4: u64, arg5: u64, arg6: address) : vector<PositionData> {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        let v1 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::account_positions(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::borrow_account(arg3, 0x2::object::id_from_address(arg6)));
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::market_id<T0>(v0);
        let v3 = 0x1::vector::empty<PositionData>();
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(v1, &v2)) {
            return v3
        };
        let v4 = 0x2::vec_map::get<0x2::object::ID, vector<u64>>(v1, &v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            let v6 = *0x1::vector::borrow<u64>(v4, v5);
            if (0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::has_position<T0>(v0, v6)) {
                0x1::vector::push_back<PositionData>(&mut v3, position_data<T0>(arg0, arg1, arg2, arg4, arg5, v6));
            };
            v5 = v5 + 1;
        };
        v3
    }

    public fun get_market_orders<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) : (vector<OrderData>, 0x1::option::Option<u64>) {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<OrderData>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::option::none<u64>();
        let v5 = 0;
        while (v5 < 4) {
            let v6 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_order_book<T0>(v0, v5);
            let v7 = 0;
            while (v7 < 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::level_count(v6)) {
                let (_, v9) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::borrow_level_by_index(v6, v7);
                let v10 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::level_front_order_id(v9);
                while (0x1::option::is_some<u64>(&v10)) {
                    let v11 = 0x1::option::destroy_some<u64>(v10);
                    let v12 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::borrow_level_order(v9, v11);
                    if (v2 >= arg3) {
                        if (v3 < arg4) {
                            0x1::vector::push_back<OrderData>(&mut v1, build_order_data(v12, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg2))));
                            v3 = v3 + 1;
                        } else if (0x1::option::is_none<u64>(&v4)) {
                            v4 = 0x1::option::some<u64>(v2);
                        };
                    };
                    v2 = v2 + 1;
                    v10 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::order_book::level_next_order_id(v9, v11);
                };
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
        (v1, v4)
    }

    public fun get_market_positions<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (vector<PositionData>, 0x1::option::Option<u64>) {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        let v1 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_positions<T0>(v0);
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_config<T0>(v0);
        let v3 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::length(v1);
        let v4 = 0x1::vector::empty<PositionData>();
        if (arg5 >= v3) {
            return (v4, 0x1::option::none<u64>())
        };
        let v5 = 0x1::u64::min(v3, arg5 + arg6);
        while (arg5 < v5) {
            let (_, v7) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow<u64, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::Position>(v1, arg5);
            0x1::vector::push_back<PositionData>(&mut v4, position_data_internal<T0>(v7, v2, arg2, arg3, arg4));
            arg5 = arg5 + 1;
        };
        let v8 = if (v5 < v3) {
            0x1::option::some<u64>(v5)
        } else {
            0x1::option::none<u64>()
        };
        (v4, v8)
    }

    public fun get_redeem_requests<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>, arg1: u64, arg2: u64) : (vector<RedeemRequestData>, 0x1::option::Option<u64>) {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::borrow_redeem_requests<T0>(arg0);
        let v1 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::length(v0);
        let v2 = 0x1::vector::empty<RedeemRequestData>();
        if (arg1 >= v1) {
            return (v2, 0x1::option::none<u64>())
        };
        let v3 = 0x1::u64::min(arg1 + arg2, v1);
        while (arg1 < v3) {
            let (v4, v5) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow<u64, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::RedeemRequest<T0>>(v0, arg1);
            let v6 = RedeemRequestData{
                request_id           : v4,
                recipient_account_id : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::redeem_recipient_account_id<T0>(v5),
                lp_amount            : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::redeem_lp_amount<T0>(v5),
                token_type           : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::redeem_token_type<T0>(v5),
                request_timestamp    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::redeem_request_timestamp<T0>(v5),
            };
            0x1::vector::push_back<RedeemRequestData>(&mut v2, v6);
            arg1 = arg1 + 1;
        };
        let v7 = if (v3 < v1) {
            0x1::option::some<u64>(v3)
        } else {
            0x1::option::none<u64>()
        };
        (v2, v7)
    }

    public fun global_config_data(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig) : GlobalConfigData {
        GlobalConfigData{
            allowed_versions             : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::allowed_versions(arg0),
            keeper_addresses             : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::keeper_addresses(arg0),
            redeem_operator_addresses    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::redeem_operator_addresses(arg0),
            protocol_fee_share_bps       : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::protocol_fee_share_bps(arg0),
            liquidator_fee_bps           : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::liquidator_fee_bps(arg0),
            insurance_fee_bps            : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::insurance_fee_bps(arg0),
            max_skipped_orders_per_match : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::max_skipped_orders_per_match(arg0),
            oi_cap_bps                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::oi_cap_bps(arg0),
            price_refresh_threshold_ms   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::price_refresh_threshold_ms(arg0),
        }
    }

    public fun market_data<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String) : MarketData {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        let v1 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_config<T0>(v0);
        MarketData{
            market_id                 : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::market_id<T0>(v0),
            symbol                    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::market_symbol<T0>(v0),
            lp_token                  : 0x1::type_name::with_defining_ids<T0>(),
            is_paused                 : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_is_paused(v1),
            long_oi                   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_long_oi(v1)),
            short_oi                  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_short_oi(v1)),
            long_avg_entry_price      : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_long_avg_entry_price(v1)),
            short_avg_entry_price     : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_short_avg_entry_price(v1)),
            max_long_oi               : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_max_long_oi(v1)),
            max_short_oi              : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_max_short_oi(v1)),
            max_leverage_bps          : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_max_leverage_bps(v1),
            trading_fee               : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_trading_fee(v1)),
            max_impact_fee            : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_max_impact_fee(v1)),
            allocated_lp_exposure_bps : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_allocated_lp_exposure_bps(v1),
            impact_fee_curvature      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_impact_fee_curvature(v1),
            impact_fee_scale          : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_impact_fee_scale(v1),
            maintenance_margin        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_maintenance_margin(v1)),
            min_coll_value            : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_min_coll_value(v1),
            cooldown_ms               : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_cooldown_ms(v1),
            basic_funding_rate        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_basic_funding_rate(v1)),
            funding_interval_ms       : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_funding_interval_ms(v1),
            order_price_tick          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_order_price_tick(v1)),
            cumulative_funding_sign   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_cumulative_funding_sign(v1),
            cumulative_funding_index  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_cumulative_funding_index(v1)),
            last_funding_timestamp    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_last_funding_timestamp(v1),
            next_position_id          : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_next_position_id(v1),
            next_order_id             : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_next_order_id(v1),
        }
    }

    public fun order_data<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: u128, arg5: u64) : OrderData {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        build_order_data(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_order<T0>(v0, arg3, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::normalize_trigger_price(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg4), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_order_price_tick(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_config<T0>(v0))), arg5), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg2)))
    }

    public fun pool_data<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>) : PoolData {
        PoolData{
            lp_token        : 0x1::type_name::with_defining_ids<T0>(),
            is_active       : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::is_active<T0>(arg0),
            lp_decimal      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::lp_decimal<T0>(arg0),
            total_lp_supply : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::total_lp_supply<T0>(arg0),
            tvl_usd         : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::pool_tvl_usd<T0>(arg0)),
            token_count     : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::token_count<T0>(arg0),
        }
    }

    public fun position_data<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>, arg3: u64, arg4: u64, arg5: u64) : PositionData {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1);
        position_data_internal<T0>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_position<T0>(v0, arg5), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_config<T0>(v0), arg2, arg3, arg4)
    }

    fun position_data_internal<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::Position, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::MarketConfig, arg2: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>, arg3: u64, arg4: u64) : PositionData {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg3);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg4);
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::calculate_borrow_fee(arg0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::cumulative_borrow_rate<T0>(arg2, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_token(arg0))) + 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_borrow_fee(arg0);
        let (v3, v4) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::calculate_funding_fee(arg0, v1, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_cumulative_funding_sign(arg1), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_cumulative_funding_index(arg1));
        let (v5, v6) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::unrealized_pnl(arg0, v0);
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_size(arg0), v0);
        let v8 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::calculate_effective_collateral_amount(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_amount(arg0), v2, v3, v4, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_trading_fee(arg0), 0), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), v1);
        let v9 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v8, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(v7, v8), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale()))
        };
        PositionData{
            position_id             : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::get_position_id(arg0),
            account_object_address  : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_account_object_address(arg0),
            market_id               : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_market_id(arg0),
            is_long                 : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_is_long(arg0),
            size                    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_size(arg0)),
            collateral_type         : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_token(arg0),
            collateral_amount       : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_amount(arg0),
            collateral_decimal      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0),
            average_price           : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_average_price(arg0)),
            oracle_price            : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v0),
            collateral_price        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v1),
            est_liq_price           : calculate_est_liq_price(arg0, v0, v1, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config::market_config_maintenance_margin(arg1), v2, v3, v4, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_trading_fee(arg0)),
            leverage_bps            : v9,
            entry_borrow_index      : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_entry_borrow_index(arg0)),
            entry_funding_sign      : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_entry_funding_sign(arg0),
            entry_funding_index     : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_entry_funding_index(arg0)),
            unrealized_trading_fee  : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_trading_fee(arg0),
            unrealized_borrow_fee   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_borrow_fee(arg0),
            unrealized_funding_fee  : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_funding_fee(arg0),
            unrealized_funding_sign : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_unrealized_funding_sign(arg0),
            pnl_positive            : v5,
            pnl                     : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::usd_to_amount(v6, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), v1),
            funding_fee_positive    : v3,
            funding_fee             : v4,
            borrow_fee              : v2,
            close_fee               : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::usd_to_amount(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::calculate_total_trading_fee<T0>(arg1, arg2, v0, !0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_is_long(arg0), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_size(arg0)), v7), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_collateral_decimal(arg0), v1),
            linked_order_ids        : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_linked_order_ids(arg0),
            linked_order_price_keys : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_linked_order_price_keys(arg0),
            create_timestamp        : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_create_timestamp(arg0),
            update_timestamp        : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position::position_update_timestamp(arg0),
        }
    }

    public fun position_exists<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::MarketRegistry<T0>, arg1: 0x1::string::String, arg2: u64) : bool {
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::has_position<T0>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::trading::borrow_market<T0>(arg0, arg1), arg2)
    }

    public fun token_pool_data<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>, arg1: u64) : TokenPoolData {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::borrow_token_pool_by_index<T0>(arg0, arg1);
        TokenPoolData{
            token_type                   : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_token_type(v0),
            token_decimal                : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_token_decimal(v0),
            liquidity_amount             : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_liquidity_amount(v0),
            reserved_amount              : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_reserved_amount(v0),
            value_usd                    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_value_usd(v0)),
            target_weight_bps            : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_target_weight_bps(v0),
            mint_fee_bps                 : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_mint_fee_bps(v0),
            burn_fee_bps                 : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_burn_fee_bps(v0),
            cumulative_borrow_rate       : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_cumulative_borrow_rate(v0)),
            last_price_refresh_timestamp : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::tpi_last_price_refresh_timestamp(v0),
        }
    }

    public fun token_pools_data<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<T0>) : vector<TokenPoolData> {
        let v0 = 0x1::vector::empty<TokenPoolData>();
        let v1 = 0;
        while (v1 < 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::token_count<T0>(arg0)) {
            0x1::vector::push_back<TokenPoolData>(&mut v0, token_pool_data<T0>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

