module 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market {
    struct MarketState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        market_id: 0x1::string::String,
        expiry: u64,
        total_pt: u64,
        total_sy: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        last_ln_implied_rate: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64,
        current_exchange_rate: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        scalar_root: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64,
        market_cap: u64,
    }

    struct MarketStateCache<phantom T0: drop> has copy, drop {
        total_asset: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64,
        rate_scalar: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        rate_anchor: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        fee_rate: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        time_to_expire: u64,
        index: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64,
        exchange_rate: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64,
    }

    struct AddLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        exchange_rate: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
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
        pt_amount: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        sy_amount: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        fee: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        reserve_fee: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
        exchange_rate: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    public(friend) fun add_approx_liquidity_single_sy<T0: drop>(arg0: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg1: &MarketStateCache<T0>, arg2: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg3: &MarketState<T0>) : (u64, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign) {
        let v0 = 1;
        let v1 = calc_max_pt_out_for_sy_in<T0>(arg1, arg3);
        while (v0 <= v1) {
            let v2 = (v1 + v0) / 2;
            let (v3, v4, v5, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(v2), arg1, arg2, arg3);
            let v8 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::remove_sign(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(v3));
            if (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::greater(v8, arg0)) {
                v1 = v2 - 1;
                continue
            };
            let v9 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::multiply(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(v2), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::add(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg3.total_sy)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::sub(v8, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::remove_sign(v4))));
            let v10 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::multiply(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::sub(arg0, v8), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(arg3.total_pt - v2));
            if (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::less_or_equal(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::multiply(v10, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_rational(((1000000000 - 1000000) as u128), (1000000000 as u128))), v9) && 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::less_or_equal(v9, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::multiply(v10, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_rational(((1000000000 + 1000000) as u128), (1000000000 as u128))))) {
                return (v2, v8, v5)
            };
            if (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::less_or_equal(v9, v10)) {
                v0 = v2 + 1;
                continue
            };
            v1 = v2 - 1;
        };
        (0, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::zero(), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::zero())
    }

    public fun add_liquidity_single_sy<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::MarketPosition {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg8) < 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::expiry(arg4), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg4) == arg7.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg5), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.total_pt > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_in_for_mint_lp());
        let v0 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg3, arg9));
        let v1 = arg1;
        let v2 = create_position<T0>(arg7, arg8, arg9);
        let v3 = get_market_state_cache<T0>(v0, arg5, arg7, arg8);
        let (v4, _, _) = add_approx_liquidity_single_sy<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(0x2::coin::value<T0>(&v1)), &v3, arg6, arg7);
        let v7 = swap_sy_for_exact_pt_internal<T0>(v4, v1, v0, &v3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v8 = &mut v2;
        v1 = mint_lp_internal<T0>(v4, v7, v0, arg4, arg5, v8, arg7, arg8, arg9);
        0x2::balance::join<T0>(&mut arg7.total_sy, 0x2::coin::into_balance<T0>(v1));
        assert!(arg7.market_cap == 0 || 0x2::balance::value<T0>(&arg7.total_sy) <= arg7.market_cap, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_cap_exceeded());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::lp_amount(&v2) >= arg2, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::insufficient_lp_output());
        v2
    }

    public fun burn_lp<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: u64, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg3: &mut MarketState<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::MarketPosition, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        assert!(arg1 > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_lp_amount_is_zero());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::lp_amount(arg4) >= arg1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_lp_for_burn());
        assert!(arg3.py_state_id == 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg2), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::market_state_id(arg4) == 0x2::object::id<MarketState<T0>>(arg3), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_market_position());
        let v0 = (((arg1 as u128) * (0x2::balance::value<T0>(&arg3.total_sy) as u128) / (arg3.lp_supply as u128)) as u64);
        let v1 = (((arg1 as u128) * (arg3.total_pt as u128) / (arg3.lp_supply as u128)) as u64);
        assert!(v0 > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_sy_amount_is_zero());
        assert!(v1 > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_pt_amount_is_zero());
        arg3.lp_supply = arg3.lp_supply - arg1;
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::decrease_lp_amount(arg4, arg1, arg5);
        arg3.total_pt = arg3.total_pt - v1;
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::join_pt(arg2, v1, arg5);
        let v2 = RemoveLiquidityEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg3),
            expiry          : arg3.expiry,
            pt_amount       : v1,
            sy_amount       : v0,
            lp_amount       : arg1,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0>>(v2);
        0x2::coin::take<T0>(&mut arg3.total_sy, v0, arg6)
    }

    fun calc_max_pt_out_for_sy_in<T0: drop>(arg0: &MarketStateCache<T0>, arg1: &MarketState<T0>) : u64 {
        let v0 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::exp(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::mul(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(arg0.fee_rate, arg0.rate_anchor), arg0.rate_scalar));
        0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::truncate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::multiply(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::sub(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(arg1.total_pt), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::multiply(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::remove_sign(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(v0, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::add(v0, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::one()))), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::add(arg0.total_asset, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(arg1.total_pt)))), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_rational(999, 1000)))
    }

    public(friend) fun create<T0: drop>(arg0: 0x1::string::String, arg1: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg2: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = MarketState<T0>{
            id                    : 0x2::object::new(arg6),
            py_state_id           : 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg1),
            market_id             : arg0,
            expiry                : 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::expiry<T0>(arg1),
            total_pt              : 0,
            total_sy              : 0x2::balance::zero<T0>(),
            lp_supply             : 0,
            last_ln_implied_rate  : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::zero(),
            current_exchange_rate : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::zero(),
            scalar_root           : arg2,
            initial_anchor        : arg3,
            ln_fee_rate_root      : arg4,
            market_cap            : arg5,
        };
        0x2::transfer::share_object<MarketState<T0>>(v0);
        0x2::object::id<MarketState<T0>>(&v0)
    }

    public(friend) fun create_position<T0: drop>(arg0: &MarketState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::MarketPosition {
        let v0 = 0x1::type_name::get<T0>();
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::mint(0x2::object::id<MarketState<T0>>(arg0), 0x1::string::from_ascii(0x1::type_name::get_module(&v0)), arg0.expiry, arg1, arg2)
    }

    fun execute_trade_core<T0: drop>(arg0: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, arg1: &MarketStateCache<T0>, arg2: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg3: &MarketState<T0>) : (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign) {
        assert!(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::less_or_equal(arg0, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg3.total_pt)), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_for_swap());
        let v0 = arg1.rate_scalar;
        let v1 = arg1.rate_anchor;
        let v2 = arg1.fee_rate;
        let v3 = arg1.index;
        let v4 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_exchange_rate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::truncate(arg1.total_asset)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg3.total_pt), v0, v1, arg0);
        let v5 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(arg0, v4));
        let v6 = if (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::is_positive(arg0)) {
            assert!(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::greater_or_equal(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(v4, v2), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::one()), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_exchange_rate_below_one());
            0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::mul(v5, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::one(), v2))
        } else {
            0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::mul(v5, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::one(), v2)), v2))
        };
        let v7 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(v5, v6);
        let v8 = if (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::less(v7, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::zero())) {
            0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::add(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::abs(v7), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::get_raw_value(v3), true)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(1, true)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::get_raw_value(v3), true)))
        } else {
            0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(v7, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::get_raw_value(v3), true))
        };
        (v8, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::mul(v6, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::get_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::get_reserve_fee_percent(arg2, arg3.market_id)), true)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::get_raw_value(v3), true)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::div(v6, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::create_from_raw_value(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::get_raw_value(v3), true)), v0, v1)
    }

    fun get_exchange_rate<T0: drop>(arg0: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg1: &MarketState<T0>, arg2: &0x2::clock::Clock, arg3: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg4: bool) : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign {
        if (arg4) {
            0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_exchange_rate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::truncate(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::sy::sy_to_asset(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::current_py_index<T0>(arg3, arg0, arg2), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg1.total_sy))))), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg1.total_pt), 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_rate_scalar(arg1.scalar_root, arg1.expiry), arg1.initial_anchor, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::zero())
        } else {
            let (v1, v2, v3, _, _, _) = get_market_state<T0>(arg3, arg0, arg1, arg2);
            0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_exchange_rate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::truncate(v1)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg1.total_pt), v2, v3, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::zero())
        }
    }

    fun get_ln_implied_rate(arg0: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64 {
        0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64::mul_div(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::remove_sign(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math_fixed64_with_sign::ln(arg0)), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(31536000000), 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(arg1))
    }

    fun get_market_state<T0: drop>(arg0: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg1: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg2: &MarketState<T0>, arg3: &0x2::clock::Clock) : (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign, u64, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64) {
        let v0 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::current_py_index<T0>(arg0, arg1, arg3);
        let v1 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::sy::sy_to_asset(v0, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg2.total_sy)));
        let v2 = arg2.expiry - 0x2::clock::timestamp_ms(arg3);
        let v3 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_rate_scalar(arg2.scalar_root, v2);
        (v1, v3, 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_rate_anchor(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::from_uint64(arg2.total_pt), arg2.last_ln_implied_rate, v1, v3, v2), 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_math::get_exchange_rate_from_implied_rate(arg2.ln_fee_rate_root, v2), v2, v0)
    }

    fun get_market_state_cache<T0: drop>(arg0: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg1: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg2: &MarketState<T0>, arg3: &0x2::clock::Clock) : MarketStateCache<T0> {
        let (v0, v1, v2, v3, v4, v5) = get_market_state<T0>(arg0, arg1, arg2, arg3);
        MarketStateCache<T0>{
            total_asset    : v0,
            rate_scalar    : v1,
            rate_anchor    : v2,
            fee_rate       : v3,
            time_to_expire : v4,
            index          : v5,
            exchange_rate  : arg0,
        }
    }

    public fun get_sy_amount_in_for_exact_pt_out<T0: drop>(arg0: u64, arg1: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg2: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg3: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = get_market_state_cache<T0>(arg2, arg3, arg4, arg5);
        let (v1, _, _, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0), &v0, arg1, arg4);
        0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(v1))
    }

    fun get_sy_amount_in_for_exact_pt_out_internal<T0: drop>(arg0: u64, arg1: &MarketStateCache<T0>, arg2: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg3: &MarketState<T0>) : u64 {
        let (v0, _, _, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0), arg1, arg2, arg3);
        0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(v0))
    }

    public fun get_sy_amount_in_for_exact_yt_out<T0: drop>(arg0: u64, arg1: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg3: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::get_sy_amount_in_for_exact_py_out<T0>(arg0, arg3, arg2, arg5);
        let v1 = get_sy_amount_out_for_exact_pt_in<T0>(arg0, arg3, arg2, arg1, arg4, arg5);
        assert!(v0 > v1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::repay_sy_in_exceeds_expected_sy_in());
        (v0, v1)
    }

    fun get_sy_amount_in_for_exact_yt_out_internal<T0: drop>(arg0: u64, arg1: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg2: &MarketStateCache<T0>, arg3: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg4: &MarketState<T0>, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::get_sy_amount_in_for_exact_py_out<T0>(arg0, arg2.exchange_rate, arg1, arg5);
        let v1 = get_sy_amount_out_for_exact_pt_in_internal<T0>(arg0, arg2, arg3, arg4);
        assert!(v0 > v1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::repay_sy_in_exceeds_expected_sy_in());
        (v0, v1)
    }

    public fun get_sy_amount_out_for_exact_pt_in<T0: drop>(arg0: u64, arg1: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg3: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = get_market_state_cache<T0>(arg1, arg2, arg4, arg5);
        let (v1, _, _, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0)), &v0, arg3, arg4);
        0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(v1)
    }

    fun get_sy_amount_out_for_exact_pt_in_internal<T0: drop>(arg0: u64, arg1: &MarketStateCache<T0>, arg2: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg3: &MarketState<T0>) : u64 {
        let (v0, _, _, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0)), arg1, arg2, arg3);
        0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(v0)
    }

    public fun mint_lp<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg6: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::MarketPosition) {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        let (v0, _) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_amount(arg5);
        assert!(0x2::clock::timestamp_ms(arg8) < 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::expiry(arg5), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        assert!(arg2 > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_pt_amount_is_zero());
        assert!(v0 >= arg2, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_in_for_mint_lp());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg5) == arg7.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg6), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.lp_supply > 0 || arg2 == 0x2::coin::value<T0>(&arg1), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_market_position());
        let v2 = create_position<T0>(arg7, arg8, arg9);
        let v3 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg4, arg9));
        let v4 = &mut v2;
        let v5 = mint_lp_internal<T0>(arg2, arg1, v3, arg5, arg6, v4, arg7, arg8, arg9);
        assert!(arg7.market_cap == 0 || 0x2::balance::value<T0>(&arg7.total_sy) <= arg7.market_cap, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_cap_exceeded());
        assert!(arg7.lp_supply >= arg3, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::insufficient_lp_output());
        (v5, v2)
    }

    public(friend) fun mint_lp_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg3: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::MarketPosition, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_sy_amount_is_zero());
        let v1 = 0x2::balance::value<T0>(&v0);
        if (arg6.lp_supply == 0) {
            let v3 = (0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::math128::sqrt((arg0 as u128) * (v1 as u128)) as u64);
            assert!(v3 >= 1000, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_liquidity_too_low());
            let v4 = v3 - 1000;
            0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::split_pt(arg3, arg0, arg7);
            arg6.total_pt = arg6.total_pt + arg0;
            0x2::balance::join<T0>(&mut arg6.total_sy, 0x2::balance::split<T0>(&mut v0, v1));
            arg6.lp_supply = v3;
            0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::set_lp_amount(arg5, v4, arg7);
            let v5 = get_exchange_rate<T0>(arg4, arg6, arg7, arg2, true);
            arg6.last_ln_implied_rate = get_ln_implied_rate(v5, arg6.expiry - 0x2::clock::timestamp_ms(arg7));
            assert!(!0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::equal(arg6.last_ln_implied_rate, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::zero()), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_ln_implied_rate_is_zero());
            let v6 = AddLiquidityEvent<T0>{
                market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                expiry          : arg6.expiry,
                pt_amount       : arg0,
                sy_amount       : v1,
                lp_amount       : v4,
                exchange_rate   : v5,
            };
            0x2::event::emit<AddLiquidityEvent<T0>>(v6);
            0x2::coin::from_balance<T0>(v0, arg8)
        } else {
            let v7 = (((arg0 as u128) * (arg6.lp_supply as u128) / (arg6.total_pt as u128)) as u64);
            let v8 = (((v1 as u128) * (arg6.lp_supply as u128) / (0x2::balance::value<T0>(&arg6.total_sy) as u128)) as u64);
            assert!(v7 > 0 && v8 > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_lp_amount_is_zero());
            if (v7 < v8) {
                arg6.total_pt = arg6.total_pt + arg0;
                0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::split_pt(arg3, arg0, arg7);
                let v9 = 0x2::balance::split<T0>(&mut v0, ((((0x2::balance::value<T0>(&arg6.total_sy) as u128) * (v7 as u128) + ((arg6.lp_supply - 1) as u128)) / (arg6.lp_supply as u128)) as u64));
                assert!(0x2::balance::value<T0>(&v9) > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_sy_amount_is_zero());
                0x2::balance::join<T0>(&mut arg6.total_sy, v9);
                arg6.lp_supply = arg6.lp_supply + v7;
                0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::increase_lp_amount(arg5, v7, arg7);
                let v10 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                    expiry          : arg6.expiry,
                    pt_amount       : arg0,
                    sy_amount       : 0x2::balance::value<T0>(&v9),
                    lp_amount       : v7,
                    exchange_rate   : get_exchange_rate<T0>(arg4, arg6, arg7, arg2, false),
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v10);
                0x2::coin::from_balance<T0>(v0, arg8)
            } else {
                0x2::balance::join<T0>(&mut arg6.total_sy, 0x2::balance::split<T0>(&mut v0, v1));
                let v11 = ((((arg6.total_pt as u128) * (v8 as u128) + ((arg6.lp_supply - 1) as u128)) / (arg6.lp_supply as u128)) as u64);
                assert!(v11 > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_pt_amount_is_zero());
                0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::split_pt(arg3, v11, arg7);
                arg6.total_pt = arg6.total_pt + v11;
                arg6.lp_supply = arg6.lp_supply + v8;
                0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::increase_lp_amount(arg5, v8, arg7);
                let v12 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                    expiry          : arg6.expiry,
                    pt_amount       : v11,
                    sy_amount       : v1,
                    lp_amount       : v8,
                    exchange_rate   : get_exchange_rate<T0>(arg4, arg6, arg7, arg2, false),
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v12);
                0x2::coin::from_balance<T0>(v0, arg8)
            }
        }
    }

    public fun seed_liquidity<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::YieldFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_position::MarketPosition {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg8) < 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::expiry(arg4), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg4) == arg7.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg5), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        let v0 = create_position<T0>(arg7, arg8, arg9);
        let v1 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg3, arg9));
        let v2 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::mint_py_internal<T0>(0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) / 2, arg9), v1, arg4, arg5, arg6, arg8, arg9);
        let v3 = &mut v0;
        let v4 = mint_lp_internal<T0>(v2, arg1, v1, arg4, arg5, v3, arg7, arg8, arg9);
        assert!(0x2::coin::value<T0>(&v4) == 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_burn_sy_amount_is_zero());
        0x2::coin::destroy_zero<T0>(v4);
        assert!(arg7.market_cap == 0 || 0x2::balance::value<T0>(&arg7.total_sy) <= arg7.market_cap, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_cap_exceeded());
        assert!(arg7.lp_supply >= arg2, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::insufficient_lp_output());
        v0
    }

    public fun swap_exact_pt_for_sy<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: u64, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg3: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg4: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg5: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        let (v0, _) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_amount(arg2);
        assert!(v0 >= arg1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_in_for_mint_lp());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg2) == arg6.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg6.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg3), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(0x2::clock::timestamp_ms(arg7) < arg6.expiry, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        let v2 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg4, arg8);
        let v3 = get_market_state_cache<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(v2), arg3, arg6, arg7);
        swap_exact_pt_for_sy_internal<T0>(arg1, arg2, arg3, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(v2), &v3, arg5, arg6, arg7, arg8)
    }

    public(friend) fun swap_exact_pt_for_sy_internal<T0: drop>(arg0: u64, arg1: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg3: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg4: &MarketStateCache<T0>, arg5: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0)), arg4, arg5, arg6);
        assert!(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(v0, v1)) <= 0x2::balance::value<T0>(&arg6.total_sy), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_sy_for_swap());
        arg6.total_pt = arg6.total_pt + arg0;
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::split_pt(arg1, arg0, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg6.total_sy, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(v1), arg8), 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::get_treasury(arg5));
        let v5 = get_exchange_rate<T0>(arg2, arg6, arg7, arg3, false);
        arg6.last_ln_implied_rate = get_ln_implied_rate(v5, arg6.expiry - 0x2::clock::timestamp_ms(arg7));
        let v6 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
            expiry          : arg6.expiry,
            pt_amount       : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(v0),
            fee             : v2,
            reserve_fee     : v1,
            exchange_rate   : v5,
        };
        0x2::event::emit<SwapEvent<T0>>(v6);
        0x2::coin::take<T0>(&mut arg6.total_sy, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(v0), arg8)
    }

    public fun swap_exact_sy_for_pt<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg4) == arg7.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg5), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(0x2::clock::timestamp_ms(arg8) < arg7.expiry, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        let v0 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg3, arg9));
        let v1 = get_market_state_cache<T0>(v0, arg5, arg7, arg8);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = 1;
        let v4 = calc_max_pt_out_for_sy_in<T0>(&v1, arg7);
        assert!(v4 >= arg1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_for_swap());
        let v5 = 0;
        while (v3 <= v4) {
            v3 = (v4 + v3) / 2;
            let v6 = get_sy_amount_in_for_exact_pt_out_internal<T0>(v3, &v1, arg6, arg7);
            if (v6 <= v2) {
                if (v6 >= v2 * (1000000000 - 1000000) / 1000000000) {
                    v5 = v3;
                    break
                };
                continue
            };
            v4 = v3 - 1;
        };
        assert!(v5 >= arg1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_for_swap());
        let v7 = swap_sy_for_exact_pt_internal<T0>(v5, arg2, v0, &v1, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::balance::join<T0>(&mut arg7.total_sy, 0x2::coin::into_balance<T0>(v7));
        v5
    }

    public fun swap_exact_yt_for_sy<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: u64, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg3: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg4: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg5: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::YieldFactoryConfig, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        let (_, v1) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_amount(arg2);
        assert!(v1 >= arg1, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_yt_balance_swap());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg2) == arg7.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg3), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(0x2::clock::timestamp_ms(arg8) < arg7.expiry, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        let v2 = get_market_state_cache<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg4, arg9)), arg3, arg7, arg8);
        swap_exact_yt_for_sy_internal<T0>(arg1, arg2, arg3, &v2, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun swap_exact_yt_for_sy_internal<T0: drop>(arg0: u64, arg1: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg3: &MarketStateCache<T0>, arg4: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::YieldFactoryConfig, arg5: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::borrow_pt_amount<T0>(arg1, arg0, arg2, arg7);
        let v2 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::redeem_py_internal<T0>(arg0, v0, arg3.exchange_rate, arg1, arg2, arg4, arg7, arg8);
        assert!(0x2::coin::value<T0>(&v2) > 0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_sy_amount_is_zero());
        let v3 = swap_sy_for_exact_pt_internal<T0>(arg0, v2, arg3.exchange_rate, arg3, arg1, arg2, arg5, arg6, arg7, arg8);
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::repay_pt_amount<T0>(arg1, arg2, v1, arg7);
        v3
    }

    public fun swap_sy_for_exact_pt<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg4) == arg7.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg5), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg1 <= arg7.total_pt, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_pt_for_swap());
        let v0 = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg3, arg9);
        let v1 = get_market_state_cache<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(v0), arg5, arg7, arg8);
        swap_sy_for_exact_pt_internal<T0>(arg1, arg2, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(v0), &v1, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun swap_sy_for_exact_pt_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg3: &MarketStateCache<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, _, _) = execute_trade_core<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0), arg3, arg6, arg7);
        let v5 = 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(v0);
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg7.total_sy, 0x2::balance::split<T0>(&mut v6, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::sub(v5, v1))));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::truncate(v1)), arg9), 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::get_treasury(arg6));
        arg7.total_pt = arg7.total_pt - arg0;
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::join_pt(arg4, arg0, arg8);
        let v7 = get_exchange_rate<T0>(arg5, arg7, arg8, arg2, false);
        arg7.last_ln_implied_rate = get_ln_implied_rate(v7, arg7.expiry - 0x2::clock::timestamp_ms(arg8));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg7),
            expiry          : arg7.expiry,
            pt_amount       : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::neg(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : v5,
            fee             : v2,
            reserve_fee     : v1,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        0x2::coin::from_balance<T0>(v6, arg9)
    }

    public fun swap_sy_for_exact_yt<T0: drop>(arg0: &0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::Version, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::PriceVoucher<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg6: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::sy::State, arg7: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::YieldFactoryConfig, arg8: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg9: &mut MarketState<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg10) < arg9.expiry, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_expired());
        assert!(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_state_id(arg4) == arg9.py_state_id, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        assert!(arg9.py_state_id == 0x2::object::id<0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>>(arg5), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_invalid_py_state());
        let v0 = get_market_state_cache<T0>(0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::create_from_raw_value(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::oracle::get_price<T0>(arg3, arg11)), arg5, arg9, arg10);
        swap_sy_for_exact_yt_internal<T0>(arg1, arg2, arg4, &v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public(friend) fun swap_sy_for_exact_yt_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::PyPosition, arg3: &MarketStateCache<T0>, arg4: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg5: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::sy::State, arg6: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::YieldFactoryConfig, arg7: &0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::market_global::MarketFactoryConfig, arg8: &mut MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = get_sy_amount_in_for_exact_yt_out_internal<T0>(arg0, arg4, arg3, arg7, arg8, arg9);
        assert!(v0 - v1 <= 0x2::coin::value<T0>(&arg1), 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::market_insufficient_sy_in_for_swap_yt());
        let (v2, v3) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::sy::borrow<T0>(v1, arg5, arg10);
        0x2::coin::join<T0>(&mut arg1, v2);
        let (_, v5) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_amount(arg2);
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::mint_py_internal<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg10), arg3.exchange_rate, arg2, arg4, arg6, arg9, arg10);
        let (_, v7) = 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py_position::py_amount(arg2);
        assert!(v7 - v5 >= arg0, 0x583aec0b2c0c6b804ef2270a014b9f08ef3eecd624259e2876dfbe25d31604d9::error::swap_exact_yt_amount_mismatch());
        let v8 = swap_exact_pt_for_sy_internal<T0>(arg0, arg2, arg4, arg3.exchange_rate, arg3, arg7, arg8, arg9, arg10);
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::update_user_interest<T0>(0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::treasury(arg6), 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::yield_factory::interest_fee_rate(arg6), arg3.exchange_rate, arg2, arg4, arg9, arg10);
        0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::sy::repay<T0>(v3, v8, arg5);
        arg1
    }

    public fun update_current_exchange_rate<T0: drop>(arg0: 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64::FixedPoint64, arg1: &mut 0xc4f79cde06916585b88df4cb98891bc4aeb66cfc1ede7b8c8597070912659ffd::py::PyState<T0>, arg2: &mut MarketState<T0>, arg3: &0x2::clock::Clock) : 0xd4474b901b4fd49a03515a62482bc498e834c648896a8a77ad69a4b08c9a693::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = get_exchange_rate<T0>(arg1, arg2, arg3, arg0, false);
        arg2.current_exchange_rate = v0;
        v0
    }

    // decompiled from Move bytecode v6
}

