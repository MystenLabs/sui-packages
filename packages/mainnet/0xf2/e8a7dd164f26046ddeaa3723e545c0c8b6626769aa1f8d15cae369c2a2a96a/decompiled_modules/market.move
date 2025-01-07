module 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market {
    struct MarketLP<phantom T0: drop> has drop {
        dummy_field: bool,
    }

    struct MarketConfig<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        expiry: u64,
        scalarRoot: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
        initialAnchor: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
        lnFeeRateRoot: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::FixedPoint64,
    }

    struct MarketState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        totalPt: 0x2::balance::Balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>,
        totalSy: 0x2::balance::Balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>,
        totalLp: 0x2::balance::Supply<MarketLP<T0>>,
        lastLnImpliedRate: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::FixedPoint64,
    }

    struct AddLiquidityEvent<phantom T0: drop> has copy, drop {
        marketStateId: 0x2::object::ID,
        expiry: u64,
        ptAmount: u64,
        syAmount: u64,
        lpAmount: u64,
        exchangeRate: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    struct RemoveLiquidityEvent<phantom T0: drop> has copy, drop {
        marketStateId: 0x2::object::ID,
        expiry: u64,
        ptAmount: u64,
        syAmount: u64,
        lpAmount: u64,
    }

    struct SwapEvent<phantom T0: drop> has copy, drop {
        marketStateId: 0x2::object::ID,
        expiry: u64,
        ptAmount: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
        syAmount: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
        fee: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
        reserveFee: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
        exchangeRate: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    public fun burn_lp<T0: drop>(arg0: address, arg1: address, arg2: &MarketConfig<T0>, arg3: 0x2::coin::Coin<MarketLP<T0>>, arg4: &mut MarketState<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<MarketLP<T0>>(arg3);
        let v1 = 0x2::balance::value<MarketLP<T0>>(&v0);
        let v2 = v1 * 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&arg4.totalSy) / 0x2::balance::supply_value<MarketLP<T0>>(&arg4.totalLp);
        let v3 = v1 * 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg4.totalPt) / 0x2::balance::supply_value<MarketLP<T0>>(&arg4.totalLp);
        assert!(v2 > 0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_sy_amount_is_zero());
        assert!(v3 > 0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_pt_amount_is_zero());
        0x2::balance::decrease_supply<MarketLP<T0>>(&mut arg4.totalLp, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>>(0x2::coin::take<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut arg4.totalPt, v3, arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(0x2::coin::take<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg4.totalSy, v2, arg5), arg0);
        let v4 = RemoveLiquidityEvent<T0>{
            marketStateId : 0x2::object::id<MarketState<T0>>(arg4),
            expiry        : arg2.expiry,
            ptAmount      : v3,
            syAmount      : v2,
            lpAmount      : v1,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0>>(v4);
    }

    public(friend) fun create<T0: drop>(arg0: u64, arg1: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketConfig<T0>{
            id            : 0x2::object::new(arg4),
            name          : b"Nemo Market",
            symbol        : b"Nemo-LP",
            decimals      : 9,
            expiry        : arg0,
            scalarRoot    : arg1,
            initialAnchor : arg2,
            lnFeeRateRoot : arg3,
        };
        let v1 = MarketLP<T0>{dummy_field: false};
        let v2 = MarketState<T0>{
            id                : 0x2::object::new(arg4),
            totalPt           : 0x2::balance::zero<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(),
            totalSy           : 0x2::balance::zero<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(),
            totalLp           : 0x2::balance::create_supply<MarketLP<T0>>(v1),
            lastLnImpliedRate : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::zero(),
        };
        0x2::transfer::share_object<MarketConfig<T0>>(v0);
        0x2::transfer::share_object<MarketState<T0>>(v2);
    }

    public entry fun current_exchange_rate<T0: drop>(arg0: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldFactoryConfig, arg1: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYStruct<T0>, arg2: &mut 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldTokenConfig<T0>, arg3: &MarketConfig<T0>, arg4: &MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        get_exchange_rate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun execute_trade_core<T0: drop>(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_global::MarketFactoryConfig, arg2: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldFactoryConfig, arg3: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYStruct<T0>, arg4: &mut 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldTokenConfig<T0>, arg5: &MarketConfig<T0>, arg6: &MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) {
        assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::less(arg0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg6.totalPt))), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_insufficient_pt_for_swap());
        let v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::currentPyIndex<T0>(arg2, arg4, arg3, arg8);
        let v1 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::multiply(v0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&arg6.totalSy)));
        let v2 = arg5.expiry - 0x2::clock::timestamp_ms(arg7);
        let v3 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_rate_scalar(arg5.scalarRoot, v2);
        let v4 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_rate_anchor(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg6.totalPt)), arg6.lastLnImpliedRate, v1, v3, v2);
        let v5 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_exchange_rate_from_implied_rate(arg5.lnFeeRateRoot, v2);
        let v6 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_exchange_rate(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v1), true), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg6.totalPt)), v3, v4, arg0);
        let v7 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(arg0, v6));
        let v8 = if (0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0)) {
            assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::greater_or_equal(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(v6, v5), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::one()), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_exchange_rate_below_one());
            0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::mulDown(v7, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::one(), v5))
        } else {
            0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::mul(v7, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::one(), v5)), v5))
        };
        let v9 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(v7, v8);
        let v10 = if (0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::less(v9, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::zero())) {
            0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::add(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::abs(v9), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v0), true)), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(1, true)), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v0), true)))
        } else {
            0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(v9, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v0), true))
        };
        (v10, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::mul(v8, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_global::get_reserve_fee_percent(arg1)), true)), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v0), true)), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::div(v8, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v0), true)), v3, v4)
    }

    fun get_exchange_rate<T0: drop>(arg0: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldFactoryConfig, arg1: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYStruct<T0>, arg2: &mut 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldTokenConfig<T0>, arg3: &MarketConfig<T0>, arg4: &MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::multiply(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::currentPyIndex<T0>(arg0, arg2, arg1, arg6), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&arg4.totalSy)));
        let v1 = arg3.expiry - 0x2::clock::timestamp_ms(arg5);
        let v2 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_rate_scalar(arg3.scalarRoot, v1);
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_exchange_rate(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(v0), true), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg4.totalPt)), v2, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_math::get_rate_anchor(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg4.totalPt)), arg4.lastLnImpliedRate, v0, v2, v1), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::zero())
    }

    fun get_ln_implied_rate(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::FixedPoint64 {
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::mul_div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign::ln(arg0)), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::from_uint64(31536000000), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::from_uint64(arg1))
    }

    public fun mint_lp<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>, arg2: 0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>, arg3: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldFactoryConfig, arg4: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYStruct<T0>, arg5: &mut 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldTokenConfig<T0>, arg6: &MarketConfig<T0>, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(arg1);
        let v1 = 0x2::coin::into_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(arg2);
        assert!(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&v0) > 0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_pt_amount_is_zero());
        assert!(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&v1) > 0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_sy_amount_is_zero());
        assert!(0x2::clock::timestamp_ms(arg8) < arg6.expiry, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_expired());
        let v2 = 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&v0);
        let v3 = 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&v1);
        if (0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp) == 0) {
            let v4 = (0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math128::sqrt(((0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&v0) * 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&v1)) as u128)) as u64);
            assert!(v4 >= 1000, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_liquidity_too_low());
            let v5 = 0x2::balance::increase_supply<MarketLP<T0>>(&mut arg7.totalLp, v4 - 1000);
            0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut arg7.totalPt, 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut v0, v2));
            0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg7.totalSy, 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut v1, v3));
            0x2::transfer::public_freeze_object<0x2::coin::Coin<MarketLP<T0>>>(0x2::coin::from_balance<MarketLP<T0>>(0x2::balance::increase_supply<MarketLP<T0>>(&mut arg7.totalLp, 1000), arg9));
            0x2::transfer::public_transfer<0x2::coin::Coin<MarketLP<T0>>>(0x2::coin::from_balance<MarketLP<T0>>(v5, arg9), arg0);
            let v6 = get_exchange_rate<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
            arg7.lastLnImpliedRate = get_ln_implied_rate(v6, arg6.expiry - 0x2::clock::timestamp_ms(arg8));
            assert!(!0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::equal(arg7.lastLnImpliedRate, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::zero()), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_ln_implied_rate_is_zero());
            let v7 = AddLiquidityEvent<T0>{
                marketStateId : 0x2::object::id<MarketState<T0>>(arg7),
                expiry        : arg6.expiry,
                ptAmount      : v2,
                syAmount      : v3,
                lpAmount      : 0x2::balance::value<MarketLP<T0>>(&v5),
                exchangeRate  : v6,
            };
            0x2::event::emit<AddLiquidityEvent<T0>>(v7);
        } else {
            let v8 = v2 * 0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp) / 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg7.totalPt);
            let v9 = v3 * 0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp) / 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&arg7.totalSy);
            if (v8 < v9) {
                0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut arg7.totalPt, 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut v0, v2));
                let v10 = 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut v1, (0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&arg7.totalSy) * v8 + 0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp) - 1) / 0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp));
                0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg7.totalSy, v10);
                let v11 = 0x2::balance::increase_supply<MarketLP<T0>>(&mut arg7.totalLp, v8);
                0x2::transfer::public_transfer<0x2::coin::Coin<MarketLP<T0>>>(0x2::coin::from_balance<MarketLP<T0>>(v11, arg9), arg0);
                let v12 = AddLiquidityEvent<T0>{
                    marketStateId : 0x2::object::id<MarketState<T0>>(arg7),
                    expiry        : arg6.expiry,
                    ptAmount      : v2,
                    syAmount      : 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&v10),
                    lpAmount      : 0x2::balance::value<MarketLP<T0>>(&v11),
                    exchangeRate  : get_exchange_rate<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9),
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v12);
            } else {
                0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg7.totalSy, 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut v1, v3));
                0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut arg7.totalPt, 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut v0, (0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&arg7.totalPt) * v9 + 0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp) - 1) / 0x2::balance::supply_value<MarketLP<T0>>(&arg7.totalLp)));
                let v13 = 0x2::balance::increase_supply<MarketLP<T0>>(&mut arg7.totalLp, v9);
                0x2::transfer::public_transfer<0x2::coin::Coin<MarketLP<T0>>>(0x2::coin::from_balance<MarketLP<T0>>(v13, arg9), arg0);
                let v14 = AddLiquidityEvent<T0>{
                    marketStateId : 0x2::object::id<MarketState<T0>>(arg7),
                    expiry        : arg6.expiry,
                    ptAmount      : 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&v0),
                    syAmount      : v3,
                    lpAmount      : 0x2::balance::value<MarketLP<T0>>(&v13),
                    exchangeRate  : get_exchange_rate<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9),
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v14);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>>(0x2::coin::from_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(v0, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(0x2::coin::from_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(v1, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun swap_exact_pt_for_sy<T0: drop>(arg0: address, arg1: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_global::MarketFactoryConfig, arg2: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldFactoryConfig, arg3: 0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>, arg4: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYStruct<T0>, arg5: &mut 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldTokenConfig<T0>, arg6: &MarketConfig<T0>, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(arg3);
        assert!(arg6.expiry > 0x2::clock::timestamp_ms(arg8), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_expired());
        let v1 = 0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&v0);
        let (v2, v3, v4, _, _) = execute_trade_core<T0>(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(v1)), arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut arg7.totalPt, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(0x2::coin::take<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg7.totalSy, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::truncate(v2), arg9), arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(0x2::coin::take<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg7.totalSy, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::truncate(v3), arg9), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_global::get_treasury(arg1));
        let v7 = get_exchange_rate<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        arg7.lastLnImpliedRate = get_ln_implied_rate(v7, arg6.expiry - 0x2::clock::timestamp_ms(arg8));
        let v8 = SwapEvent<T0>{
            marketStateId : 0x2::object::id<MarketState<T0>>(arg7),
            expiry        : arg6.expiry,
            ptAmount      : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(v1),
            syAmount      : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(v2),
            fee           : v4,
            reserveFee    : v3,
            exchangeRate  : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
    }

    public fun swap_sy_for_exact_pt<T0: drop>(arg0: address, arg1: u64, arg2: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_global::MarketFactoryConfig, arg3: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldFactoryConfig, arg4: 0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>, arg5: &0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYStruct<T0>, arg6: &mut 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::yield_factory::YieldTokenConfig<T0>, arg7: &MarketConfig<T0>, arg8: &mut MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(arg4);
        assert!(arg7.expiry > 0x2::clock::timestamp_ms(arg9), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_expired());
        let (v1, v2, v3, _, _) = execute_trade_core<T0>(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(arg1), arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10);
        assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::less_or_equal(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(v1), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(0x2::balance::value<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&v0))), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::error::market_insufficient_sy_for_swap());
        0x2::balance::join<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg8.totalSy, 0x2::balance::split<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut v0, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::truncate(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(v1))));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>>(0x2::coin::take<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::pt::PTCoin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(&mut arg8.totalPt, arg1, arg10), arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(0x2::coin::take<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(&mut arg8.totalSy, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::truncate(v2), arg10), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::market_global::get_treasury(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>>(0x2::coin::from_balance<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::sy::SYCoin<T0>>(v0, arg10), 0x2::tx_context::sender(arg10));
        let v6 = get_exchange_rate<T0>(arg3, arg5, arg6, arg7, arg8, arg9, arg10);
        arg8.lastLnImpliedRate = get_ln_implied_rate(v6, arg7.expiry - 0x2::clock::timestamp_ms(arg9));
        let v7 = SwapEvent<T0>{
            marketStateId : 0x2::object::id<MarketState<T0>>(arg8),
            expiry        : arg7.expiry,
            ptAmount      : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::from_uint64(arg1)),
            syAmount      : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::neg(v1),
            fee           : v3,
            reserveFee    : v2,
            exchangeRate  : v6,
        };
        0x2::event::emit<SwapEvent<T0>>(v7);
    }

    // decompiled from Move bytecode v6
}

