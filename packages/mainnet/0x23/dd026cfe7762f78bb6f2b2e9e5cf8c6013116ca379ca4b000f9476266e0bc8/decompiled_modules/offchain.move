module 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::offchain {
    fun calc_max_pt_in_for_sy_out<T0: drop>(arg0: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketStateCache<T0>, arg1: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketState<T0>) : u64 {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_market_total_pt<T0>(arg1));
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_total_asset<T0>(arg0)), true);
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

    fun calc_max_pt_out_for_sy_in<T0: drop>(arg0: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketStateCache<T0>, arg1: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketState<T0>) : u64 {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::exp(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::mul(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_fee_rate<T0>(arg0), 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_rate_anchor<T0>(arg0)), 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_rate_scalar<T0>(arg0)));
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_market_total_pt<T0>(arg1));
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(v1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::remove_sign(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(v0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(v0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one()))), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_total_asset<T0>(arg0), v1))), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational(999, 1000)))
    }

    fun calc_slope<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign, arg3: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketStateCache<T0>) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(arg2, arg0);
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::add(arg0, arg1);
        assert!(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::less(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero(), v0), 1);
        assert!(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::less(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::zero(), v1), 1);
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_rate_anchor<T0>(arg3), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::mul(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::sub(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::from_uint64((((0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(arg0) as u256) * ((0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(arg1) as u256) + (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(arg2) as u256)) / (((0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v1) as u256) * (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::get_raw_value(v0) as u256)) as u256)) as u64)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::ln(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(v1, v0))), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::math_fixed64_with_sign::div(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64_with_sign::one(), 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_rate_scalar<T0>(arg3))))
    }

    public fun get_approx_pt_out_for_net_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::oracle::PriceVoucher<T0>, arg3: &mut 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::py::PyState<T0>, arg4: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market_global::MarketFactoryConfig, arg5: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::oracle::get_price<T0>(arg2, arg7)), arg3, arg5, arg6);
        let v1 = 1;
        let v2 = calc_max_pt_out_for_sy_in<T0>(&v0, arg5);
        assert!(v2 >= arg1, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::market_insufficient_pt_for_swap());
        let v3 = 0;
        while (v1 <= v2) {
            let v4 = (v2 + v1) / 2;
            let (v5, _, _) = 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::router::get_sy_amount_in_for_exact_pt_out_internal<T0>(v4, &v0, arg4, arg5);
            if (v5 <= arg0) {
                if (v5 >= (((arg0 as u256) * (999000000 as u256) / (1000000000 as u256)) as u64)) {
                    v3 = v4;
                    break
                };
                v1 = v4;
                continue
            };
            v2 = v4 - 1;
        };
        v3
    }

    public fun get_approx_yt_out_for_net_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::oracle::PriceVoucher<T0>, arg3: &mut 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::py::PyState<T0>, arg4: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketState<T0>, arg5: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market_global::MarketFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::oracle::get_price<T0>(arg2, arg7)), arg3, arg4, arg6);
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::sy::sy_to_asset(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_index<T0>(&v0), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg0)));
        let v2 = calc_max_pt_in_for_sy_out<T0>(&v0, arg4);
        assert!(v2 >= arg1, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::market_insufficient_pt_for_swap());
        let v3 = 0;
        let v4 = 0;
        while (v1 < v2) {
            v1 = (v2 + v1) / 2;
            let (v5, _, _) = 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::router::swap_pt_to_sy_out_internal<T0>(v1, &v0, arg5, arg4);
            let v8 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::sy::asset_to_sy_up(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_cached_index<T0>(&v0), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(v1)));
            v4 = v8;
            let v9 = v8 - v5;
            if (v9 <= arg0) {
                if (v9 >= (((arg0 as u256) * (999000000 as u256) / (1000000000 as u256)) as u64)) {
                    v3 = v1;
                    break
                };
                continue
            };
            v2 = v1 - 1;
        };
        (v3, v4)
    }

    public fun single_liquidity_add_pt_out<T0: drop>(arg0: u64, arg1: 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::oracle::PriceVoucher<T0>, arg2: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market_global::MarketFactoryConfig, arg3: &mut 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::py::PyState<T0>, arg4: &0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::market::get_market_state_cache<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::oracle::get_price<T0>(arg1, arg6)), arg3, arg4, arg5);
        let (v1, _, _) = 0x23dd026cfe7762f78bb6f2b2e9e5cf8c6013116ca379ca4b000f9476266e0bc8::router::add_approx_liquidity_single_sy<T0>(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg0), &v0, arg2, arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

