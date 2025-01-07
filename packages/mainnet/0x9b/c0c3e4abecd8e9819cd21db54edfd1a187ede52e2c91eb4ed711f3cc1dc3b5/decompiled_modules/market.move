module 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market {
    struct MarketLP<phantom T0: drop> has drop {
        dummy_field: bool,
    }

    struct MarketConfig<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        expiry: u64,
        scalar_root: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        market_cap: u64,
    }

    struct MarketState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        total_pt: 0x2::balance::Balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>,
        total_sy: 0x2::balance::Balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>,
        total_lp: 0x2::balance::Supply<MarketLP<T0>>,
        last_ln_implied_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        current_exchange_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    struct AddLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        exchange_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    struct RemoveLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
    }

    struct SwapEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
        sy_amount: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
        fee: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
        reserve_fee: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
        exchange_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    public fun burn_lp<T0: drop>(arg0: address, arg1: address, arg2: &MarketConfig<T0>, arg3: 0x2::coin::Coin<MarketLP<T0>>, arg4: &mut MarketState<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<MarketLP<T0>>(arg3);
        let v1 = 0x2::balance::value<MarketLP<T0>>(&v0);
        let v2 = v1 * 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg4.total_sy) / 0x2::balance::supply_value<MarketLP<T0>>(&arg4.total_lp);
        let v3 = v1 * 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg4.total_pt) / 0x2::balance::supply_value<MarketLP<T0>>(&arg4.total_lp);
        assert!(v2 > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_sy_amount_is_zero());
        assert!(v3 > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_pt_amount_is_zero());
        0x2::balance::decrease_supply<MarketLP<T0>>(&mut arg4.total_lp, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>>(0x2::coin::take<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut arg4.total_pt, v3, arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>>(0x2::coin::take<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg4.total_sy, v2, arg5), arg0);
        let v4 = RemoveLiquidityEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg4),
            expiry          : arg2.expiry,
            pt_amount       : v3,
            sy_amount       : v2,
            lp_amount       : v1,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0>>(v4);
    }

    public(friend) fun create<T0: drop>(arg0: u64, arg1: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketConfig<T0>{
            id               : 0x2::object::new(arg5),
            name             : b"Nemo Market",
            symbol           : b"Nemo-LP",
            decimals         : 9,
            expiry           : arg0,
            scalar_root      : arg1,
            initial_anchor   : arg2,
            ln_fee_rate_root : arg3,
            market_cap       : arg4,
        };
        let v1 = MarketLP<T0>{dummy_field: false};
        let v2 = MarketState<T0>{
            id                    : 0x2::object::new(arg5),
            total_pt              : 0x2::balance::zero<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(),
            total_sy              : 0x2::balance::zero<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(),
            total_lp              : 0x2::balance::create_supply<MarketLP<T0>>(v1),
            last_ln_implied_rate  : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            current_exchange_rate : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::zero(),
        };
        0x2::transfer::share_object<MarketConfig<T0>>(v0);
        0x2::transfer::share_object<MarketState<T0>>(v2);
    }

    fun execute_trade_core<T0: drop>(arg0: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign) {
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::less(arg0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg6.total_pt))), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_insufficient_pt_for_swap());
        let v0 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::current_py_index<T0>(arg2, arg4, arg3, arg8);
        let v1 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(v0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg6.total_sy)));
        let v2 = arg5.expiry - 0x2::clock::timestamp_ms(arg7);
        let v3 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_rate_scalar(arg5.scalar_root, v2);
        let v4 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_rate_anchor(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg6.total_pt)), arg6.last_ln_implied_rate, v1, v3, v2);
        let v5 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_exchange_rate_from_implied_rate(arg5.ln_fee_rate_root, v2);
        let v6 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_exchange_rate(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v1), true), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg6.total_pt)), v3, v4, arg0);
        let v7 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(arg0, v6));
        let v8 = if (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::is_positive(arg0)) {
            assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::greater_or_equal(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(v6, v5), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::one()), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_exchange_rate_below_one());
            0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::mul(v7, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::sub(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::one(), v5))
        } else {
            0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::mul(v7, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::sub(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::one(), v5)), v5))
        };
        let v9 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::sub(v7, v8);
        let v10 = if (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::less(v9, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::zero())) {
            0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::sub(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::add(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::abs(v9), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v0), true)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(1, true)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v0), true)))
        } else {
            0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(v9, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v0), true))
        };
        (v10, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::mul(v8, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::get_reserve_fee_percent(arg1)), true)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v0), true)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::div(v8, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v0), true)), v3, v4)
    }

    fun get_exchange_rate<T0: drop>(arg0: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg3: &MarketConfig<T0>, arg4: &MarketState<T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: &0x2::tx_context::TxContext) : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::current_py_index<T0>(arg0, arg2, arg1, arg7), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg4.total_sy)));
        let v1 = arg3.expiry - 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_rate_scalar(arg3.scalar_root, v1);
        let v3 = arg3.initial_anchor;
        if (!arg6) {
            v3 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_rate_anchor(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg4.total_pt)), arg4.last_ln_implied_rate, v0, v2, v1);
        };
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_math::get_exchange_rate(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::create_from_raw_value(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::get_raw_value(v0), true), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg4.total_pt)), v2, v3, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::zero())
    }

    fun get_ln_implied_rate(arg0: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64 {
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64::mul_div(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::remove_sign(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math_fixed64_with_sign::ln(arg0)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(31536000000), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(arg1))
    }

    public fun get_sy_amount_in_for_exact_pt_out<T0: drop>(arg0: u64, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, _, _, _) = execute_trade_core<T0>(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::add(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(v0), v1))
    }

    public fun get_sy_amount_in_for_exact_yt_out<T0: drop>(arg0: u64, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::get_sy_amount_in_for_exact_py_out<T0>(arg0, arg3, arg4, arg2, arg8);
        let v1 = get_sy_amount_out_for_exact_pt_in<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(v0 > v1, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::repay_sy_in_exceeds_expected_sy_in());
        (v0, v1)
    }

    public fun get_sy_amount_out_for_exact_pt_in<T0: drop>(arg0: u64, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, _, _, _, _) = execute_trade_core<T0>(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(arg0)), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(v0)
    }

    public fun mint_lp<T0: drop>(arg0: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, arg1: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, 0x2::coin::Coin<MarketLP<T0>>) {
        let (v0, v1, v2) = mint_lp_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(arg5.market_cap == 0 || 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg6.total_sy) <= arg5.market_cap, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_cap_exceeded());
        (v0, v1, v2)
    }

    public(friend) fun mint_lp_internal<T0: drop>(arg0: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, arg1: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, 0x2::coin::Coin<MarketLP<T0>>) {
        let v0 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(arg0);
        let v1 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(arg1);
        assert!(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0) > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_pt_amount_is_zero());
        assert!(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v1) > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_sy_amount_is_zero());
        assert!(0x2::clock::timestamp_ms(arg7) < arg5.expiry, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_expired());
        let v2 = 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0);
        let v3 = 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v1);
        if (0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp) == 0) {
            let v7 = (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math128::sqrt(((0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0) * 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v1)) as u128)) as u64);
            assert!(v7 >= 1000, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_liquidity_too_low());
            let v8 = 0x2::balance::increase_supply<MarketLP<T0>>(&mut arg6.total_lp, v7 - 1000);
            0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut arg6.total_pt, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut v0, v2));
            0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg6.total_sy, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut v1, v3));
            0x2::transfer::public_freeze_object<0x2::coin::Coin<MarketLP<T0>>>(0x2::coin::from_balance<MarketLP<T0>>(0x2::balance::increase_supply<MarketLP<T0>>(&mut arg6.total_lp, 1000), arg8));
            let v9 = get_exchange_rate<T0>(arg2, arg3, arg4, arg5, arg6, arg7, true, arg8);
            arg6.last_ln_implied_rate = get_ln_implied_rate(v9, arg5.expiry - 0x2::clock::timestamp_ms(arg7));
            assert!(!0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::equal(arg6.last_ln_implied_rate, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero()), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_ln_implied_rate_is_zero());
            let v10 = AddLiquidityEvent<T0>{
                market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                expiry          : arg5.expiry,
                pt_amount       : v2,
                sy_amount       : v3,
                lp_amount       : 0x2::balance::value<MarketLP<T0>>(&v8),
                exchange_rate   : v9,
            };
            0x2::event::emit<AddLiquidityEvent<T0>>(v10);
            (0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(v0, arg8), 0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(v1, arg8), 0x2::coin::from_balance<MarketLP<T0>>(v8, arg8))
        } else {
            let v11 = v2 * 0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp) / 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg6.total_pt);
            let v12 = v3 * 0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp) / 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg6.total_sy);
            if (v11 < v12) {
                0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut arg6.total_pt, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut v0, v2));
                let v13 = 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut v1, (0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg6.total_sy) * v11 + 0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp) - 1) / 0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp));
                0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg6.total_sy, v13);
                let v14 = 0x2::balance::increase_supply<MarketLP<T0>>(&mut arg6.total_lp, v11);
                let v15 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                    expiry          : arg5.expiry,
                    pt_amount       : v2,
                    sy_amount       : 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v13),
                    lp_amount       : 0x2::balance::value<MarketLP<T0>>(&v14),
                    exchange_rate   : get_exchange_rate<T0>(arg2, arg3, arg4, arg5, arg6, arg7, true, arg8),
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v15);
                (0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(v0, arg8), 0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(v1, arg8), 0x2::coin::from_balance<MarketLP<T0>>(v14, arg8))
            } else {
                0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg6.total_sy, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut v1, v3));
                0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut arg6.total_pt, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut v0, (0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&arg6.total_pt) * v12 + 0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp) - 1) / 0x2::balance::supply_value<MarketLP<T0>>(&arg6.total_lp)));
                let v16 = 0x2::balance::increase_supply<MarketLP<T0>>(&mut arg6.total_lp, v12);
                let v17 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                    expiry          : arg5.expiry,
                    pt_amount       : 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0),
                    sy_amount       : v3,
                    lp_amount       : 0x2::balance::value<MarketLP<T0>>(&v16),
                    exchange_rate   : get_exchange_rate<T0>(arg2, arg3, arg4, arg5, arg6, arg7, true, arg8),
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v17);
                (0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(v0, arg8), 0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(v1, arg8), 0x2::coin::from_balance<MarketLP<T0>>(v16, arg8))
            }
        }
    }

    public fun swap_exact_pt_for_sy<T0: drop>(arg0: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg2: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>> {
        let v0 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(arg2);
        let v1 = 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0);
        assert!(arg5.expiry > 0x2::clock::timestamp_ms(arg7), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_expired());
        let (v2, v3, v4, _, _) = execute_trade_core<T0>(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(v1)), arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut arg6.total_pt, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>>(0x2::coin::take<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg6.total_sy, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(v3), arg8), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::get_treasury(arg0));
        let v7 = get_exchange_rate<T0>(arg1, arg3, arg4, arg5, arg6, arg7, false, arg8);
        arg6.last_ln_implied_rate = get_ln_implied_rate(v7, arg5.expiry - 0x2::clock::timestamp_ms(arg7));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
            expiry          : arg5.expiry,
            pt_amount       : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(v1)),
            sy_amount       : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(v2),
            fee             : v4,
            reserve_fee     : v3,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        0x2::coin::take<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg6.total_sy, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(v2), arg8)
    }

    public fun swap_exact_yt_for_sy<T0: drop>(arg0: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTStruct<T0>, arg5: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg6: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg7: &MarketConfig<T0>, arg8: &mut MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>> {
        let v0 = 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(0x2::coin::balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(&arg0));
        let (v1, v2, v3) = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::redeem_py<T0>(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::mint<T0>(arg4, v0, arg10), arg0, arg3, arg6, arg4, arg5, arg2, arg9, arg10);
        0x2::balance::destroy_zero<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(v1));
        0x2::balance::destroy_zero<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(v2));
        let (v4, v5) = swap_sy_for_exact_pt<T0>(v0, arg1, arg2, v3, arg3, arg6, arg7, arg8, arg9, arg10);
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::burn<T0>(arg4, 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(v5));
        v4
    }

    public fun swap_sy_for_exact_pt<T0: drop>(arg0: u64, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg3: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, arg4: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg5: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg6: &MarketConfig<T0>, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>) {
        let v0 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(arg3);
        assert!(arg6.expiry > 0x2::clock::timestamp_ms(arg8), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_expired());
        let (v1, v2, v3, _, _) = execute_trade_core<T0>(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(arg0), arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        let v6 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(v1);
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::add(v6, v2)) <= 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v0), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_insufficient_sy_for_swap());
        0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg7.total_sy, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut v0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(v6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>>(0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut v0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::truncate(v2)), arg9), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::get_treasury(arg1));
        let v7 = get_exchange_rate<T0>(arg2, arg4, arg5, arg6, arg7, arg8, false, arg9);
        arg7.last_ln_implied_rate = get_ln_implied_rate(v7, arg6.expiry - 0x2::clock::timestamp_ms(arg8));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg7),
            expiry          : arg6.expiry,
            pt_amount       : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::neg(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : v6,
            fee             : v3,
            reserve_fee     : v2,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        (0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(v0, arg9), 0x2::coin::take<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut arg7.total_pt, arg0, arg9))
    }

    public fun swap_sy_for_exact_yt<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::market_global::MarketFactoryConfig, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg5: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTStruct<T0>, arg6: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg7: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg8: &MarketConfig<T0>, arg9: &mut MarketState<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>) {
        let (v0, v1) = get_sy_amount_in_for_exact_yt_out<T0>(arg0, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11);
        assert!(v0 - v1 <= 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(0x2::coin::balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&arg1)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::market_insufficient_sy_in_for_swap_yt());
        let v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::mint<T0>(v1, arg4, arg11);
        0x2::coin::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg1, v2);
        let (v3, v4) = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::mint_py<T0>(0x2::coin::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg1, v0, arg11), arg4, arg5, arg6, arg7, arg3, arg10, arg11);
        let v5 = swap_exact_pt_for_sy<T0>(arg2, arg3, v3, arg4, arg7, arg8, arg9, arg10, arg11);
        assert!(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(0x2::coin::balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v5)) == 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(0x2::coin::balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v2)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::swapped_sy_borrowed_amount_not_equal());
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::burn<T0>(v5, arg4);
        (arg1, v4)
    }

    public fun update_current_exchange_rate<T0: drop>(arg0: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldFactoryConfig, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory::YieldTokenConfig<T0>, arg3: &MarketConfig<T0>, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = get_exchange_rate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, false, arg6);
        arg4.current_exchange_rate = v0;
        v0
    }

    // decompiled from Move bytecode v6
}

