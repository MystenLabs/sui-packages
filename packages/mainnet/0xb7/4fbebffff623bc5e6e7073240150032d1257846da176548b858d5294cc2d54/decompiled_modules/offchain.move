module 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::offchain {
    fun calc_max_pt_in_for_sy_out<T0: drop>(arg0: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketStateCache<T0>, arg1: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>) : u64 {
        let v0 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::from_uint64(0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::get_market_total_pt<T0>(arg1));
        let v1 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::create_from_raw_value(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::get_cached_total_asset<T0>(arg0)), true);
        let v2 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::zero();
        let v3 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::sub(v1, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::one());
        while (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::less(v2, v3)) {
            let v4 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::math_fixed64_with_sign::div(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::add(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::add(v2, v3), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::one()), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::from_uint64(2));
            if (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::less(calc_slope<T0>(v4, v0, v1, arg0), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::zero())) {
                v3 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::sub(v4, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::one());
                continue
            };
            v2 = v4;
        };
        let v5 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::sub(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::math_fixed64_with_sign::mul(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::create_from_rational(96, 100, true), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::add(v0, v1)), v0);
        if (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::greater_or_equal(v2, v5)) {
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::truncate(v5)
        } else {
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::truncate(v2)
        }
    }

    fun calc_max_pt_out_for_sy_in<T0: drop>(arg0: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketStateCache<T0>, arg1: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>) : u64 {
        abort 0
    }

    fun calc_slope<T0: drop>(arg0: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::FixedPoint64WithSign, arg3: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketStateCache<T0>) : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64_with_sign::FixedPoint64WithSign {
        abort 0
    }

    public fun get_approx_pt_out_for_net_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg3: &mut 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::py::PyState<T0>, arg4: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market_global::MarketFactoryConfig, arg5: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public fun get_approx_yt_out_for_net_sy_in_internal<T0: drop>(arg0: u64, arg1: u64, arg2: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg3: &mut 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::py::PyState<T0>, arg4: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>, arg5: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market_global::MarketFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        abort 0
    }

    public fun single_liquidity_add_pt_out<T0: drop>(arg0: u64, arg1: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg2: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market_global::MarketFactoryConfig, arg3: &mut 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::py::PyState<T0>, arg4: &0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

