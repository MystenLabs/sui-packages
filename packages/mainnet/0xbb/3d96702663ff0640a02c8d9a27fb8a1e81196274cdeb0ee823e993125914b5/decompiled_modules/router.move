module 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::router {
    struct SwapYTEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        yt_amount: u64,
        sy_amount: u64,
        exchange_rate: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
    }

    public(friend) fun add_approx_liquidity_single_sy<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign) {
        let v0 = 1;
        let v1 = calc_max_pt_out_for_sy_in<T0>(arg1, arg3);
        while (v0 <= v1) {
            let v2 = (v1 + v0) / 2;
            let (v3, v4, v5, _, _) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::execute_trade_core<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(v2), arg1, arg2, arg3);
            let v8 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::remove_sign(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::neg(v3));
            if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::greater(v8, arg0)) {
                v1 = v2 - 1;
                continue
            };
            let v9 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(v2), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_sy<T0>(arg3)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(v8, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::remove_sign(v4))));
            let v10 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(arg0, v8), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_pt<T0>(arg3) - v2));
            if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::less_or_equal(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(v10, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((999000000 as u128), (1000000000 as u128))), v9) && 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::less_or_equal(v9, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(v10, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((1001000000 as u128), (1000000000 as u128))))) {
                return (v2, v8, v5)
            };
            if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::less_or_equal(v9, v10)) {
                v0 = v2 + 1;
                continue
            };
            v1 = v2 - 1;
        };
        (0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero(), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero())
    }

    public fun add_liquidity_single_sy<T0: drop>(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg7: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg8: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::MarketPosition {
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::check_precondition<T0>(arg0, arg8, arg5, arg6, arg9);
        assert!(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_pt<T0>(arg8) > 0, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_pt_in_for_mint_lp());
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg4, arg10));
        let v1 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::create_position<T0>(arg8, arg9, arg10);
        let v2 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(v0, arg6, arg8, arg9);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::join_sy<T0>(arg8, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::mint_lp_internal<T0>(arg2, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::swap_sy_for_exact_pt_internal<T0>(arg2, arg1, v0, &v2, arg5, arg6, arg7, arg8, arg9, arg10), v0, arg5, arg6, &mut v1, arg8, arg9, arg10));
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::check_market_cap<T0>(arg8);
        assert!(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::lp_amount(&v1) >= arg3, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::insufficient_lp_output());
        v1
    }

    fun calc_max_pt_in_for_sy_out<T0: drop>(arg0: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : u64 {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_pt<T0>(arg1));
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_total_asset<T0>(arg0)), true);
        let v2 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero();
        let v3 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(v1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one());
        while (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::less(v2, v3)) {
            let v4 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(v2, v3), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one()), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(2));
            if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::less(calc_slope<T0>(v4, v0, v1, arg0), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero())) {
                v3 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(v4, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one());
                continue
            };
            v2 = v4;
        };
        let v5 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::mul(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::create_from_rational(96, 100, true), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(v0, v1)), v0);
        if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::greater_or_equal(v2, v5)) {
            0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::truncate(v5)
        } else {
            0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::truncate(v2)
        }
    }

    fun calc_max_pt_out_for_sy_in<T0: drop>(arg0: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : u64 {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::exp(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::mul(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_fee_rate<T0>(arg0), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_rate_anchor<T0>(arg0)), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_rate_scalar<T0>(arg0)));
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_pt<T0>(arg1));
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(v1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::remove_sign(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(v0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(v0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one()))), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_total_asset<T0>(arg0), v1))), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational(999, 1000)))
    }

    fun calc_slope<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(arg2, arg0);
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(arg0, arg1);
        assert!(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::less(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero(), v0), 1);
        assert!(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::less(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero(), v1), 1);
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_rate_anchor<T0>(arg3), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::mul(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64((((0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(arg0) as u256) * ((0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(arg1) as u256) + (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(arg2) as u256)) / (((0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v1) as u256) * (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v0) as u256)) as u256)) as u64)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::ln(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(v1, v0))), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one(), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_rate_scalar<T0>(arg3))))
    }

    fun get_approx_pt_out_for_net_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 1;
        let v1 = calc_max_pt_out_for_sy_in<T0>(arg2, arg4);
        assert!(v1 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_pt_for_swap());
        let v2 = 0;
        let v3 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        let v4 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        while (v0 <= v1) {
            let v5 = (v1 + v0) / 2;
            let (v6, v7, v8) = get_sy_amount_in_for_exact_pt_out_internal<T0>(v5, arg2, arg3, arg4);
            v3 = v7;
            v4 = v8;
            if (v6 <= arg0) {
                if (v6 >= (((arg0 as u256) * (999000000 as u256) / (1000000000 as u256)) as u64)) {
                    v2 = v5;
                    break
                };
                v0 = v5;
                continue
            };
            v1 = v5 - 1;
        };
        (v2, v3, v4)
    }

    public fun get_approx_pt_out_for_net_sy_in_with_price_voucher<T0: drop>(arg0: u64, arg1: u64, arg2: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg3: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg2, arg7)), arg3, arg5, arg6);
        get_approx_pt_out_for_net_sy_in_internal<T0>(arg0, arg1, &v0, arg4, arg5)
    }

    fun get_approx_yt_out_for_net_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : (u64, u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::sy_to_asset(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_index<T0>(arg2), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg0)));
        let v1 = calc_max_pt_in_for_sy_out<T0>(arg2, arg4);
        assert!(v1 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_pt_for_swap());
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        let v5 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        while (v0 < v1) {
            v0 = (v1 + v0) / 2;
            let (v6, v7, v8) = swap_pt_to_sy_out_internal<T0>(v0, arg2, arg3, arg4);
            v4 = v7;
            v5 = v8;
            let v9 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::asset_to_sy_up(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_index<T0>(arg2), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(v0)));
            v3 = v9;
            let v10 = v9 - v6;
            if (v10 <= arg0) {
                if (v10 >= (((arg0 as u256) * (999000000 as u256) / (1000000000 as u256)) as u64)) {
                    v2 = v0;
                    break
                };
                continue
            };
            v1 = v0 - 1;
        };
        (v2, v3, v4, v5)
    }

    public fun get_lp_out_for_single_sy_in<T0: drop>(arg0: u64, arg1: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg1, arg6)), arg2, arg4, arg5);
        let (v1, _, _) = add_approx_liquidity_single_sy<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg0), &v0, arg3, arg4);
        let (v4, v5, v6) = swap_pt_to_sy_out_internal<T0>(v1, &v0, arg3, arg4);
        (get_lp_out_from_mint_lp<T0>(v1, v4, arg4), v5, v6)
    }

    public fun get_lp_out_from_mint_lp<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : u64 {
        if (0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_lp_supply<T0>(arg2) == 0) {
            let v1 = (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math128::sqrt((arg0 as u128) * (arg1 as u128)) as u64);
            assert!(v1 >= 1000, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_liquidity_too_low());
            v1 - 1000
        } else {
            let v2 = (((arg0 as u128) * (0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_lp_supply<T0>(arg2) as u128) / (0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_pt<T0>(arg2) as u128)) as u64);
            let v3 = (((arg1 as u128) * (0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_lp_supply<T0>(arg2) as u128) / (0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_total_sy<T0>(arg2) as u128)) as u64);
            assert!(v2 > 0 && v3 > 0, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_lp_amount_is_zero());
            if (v2 < v3) {
                v2
            } else {
                v3
            }
        }
    }

    fun get_pt_out_for_exact_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 1;
        let v1 = calc_max_pt_out_for_sy_in<T0>(arg2, arg4);
        assert!(v1 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_pt_for_swap());
        let v2 = 0;
        let v3 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        let v4 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        while (v0 <= v1) {
            let v5 = (v1 + v0) / 2;
            let (v6, v7, v8) = get_sy_amount_in_for_exact_pt_out_internal<T0>(v5, arg2, arg3, arg4);
            v3 = v7;
            v4 = v8;
            if (v6 <= arg0) {
                if (v6 >= (((arg0 as u256) * (999000000 as u256) / (1000000000 as u256)) as u64)) {
                    v2 = v5;
                    break
                };
                v0 = v5;
                continue
            };
            v1 = v5 - 1;
        };
        assert!(v2 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_pt_for_swap());
        (v2, v3, v4)
    }

    public fun get_pt_out_for_exact_sy_in_with_price_voucher<T0: drop>(arg0: u64, arg1: u64, arg2: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg3: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg2, arg7)), arg3, arg5, arg6);
        get_pt_out_for_exact_sy_in_internal<T0>(arg0, arg1, &v0, arg4, arg5)
    }

    public fun get_sy_amount_in_for_exact_pt_out<T0: drop>(arg0: u64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg2: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg3: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(arg2, arg3, arg4, arg5);
        get_sy_amount_in_for_exact_pt_out_internal<T0>(arg0, &v0, arg1, arg4)
    }

    public(friend) fun get_sy_amount_in_for_exact_pt_out_internal<T0: drop>(arg0: u64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let (v0, v1, v2, _, _) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::execute_trade_core<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(arg0), arg1, arg2, arg3);
        (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::truncate(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::neg(v0)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v2)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v1)))
    }

    public fun get_sy_amount_in_for_exact_pt_out_with_price_voucher<T0: drop>(arg0: u64, arg1: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        get_sy_amount_in_for_exact_pt_out<T0>(arg0, arg3, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg1, arg6)), arg2, arg4, arg5)
    }

    public fun get_sy_amount_in_for_exact_yt_out<T0: drop>(arg0: u64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock) : (u64, u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(arg3, arg2, arg4, arg5);
        let v1 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::get_sy_amount_in_for_exact_py_out<T0>(arg0, arg3, arg2, arg5);
        let (v2, v3, v4) = swap_pt_to_sy_out_internal<T0>(arg0, &v0, arg1, arg4);
        assert!(v1 > v2, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::repay_sy_in_exceeds_expected_sy_in());
        (v1, v2, v3, v4)
    }

    fun get_sy_amount_in_for_exact_yt_out_internal<T0: drop>(arg0: u64, arg1: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock) : (u64, u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::get_sy_amount_in_for_exact_py_out<T0>(arg0, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg2), arg1, arg5);
        let (v1, v2, v3) = swap_pt_to_sy_out_internal<T0>(arg0, arg2, arg3, arg4);
        assert!(v0 > v1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::repay_sy_in_exceeds_expected_sy_in());
        (v0, v1, v2, v3)
    }

    public fun get_sy_amount_in_for_exact_yt_out_with_price_voucher<T0: drop>(arg0: u64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, _, _) = get_sy_amount_in_for_exact_yt_out<T0>(arg0, arg1, arg2, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg3, arg6)), arg4, arg5);
        assert!(v0 > v1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::repay_sy_in_exceeds_expected_sy_in());
        v0 - v1
    }

    public fun get_sy_amount_out_for_exact_pt_in<T0: drop>(arg0: u64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(arg1, arg2, arg4, arg5);
        get_sy_amount_out_for_exact_pt_in_internal<T0>(arg0, &v0, arg3, arg4)
    }

    fun get_sy_amount_out_for_exact_pt_in_internal<T0: drop>(arg0: u64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : u64 {
        let (v0, _, _, _, _) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::execute_trade_core<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(arg0), arg1, arg2, arg3);
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::truncate(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::neg(v0))
    }

    public fun get_sy_amount_out_for_exact_pt_in_with_price_voucher<T0: drop>(arg0: u64, arg1: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        get_sy_amount_out_for_exact_pt_in<T0>(arg0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg1, arg6)), arg2, arg3, arg4, arg5)
    }

    fun get_sy_amount_out_for_exact_yt_in_internal<T0: drop>(arg0: u64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(arg1, arg2, arg4, arg5);
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::asset_to_sy(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(&v0), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg0))) - get_sy_amount_out_for_exact_pt_in_internal<T0>(arg0, &v0, arg3, arg4)
    }

    public fun get_sy_amount_out_for_exact_yt_in_with_price_voucher<T0: drop>(arg0: u64, arg1: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        get_sy_amount_out_for_exact_yt_in_internal<T0>(arg0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg1, arg6)), arg2, arg3, arg4, arg5)
    }

    public fun get_yt_out_for_exact_sy_in_with_price_voucher<T0: drop>(arg0: u64, arg1: u64, arg2: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg3: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg4: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg2, arg7)), arg3, arg5, arg6);
        let (v1, _, v3, v4) = get_approx_yt_out_for_net_sy_in_internal<T0>(arg0, arg1, &v0, arg4, arg5);
        (v1, v3, v4)
    }

    public fun swap_exact_sy_for_pt<T0: drop>(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg7: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg8: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::check_precondition<T0>(arg0, arg8, arg5, arg6, arg9);
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg4, arg10));
        let v1 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(v0, arg6, arg8, arg9);
        0x2::coin::value<T0>(&arg3);
        assert!(arg2 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_pt_for_swap());
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::join_sy<T0>(arg8, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::swap_sy_for_exact_pt_internal<T0>(arg2, arg3, v0, &v1, arg5, arg6, arg7, arg8, arg9, arg10));
        assert!(arg2 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::wrong_slippage_tolerance());
        arg2
    }

    public fun swap_exact_sy_for_yt<T0: drop>(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg7: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg8: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::YieldFactoryConfig, arg9: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg10: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::check_precondition<T0>(arg0, arg10, arg6, arg7, arg11);
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg5, arg12)), arg7, arg10, arg11);
        let (_, v2) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::borrow_pt_amount<T0>(arg6, arg2, arg7, arg11);
        let v3 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::swap_exact_pt_for_sy_internal<T0>(arg2, arg6, arg7, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(&v0), &v0, arg9, arg10, arg11, arg12);
        0x2::coin::join<T0>(&mut v3, arg4);
        let (_, v5) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::py_amount(arg6);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::mint_py_internal<T0>(0x2::coin::split<T0>(&mut v3, arg3, arg12), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(&v0), arg6, arg7, arg8, arg11, arg12);
        let (_, v7) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::py_amount(arg6);
        assert!(v7 - v5 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::wrong_slippage_tolerance());
        assert!(arg2 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::invalid_yt_approx_out());
        assert!(v7 - v5 >= arg2, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::invalid_yt_approx_out());
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::join_sy<T0>(arg10, v3);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::repay_pt_amount<T0>(arg6, arg7, v2, arg11);
        let v8 = SwapYTEvent<T0>{
            market_state_id : 0x2::object::id<0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>>(arg10),
            expiry          : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_expiry<T0>(arg10),
            yt_amount       : arg2,
            sy_amount       : 0x2::coin::value<T0>(&arg4),
            exchange_rate   : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(&v0),
        };
        0x2::event::emit<SwapYTEvent<T0>>(v8);
        arg2
    }

    public fun swap_exact_yt_for_sy<T0: drop>(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: u64, arg2: u64, arg3: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg5: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::YieldFactoryConfig, arg7: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg8: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::check_precondition<T0>(arg0, arg8, arg3, arg4, arg9);
        let (_, v1) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::py_amount(arg3);
        assert!(v1 >= arg1, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_yt_balance_swap());
        let v2 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg5, arg10)), arg4, arg8, arg9);
        let v3 = swap_exact_yt_for_sy_internal<T0>(arg1, arg3, arg4, &v2, arg6, arg7, arg8, arg9, arg10);
        assert!(0x2::coin::value<T0>(&v3) >= arg2, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::wrong_slippage_tolerance());
        v3
    }

    public(friend) fun swap_exact_yt_for_sy_internal<T0: drop>(arg0: u64, arg1: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::YieldFactoryConfig, arg5: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::borrow_pt_amount<T0>(arg1, arg0, arg2, arg7);
        let v2 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::redeem_py_internal<T0>(arg0, arg0, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3), arg1, arg2, arg4, arg7, arg8);
        assert!(0x2::coin::value<T0>(&v2) > 0, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_sy_amount_is_zero());
        let v3 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::swap_sy_for_exact_pt_internal<T0>(arg0, v2, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3), arg3, arg1, arg2, arg5, arg6, arg7, arg8);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::deposit_to_vault<T0>(arg4, arg2, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::update_user_interest<T0>(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::interest_fee_rate(arg4), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3), arg1, arg2, arg7, arg8), arg8);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::repay_pt_amount<T0>(arg1, arg2, v1, arg7);
        let v4 = SwapYTEvent<T0>{
            market_state_id : 0x2::object::id<0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>>(arg6),
            expiry          : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_expiry<T0>(arg6),
            yt_amount       : arg0,
            sy_amount       : 0x2::coin::value<T0>(&v3),
            exchange_rate   : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3),
        };
        0x2::event::emit<SwapYTEvent<T0>>(v4);
        v3
    }

    public(friend) fun swap_pt_to_sy_out_internal<T0: drop>(arg0: u64, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg2: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>) : (u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let (v0, v1, v2, _, _) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::execute_trade_core<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::neg(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(arg0)), arg1, arg2, arg3);
        (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::truncate(v0), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v2)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v1)))
    }

    public fun swap_sy_for_exact_yt<T0: drop>(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::PriceVoucher<T0>, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg7: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::State, arg8: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::YieldFactoryConfig, arg9: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg10: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::check_precondition<T0>(arg0, arg10, arg5, arg6, arg11);
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::oracle::get_price<T0>(arg4, arg12)), arg6, arg10, arg11);
        let v1 = swap_sy_for_exact_yt_internal<T0>(arg1, arg3, arg5, &v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        assert!(0x2::coin::value<T0>(&arg3) - 0x2::coin::value<T0>(&v1) <= arg2, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::wrong_slippage_tolerance());
        v1
    }

    public(friend) fun swap_sy_for_exact_yt_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::PyPosition, arg3: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketStateCache<T0>, arg4: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::PyState<T0>, arg5: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::State, arg6: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::YieldFactoryConfig, arg7: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_global::MarketFactoryConfig, arg8: &mut 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _, _) = get_sy_amount_in_for_exact_yt_out_internal<T0>(arg0, arg4, arg3, arg7, arg8, arg9);
        assert!(v0 - v1 <= 0x2::coin::value<T0>(&arg1), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_insufficient_sy_in_for_swap_yt());
        let (v4, v5) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::borrow<T0>(v1, arg5, arg10);
        0x2::coin::join<T0>(&mut arg1, v4);
        let (_, v7) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::py_amount(arg2);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::mint_py_internal<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg10), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3), arg2, arg4, arg6, arg9, arg10);
        let (_, v9) = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py_position::py_amount(arg2);
        assert!(v9 - v7 >= arg0, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::swap_exact_yt_amount_mismatch());
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::deposit_to_vault<T0>(arg6, arg4, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::py::update_user_interest<T0>(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::yield_factory::interest_fee_rate(arg6), 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3), arg2, arg4, arg9, arg10), arg10);
        0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::sy::repay<T0>(v5, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::swap_exact_pt_for_sy_internal<T0>(arg0, arg2, arg4, 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3), arg3, arg7, arg8, arg9, arg10), arg5);
        let v10 = SwapYTEvent<T0>{
            market_state_id : 0x2::object::id<0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>>(arg8),
            expiry          : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_expiry<T0>(arg8),
            yt_amount       : arg0,
            sy_amount       : v0 - v1,
            exchange_rate   : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_cached_exchange_rate<T0>(arg3),
        };
        0x2::event::emit<SwapYTEvent<T0>>(v10);
        arg1
    }

    // decompiled from Move bytecode v6
}

